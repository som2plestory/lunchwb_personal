package com.lunchwb.controller;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.lunchwb.service.UserService;
import com.lunchwb.service.VisitedService;
import com.lunchwb.service.VoteService;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VoteVo;


@Controller
public class MainController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private VisitedService visitedService;
	@Autowired
	private VoteService voteService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	/* ----- 메인 접근 --------------------------------------------*/
	@RequestMapping(value = {"/", "/{voteNo}"})
	public String main(@PathVariable(required = false) Integer voteNo, 
				       @RequestParam(required = false) VoteVo reload,
				       HttpSession session, HttpServletRequest request, Model model, Device device) throws UnknownHostException {
		
		System.out.println("**********************************************************************************************************************************************************");
		logger.info("MainController");
		System.out.println("**********************************************************************************************************************************************************");
		
		//logger.info("client ip: " + home(request));
		
		int userState = 0;
		Integer userNo = null;
		
		// 회원 userState 다시 확인
		if (session.getAttribute("authUser") != null) { 
			UserVo loginUser = (UserVo)session.getAttribute("authUser");
			userNo = loginUser.getUserNo();
			
			int checkState = userService.checkUserState(userNo);
			
			if (checkState != loginUser.getUserState()) {
				loginUser.setUserState(checkState);
				session.setAttribute("authUser", loginUser);
			}
			userState = loginUser.getUserState();
			
		}
		
		
		// 어느 페이지 로드할 지 결정
		Integer[] stateInfo = userService.mainState(userState, userNo, voteNo);
		userState = stateInfo[0];
		voteNo = stateInfo[1];
		
		Integer modifyState = (Integer)session.getAttribute("modifyState");
		if (modifyState != null && modifyState == 99) {
			userState = 99;
			session.removeAttribute("modifyState");
		}		
		
		model.addAttribute("userState", userState);
		
		Map<String, Object> voteAsideData;
				
		
		switch (userState) {
			case 1:
				voteAsideData = voteService.getVoteAsideData(voteNo, userState);
				model.addAllAttributes(voteAsideData);
				
				return "main/vote/voteProgress";
				
			case 2:
				voteAsideData = voteService.getVoteAsideData(voteNo, userState);
				model.addAllAttributes(voteAsideData);
				
				return "main/vote/watingVote";
				
			case 3:
				voteAsideData = voteService.getVoteAsideData(voteNo, userState);
				model.addAllAttributes(voteAsideData);
				
				return "main/vote/voteResult";
				
			case 4:
				HashMap<String, Object> visitedMap = visitedService.visitedMain((UserVo)session.getAttribute("authUser"));	
				model.addAttribute("visitedMap", visitedMap);
				return "main/visitedMain";
			
			case 99:
				voteAsideData = voteService.getVoteAsideData(voteNo, userState);
				model.addAllAttributes(voteAsideData);
				
				return "main/vote/modifyVote";
				
			case 403:
				return "error/403";
				
			case 404:
				return "error/404";
				
			default:
				return "main/index";
		}
	}
	
	
	/* -------------------- 클라이언트 ip 불러오기 ---------------------------------------------------------------- */
	public static String home(HttpServletRequest request) {	
		request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = request.getHeader("X-FORWARDED-FOR");
		
		if (ip == null) ip = request.getRemoteAddr();
				
		return ip;
	}	
}
