package com.lunchwb.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.lunchwb.dao.UserDao;
import com.lunchwb.dao.VoteDao;
import com.lunchwb.vo.UserVo;


@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private VoteDao voteDao;
	@Autowired
	@Qualifier("bcryptPasswordEncoder")
	private PasswordEncoder pwEncoder;

	public UserVo login(UserVo userVo) {
		UserVo authUser = userDao.login(userVo);
		return authUser;
	}

	public UserVo getUserInfo(UserVo userVo) {
		UserVo userInfo = userDao.getUser(userVo);
		return userInfo;
	}

	public UserVo join(UserVo userVo) {
		userDao.join(userVo);
		UserVo authUser = userDao.login(userVo);
		return authUser;
	}

	public UserVo modifyUser(UserVo userVo) {
		int count = userDao.modifyUser(userVo);

		if (count > 0) {
			UserVo authUser = userDao.login(userVo);
			return authUser;
		} else {
			return null;
		}
	}

	/* 자동로그인 */
	public void autoLogin(String sessionId, Date limitDate, String userEmail) {

		Map<String, Object> map = new HashMap<>();
		map.put("sessionId", sessionId);
		map.put("limitDate", limitDate);
		map.put("userEmail", userEmail);

		userDao.autoLogin(map);

	}

	public UserVo selectSession(String sessionId) {
		UserVo autoLogin = userDao.selectSession(sessionId);
		return autoLogin;
	}

	/* SNS 로그인 */
	/* 네이버 */
	public UserVo snsConnectionCheck(Object userEmail) {
		UserVo snsCheck = userDao.snsConnectionCheck(userEmail);
		return snsCheck;
	}

	public UserVo snsLogin(Map<String, Object> apiJson) {
		UserVo snsLogin = userDao.snsLogin(apiJson);
		return snsLogin;
	}

	public void setSNSConnection(Map<String, Object> apiJson) {
		userDao.setSNSConnection(apiJson);
	}

	public int userJoinSns(Map<String, Object> apiJson) {

		int count = userDao.userJoinSns(apiJson);
		return count;
	}

	/* SNS 회원 가입 유저 확인 */
	public UserVo checkSNS(String userEmail) {
		UserVo checkSNSUser = userDao.checkSNSUser(userEmail);
		return checkSNSUser;
	}

	/* SNS 회원 회원정보 수정 */
	public UserVo modifySNSUser(UserVo userVo) {
		int count = userDao.modifySNSUser(userVo);
		System.out.println("userVo = " + userVo);
		if (count > 0) {
			UserVo authUser = userDao.modifyAfterNaverLogin(userVo);
			return authUser;
		} else {
			return null;
		}
	}

	/* JSON */
	public String checkEmail(String userEmail) {

		UserVo emailCheck = userDao.checkEmail(userEmail);

		String result;

		if (emailCheck == null) {
			result = "success";
		} else {
			result = "fail";
		}

		return result;
	}

	/* 카카오 SNS 로그인 */
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=76831635e5a5685d3617238b00847def"); // 본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8088/lunchwb/kakaoLoginCallback"); // 본인이 설정해 놓은 경로
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return access_Token;
	}

	public HashMap<String, Object> getUserInfo(String access_Token) {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			//JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			// 카카오 ID 받아오기
			String id = element.getAsJsonObject().get("id").getAsString();
			// 카카오 Email 받아오기
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			
			System.out.println("id = " + id);
			System.out.println("email = " + email);
			
			userInfo.put("email", email);
			userInfo.put("id", id);

		} catch (IOException e) {
			e.printStackTrace();
		}

		
		return userInfo;
	}

	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/* 비밀번호 */
	public void sendEmail(UserVo userVo, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //구글 이용시 smtp.gmail.com 네이버 이용시 smtp.naver.com
		String hostSMTPid = "lunchwb@gmail.com";
		String hostSMTPpwd = "gnzwzjrgdidbwxjm";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "lunchwb@gmail.com";
		String fromName = "부장님요기요";
		String subject = "부장님 요기요 임시 비밀번호 입니다.";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "부장님요기요 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += userVo.getUserEmail() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += userVo.getUserPassword() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = userVo.getUserEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587 구글 이용시 465

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	
	//비밀번호찾기
	public String findPw(UserVo userVo) throws Exception {
		UserVo ck = userDao.userCheck(userVo.getUserEmail());
		
		// 가입된 이메일이 아니면
		if(ck == null) {
			return "fail";
		}else {
			// 임시 비밀번호 생성
			String userPassword = "";
			for (int i = 0; i < 12; i++) {
				userPassword += (char) ((Math.random() * 26) + 97);
			}
			String encodePw = pwEncoder.encode(userPassword);
			
			userVo.setUserPassword(encodePw);
			// 암호화된 비밀번호로 DB 저장
			userDao.updatePw(userVo);
			
			// 암호화 이전 비밀번호로 발송.
			userVo.setUserPassword(userPassword);
			// 비밀번호 변경 메일 발송
			sendEmail(userVo, "findpw");
			
			return "success";
		}
	}
	
	
	// main controller에서 authUser 다시 확인
	public int checkUserState(int userNo) {
		return userDao.selectUserState(userNo);
	}

	
	// main controller에서 userState 확인 (계속 수정중)
	public Integer[] mainState(int userState, Integer userNo, Integer voteNo) {
		Integer[] stateInfo = new Integer[2];
		
		if (userNo == null) {
			if (voteNo != null) {
				Integer state = voteDao.selectGuestVoteState(voteNo);
				
				if (state == null) {
					userState = 404;
					
				} else {
					userState = state;
					
					Map<String, Object> map = new HashMap<>();
					map.put("voteNo", voteNo);
					System.out.println(voteNo);
					System.out.println(map.toString());
				}
			} 
			
		} else {
			Integer currVoteNo = voteDao.selectMemberVoteNo(userNo);

			if (voteNo != null) {
				if (!voteNo.equals(currVoteNo)) {
					userState = 403;
				}
				
			} else {				
				if (userState > 0) {
					voteNo = currVoteNo;
				}
			}
		}
		stateInfo[0] = userState;
		stateInfo[1] = voteNo;
		
		return stateInfo;
	}
	
	
	public void updateUserStateSchedule() {
		System.out.println("=================================================================================================================================================");
		System.out.println("회원 userState 초기화");
		System.out.println("=================================================================================================================================================");

		int cnt = userDao.updateAllUsers();
		System.out.println("[회원 " + cnt + "건 수정 완료]");
		
		System.out.println("=================================================================================================================================================");
		System.out.println("=================================================================================================================================================");
	}
}


