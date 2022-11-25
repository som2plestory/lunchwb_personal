package com.lunchwb.controller;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.lunchwb.api.GoogleOAuthRequest;
import com.lunchwb.api.GoogleOAuthResponse;
import com.lunchwb.api.NaverLoginBo;
import com.lunchwb.service.BasketService;
import com.lunchwb.service.UserService;
import com.lunchwb.vo.UserVo;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	NaverLoginBo naverLoginBo;
	@Autowired
	private BasketService basketService;
	@Autowired
	@Qualifier("bcryptPasswordEncoder")
	private PasswordEncoder pwEncoder;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@GetMapping("/login")
	public String loginForm(Model model, HttpSession session) {
		logger.info("user > loginForm()");
		String naverAuthUrl = naverLoginBo.getAuthorizationUrl(session);
		model.addAttribute("naverUrl", naverAuthUrl);
		return "user/loginForm";
	}

	@PostMapping("/login")
	public String autoLogin(HttpSession session, UserVo userVo, HttpServletResponse response) {
		logger.info("loginPost...UserVo={}", userVo);
		String returnURL = "";

		if (session.getAttribute("authUser") != null) {
			session.removeAttribute("authUser");
		}

		UserVo authUser = userService.login(userVo);

		if (authUser != null) {

			if (true == pwEncoder.matches(userVo.getUserPassword(), authUser.getUserPassword())) {
				authUser.setUserPassword("");
				session.setAttribute("authUser", authUser);
				returnURL = "redirect:./";
				if (userVo.isAutoLogin()) {
					Cookie cookie = new Cookie("loginCookie", session.getId());

					cookie.setPath("/");
					cookie.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie);
				}

			} else {
				returnURL = "redirect:./login?result=fail";
			}
			session.setAttribute("basketGroup", basketService.getBasketGroup(authUser.getUserNo()));
		} else { // 로그인 실패
			returnURL = "redirect:./login?result=fail";

		}

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		
		 

		return returnURL;
	}

	/* SNS 로그인 네이버 */
	@RequestMapping(value = "/naverLoginCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String userNaverLoginPro(Model model, @RequestParam Map<String, Object> paramMap, @RequestParam String code,
			@RequestParam String state, HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBo.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBo.getUserProfile(oauthToken);
		ObjectMapper objectMapper = new ObjectMapper();

		@SuppressWarnings("unchecked")
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		System.out.println("apiJson =>" + apiJson);

		UserVo snsConnectionCheck = userService.snsConnectionCheck(apiJson.get("email"));

		if (snsConnectionCheck == null) { // 일치하는 이메일 없으면 가입
			model.addAttribute("userEmail", apiJson.get("email"));
			model.addAttribute("snsLogin", apiJson.get("id"));
			return "user/joinFormSNS";
		} else if (snsConnectionCheck.getSnsLogin() == null && snsConnectionCheck.getUserEmail() != null) { // 이메일 가입
			userService.setSNSConnection(apiJson);
			UserVo loginCheck = userService.snsLogin(apiJson);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo())); 
		} else { // 모두 연동 되어있을시
			UserVo loginCheck = userService.snsLogin(apiJson);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
		}

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		
		
		return "redirect:./";
	}

	/* SNS 로그인 카카오 */
	@RequestMapping(value = "/kakaoLoginCallback", method = { RequestMethod.GET })
	public String userKakaoLoginPro(Model model, @RequestParam(value = "code", required = false) String code,
			HttpSession session) throws Exception {
		System.out.println("code  =>" + code);
		String access_Token = userService.getAccessToken(code);

		Map<String, Object> userInfo = userService.getUserInfo(access_Token);
		System.out.println("access_Token => : " + access_Token);
		System.out.println("userInfo  => " + userInfo);
		System.out.println("userInfo  => : " + userInfo.get("email"));

		// SNS 계정과 동일한 이메일이 있는지 확인.
		UserVo snsConnectionCheck = userService.snsConnectionCheck(userInfo.get("email"));
		System.out.println("snsConnectionCheck => : " + snsConnectionCheck);

		if (snsConnectionCheck == null) { // 일치하는 이메일 없으면 가입
			model.addAttribute("userEmail", userInfo.get("email"));
			model.addAttribute("snsLogin", userInfo.get("id"));
			model.addAttribute("access_Token", access_Token); // 회원가입 후 로그인이 바로 진행되기 때문에 로그아웃을 위해 토큰을 같이 넘겨줌.
			return "user/joinFormSNS";

		} else if (snsConnectionCheck.getSnsLogin() == null && snsConnectionCheck.getUserEmail() != null) { // 이메일 가입 되어있고 카카오 연동 안되어 있을시
			userService.setSNSConnection(userInfo); // 카카오에서 보내주는 ID 업데이트.
			UserVo loginCheck = userService.snsLogin(userInfo);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("access_Token", access_Token);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
		} else { // 모두 연동 되어있을시
			UserVo loginCheck = userService.snsLogin(userInfo);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("access_Token", access_Token);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
		}

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		
		

		return "redirect:./";
	}

	/* SNS 로그인 구글 */

	// 구글 로그인창 호출

	@RequestMapping(value = "/googleLoginCallback", method = { RequestMethod.GET })
	public String userGoogleLoginPro(Model model, @RequestParam(value = "code") String authCode,
			HttpServletRequest request, HttpSession session) throws Exception {

		// HTTP Request를 위한 RestTemplate
		RestTemplate restTemplate = new RestTemplate();

		// Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleOAuthRequest googleOAuthRequestParam = new GoogleOAuthRequest();
		googleOAuthRequestParam.setClientId("438267358505-j3dkkelfosq3bi7mo6th93ecq413ftpb.apps.googleusercontent.com");
		googleOAuthRequestParam.setClientSecret("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");
		googleOAuthRequestParam.setCode(authCode);
		googleOAuthRequestParam.setRedirectUri("http://localhost:8088/lunchwb/googleLoginCallback");
		googleOAuthRequestParam.setGrantType("authorization_code");

		// JSON 파싱을 위한 기본값 세팅
		// 요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

		// AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token",
				googleOAuthRequestParam, String.class);

		// Token Request
		GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
		});

		// ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
		String jwtToken = result.getIdToken();
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
				.queryParam("id_token", jwtToken).toUriString();

		String resultJson = restTemplate.getForObject(requestUrl, String.class);

		Map<String, String> googleInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>() {
		});
		
		Map<String, Object> userInfo = new HashMap<String, Object>();

		System.out.println("jwtToken = " + jwtToken);
		System.out.println("requestUrl = " + requestUrl);
		System.out.println("resultJson = " + resultJson);
		System.out.println("userInfo = " + userInfo);
		
		userInfo.put("email", googleInfo.get("email"));
		userInfo.put("id", googleInfo.get("kid"));
		

		// SNS 계정과 동일한 이메일이 있는지 확인.
		UserVo snsConnectionCheck = userService.snsConnectionCheck(userInfo.get("email"));
		System.out.println("snsConnectionCheck => : " + snsConnectionCheck);

		if (snsConnectionCheck == null) { // 일치하는 이메일 없으면 가입zhemfk
			model.addAttribute("userEmail", userInfo.get("email"));
			model.addAttribute("snsLogin", userInfo.get("id"));
			return "user/joinFormSNS";

		} else if (snsConnectionCheck.getSnsLogin() == null && snsConnectionCheck.getUserEmail() != null) { // 이메일은 존재하나 구글과 연동 안되어 있을시
			userService.setSNSConnection(userInfo); // 카카오에서 보내주는 ID 업데이트.
			UserVo loginCheck = userService.snsLogin(userInfo);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
		} else { // 모두 연동 되어있을시
			UserVo loginCheck = userService.snsLogin(userInfo);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
		}

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}

		return "redirect:./";

	}

	/* SNS 회원가입 추가정보 입력 */
	@RequestMapping(value = "/joinSNS", method = RequestMethod.POST)
	public String joinSNS(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		Integer registerCheck = userService.userJoinSns(paramMap);
		System.out.println(registerCheck);

		// 카카오 회원가입일 경우에 로그아웃을 대비하여 토큰값을 받아주어야함.
		String access_Token = (String) paramMap.get("access_token");

		if (registerCheck != null && registerCheck > 0) { // 회원가입이 되었다면 바로 로그인.
			UserVo loginCheck = userService.snsLogin(paramMap);
			session.setAttribute("authUser", loginCheck);
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginCheck.getUserNo()));
			if (access_Token != null) { // 카카오 회원이라면 토큰값을 세션에 넣어줍니다.
				session.setAttribute("access_Token", access_Token);
			}
			
		} else {
		}
		
		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		
		
		return "user/joinSuccess";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.info("user > logout()");
		String kakaoToken = (String) session.getAttribute("access_Token");
		// System.out.println("로그아웃 카카오 토근 = " + kakaoToken);

		Object obj = session.getAttribute("authUser");
		if (obj != null) {
			UserVo vo = (UserVo) obj;

			if (kakaoToken != null) { // 카카오 계정의 경우 카카오 로그아웃 추가로 실시.
				userService.kakaoLogout(kakaoToken);
				session.removeAttribute("access_Token");
			}

			session.removeAttribute("authUser");
			session.invalidate();

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);

				Date date = new Date(System.currentTimeMillis());
				userService.autoLogin(vo.getUserEmail(), date, session.getId());
			}
		}

		return "redirect:./";

	}

	@GetMapping("/join")
	public String joinForm(HttpServletRequest req) {
		logger.info("user > joinForm()");
		HttpSession session = req.getSession();
		UserVo loginUser = (UserVo) session.getAttribute("authUser");

		if (loginUser != null) {
			session.setAttribute("basketGroup", basketService.getBasketGroup(loginUser.getUserNo()));
			return "redirect:/lunchwb";
		} else {
			return "user/joinForm";
		}
	}

	@PostMapping("/join")
	public String join(@ModelAttribute UserVo userVo, HttpSession session) {
		logger.info("joinPost...UserVo={}", userVo);

		String rawPw = userVo.getUserPassword(); // 복호화 전 비밀번호
		String encodePw = pwEncoder.encode(rawPw); // 복호화 후 비밀번호

		userVo.setUserPassword(encodePw);

		System.out.println(userVo);

		UserVo authUser = userService.join(userVo);

		if (authUser != null) {
			session.setAttribute("authUser", authUser);
			return "user/joinSuccess";
		} else {
			return "redirect:./join?result=fail";
		}
	}

	@GetMapping("/user/checkUser")
	public String checkUser(HttpSession session) {
		logger.info("user > checkUser()");
		UserVo loginUser = (UserVo) session.getAttribute("authUser");

		if (loginUser != null) { // 로그인 했다면
			UserVo checkSNSUser = userService.checkSNS(loginUser.getUserEmail());
			System.out.println(checkSNSUser);
			if (checkSNSUser.getSnsLogin() != null) {
				session.setAttribute("userInfo", checkSNSUser);
				return "user/userInfoSNS";
			} else {

				session.setAttribute("userInfo", loginUser);
				return "user/checkUserInfo";
			}
		} else { // 로그인을 하지 않았다면 로그인 화면으로
			return "redirect:/lunchwb/login";
		}

	}

	@PostMapping("/user/userInfo/")
	public String userInfo(HttpSession session, @RequestParam("userPassword") String password) {
		logger.info("user > checkUser()");
		UserVo authUser = (UserVo) session.getAttribute("authUser");
		UserVo checkUser = new UserVo();
		UserVo userInfo;

		String returnURL = "";
		System.out.println(authUser.getUserEmail());
		checkUser = userService.login(authUser);
		System.out.println("checkUser = " + checkUser);

		System.out.println("비밀번호 일치 : " + pwEncoder.matches(password, checkUser.getUserPassword()));

		if (authUser != null) {
			if (true == pwEncoder.matches(password, checkUser.getUserPassword())) {
				userInfo = userService.getUserInfo(checkUser);
				if (userInfo != null) {
					checkUser.setUserPassword("");
					session.setAttribute("userInfo", userInfo);
					returnURL = "user/userInfo";
				} else {
					returnURL = "redirect:../checkUser";
				}
			}
		}
		return returnURL;
	}

	/* 회원가입 유저 회원정보 수정 */
	@PostMapping("user/modifyUser")
	public String modifyUser(@ModelAttribute UserVo userVo, HttpSession session) {
		logger.info("modifyUser...Uservo={}", userVo);
		System.out.println(userVo);

		String rawPw = userVo.getUserPassword(); // 복호화 전 비밀번호
		String encodePw = pwEncoder.encode(rawPw); // 복호화 후 비밀번호

		userVo.setUserPassword(encodePw);

		UserVo authUser = userService.modifyUser(userVo);

		if (authUser != null) {
			session.setAttribute("authUser", authUser);
			session.removeAttribute("userInfo");
			return "redirect:./checkUser";
		} else {
			return "redirect:./";
		}
	}

	/* SNS 유저 회원정보 수정 */
	@PostMapping("user/modifySNSUser")
	public String modifySNSUser(@ModelAttribute UserVo userVo, HttpSession session) {
		logger.info("modifySNSUser...Uservo={}", userVo);
		System.out.println("before = " + userVo);
		UserVo SNSID = (UserVo) session.getAttribute("userInfo");
		userVo.setSnsLogin(SNSID.getSnsLogin());
		System.out.println("after = " + userVo);
		UserVo authUser = userService.modifySNSUser(userVo);

		if (authUser != null) {
			session.setAttribute("authUser", authUser);
			session.removeAttribute("userInfo");
			return "redirect:../";
		} else {
			return "redirect:../";
		}
	}

	/* 비밀번호 찾기 */
	@GetMapping("findPW")
	public String findPW(HttpServletRequest req) {
		logger.info("findPW()");

		HttpSession session = req.getSession();
		UserVo loginUser = (UserVo) session.getAttribute("authUser");

		if (loginUser != null) {
			return "redirect:./";
		} else {
			return "user/findPW";
		}
	}

	@PostMapping("findPW")
	public String findPWPost(@ModelAttribute UserVo userVo) throws Exception {
		String result = userService.findPw(userVo);

		if (result.equals("success")) {
			return "redirect:./login";
		} else {
			return "redirect:./";
		}

	}

	/* Json */
	@ResponseBody
	@PostMapping("/user/checkEmail")
	public String checkEmail(@RequestBody String Email) {
		String result = userService.checkEmail(Email);

		return result;
	}
	
	
	/* --------------------- 매일 자정 db userState 업데이트 ----------------------------------------------------- */
	@Scheduled(cron = "0 0 0 * * *") 
	public void updateUserStateMidnight() {
		userService.updateUserStateSchedule();
	}

}
