package com.lunchwb.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.lunchwb.api.NaverLoginBo;
import com.lunchwb.service.UserService;
import com.lunchwb.vo.UserVo;

@Controller
public class TestController {
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);

	@RequestMapping("/logger")
	public String root() {
		System.out.println("logger");
		
		logger.trace("/testApi");
		logger.debug("/testApi");
		logger.info("/testApi");
		logger.warn("/testApi");
		logger.error("/testApi");	

		
		return "";
	} 

	@GetMapping("/test")
	public String test() {
		logger.info("test()");
		return "main/random/randomTest";
	}
	
	@GetMapping("/rouletteTest")
	public String rouletteTest() {
		logger.info("test()");
		return "main/random/randomRoulette";
	}
	
	
	/*
	@Scheduled(fixedDelay = 3000) 
	public void testScheduler() {
		System.out.println("되나");
	}
	*/
	
	
	@GetMapping("/mobile")
	public String mobile() {
		return "main/vote/voteProgressMobile";
	}
	
	
	
	

	//////////////////////////////////////////////////////////////////////////
	///////////////////////////추후 삭제 예정////////////////////////////////////
	
	/* 이전 네이버 로그인 백업 
	// SNS 로그인 네이버 //
	@RequestMapping(value="/naverLoginCallback",  method = {RequestMethod.GET,RequestMethod.POST})
	public String userNaverLoginPro(Model model,@RequestParam Map<String,Object> paramMap, @RequestParam String code, @RequestParam String state,HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBo.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBo.getUserProfile(oauthToken);
		ObjectMapper objectMapper =new ObjectMapper();
		
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		System.out.println("apiJson =>"+apiJson);
		
		UserVo naverConnectionCheck = userService.naverConnectionCheck(apiJson.get("email"));
		
		if(naverConnectionCheck == null) { //일치하는 이메일 없으면 가입
			Integer registerCheck = userService.userNaverRegisterPro(apiJson);
			
			if(registerCheck != null && registerCheck > 0) {
				UserVo loginCheck = userService.naverLogin(apiJson);
				session.setAttribute("authUser", loginCheck);
			}else {
			}
			
			return "redirect:./";
		}else if(naverConnectionCheck.getNaverLogin() == null && naverConnectionCheck.getUserEmail() != null) { //이메일 가입 되어있고 네이버 연동 안되어 있을시
			userService.setNaverConnection(apiJson);
			UserVo loginCheck = userService.naverLogin(apiJson);
			session.setAttribute("authUser", loginCheck);
		}else { //모두 연동 되어있을시
			UserVo loginCheck = userService.naverLogin(apiJson);
			session.setAttribute("authUser", loginCheck);
		}
		
		return "redirect:./";
	}
	
	*/
	

	/* 로그인 상태 유지 전 로그인 컨트롤러.
	@PostMapping("/login")
	public String login(@ModelAttribute UserVo userVo, HttpSession session) {
		logger.info("user > login()");
		UserVo authUser = userService.login(userVo);

		if (authUser != null) {
			session.setAttribute("authUser", authUser);
			return "redirect:./";
		} else {
			return "redirect:./login?result=fail";
		}
	}
	*/
	
	/* 로그인 상태 유지 전 로그아웃 컨트롤러
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("user > logout()");
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:./";

	}*/
}
