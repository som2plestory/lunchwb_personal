package com.lunchwb.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.WebSocketSession;

import com.lunchwb.service.BasketService;
import com.lunchwb.service.NotiService;
import com.lunchwb.vo.GPSVo;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.NotificationVo;
import com.lunchwb.vo.StoreVo;
import com.lunchwb.vo.UserVo;

@RequestMapping("/notice")
@Controller
public class NotiController {
	
	@Autowired
	private NotiService notiService;
	@Autowired
	private BasketService basketService;
	
	private static final Logger logger = LoggerFactory.getLogger(NotiController.class);
	
	
	/*************************** 알림 개수  *******************************************/
	@ResponseBody
	@PostMapping("/count")
	public int notiCount(@RequestBody int userNo) {
		logger.info("notiCount...userNo={}", userNo);
		
		int notiCnt = notiService.notiCount(userNo);
		
		return notiCnt;
	}

	
	/*************************** 소켓......... *******************************************/
	@ResponseBody
	@PutMapping("/alertUpdate/{hostroot}")
	public String alertUpdate(@RequestBody NotificationVo notiVo, @PathVariable(name="hostroot") String root, WebSocketSession socketSession, HttpSession session) {
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		
		return "result";
	}
	
	
	/*************************** 최근 알림 *******************************************/
	@ResponseBody
	@PostMapping("/recent/list")
	public List<NotificationVo> notiList(@RequestBody NotificationVo notiVo){
		logger.info("notiList...notiVo={}", notiVo);
		
		List<NotificationVo> notiList = notiService.notiList(notiVo);
		
		return notiList;
	}
	
	
	/*************************** 그룹 초대 수락 *******************************************/
	@ResponseBody
	@PostMapping("/group/invite/ok")
	public String inviteOk(@RequestBody NotificationVo notiVo, HttpSession session) {
		logger.info("inviteOk...notiVo={}", notiVo);	
		
		String result = notiService.inviteOk(notiVo);
		
		//basket
		if(result == "success") {
			List<GroupVo> basketGroup = (List<GroupVo>)session.getAttribute("basketGroup");
			if(basketGroup != null) {
				
				GroupVo groupVo = new GroupVo();
				groupVo.setGroupNo(notiVo.getGroupNo());
				groupVo.setGroupName(notiVo.getGroupName());
				
				basketGroup = basketService.basketGroupAdd(basketGroup, groupVo);
			}
			
			session.setAttribute("basketGroup", basketGroup);
			
			int groupNo = notiVo.getGroupNo();
			int groupCount = notiVo.getGroupOrder();
			
			if(groupCount > 1) {
				
				GPSVo curr_location = (GPSVo)session.getAttribute("curr_location");
				List<Integer> filter_excluded = (List<Integer>)session.getAttribute("filter_excluded");
				Map<Integer, List<StoreVo>> basket = (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
				
				basket = basketService.addBasketGroup(basket, groupNo);
				basket.put(groupNo, basketService.addItemsToBasket(basket.get(groupNo), groupNo, curr_location, filter_excluded, true, true));
				
				session.setAttribute("basket", basket);
				
			}else {
				if (session.getAttribute("basket") != null) {
					session.removeAttribute("basket");
				}
				session.setAttribute("curr-basket-group", groupNo);
			}
			
		}

		
		return result;
	}
	
	
	/*************************** 그룹 초대 거절 *******************************************/
	@ResponseBody
	@PostMapping("/group/invite/reject")
	public String inviteReject(@RequestBody NotificationVo notiVo) {
		logger.info("inviteReject...notiVo={}", notiVo);
		
		String result = notiService.inviteReject(notiVo);
		
		return result;
	}
	
	/****************************** 알림 확인 *******************************************/
	@ResponseBody
	@PostMapping("/check")
	public String alertCheck(@RequestBody NotificationVo notiVo, HttpSession session) {
		logger.info("alertCheck...notiVo={}", notiVo);
		
		String result = notiService.alertCheck(notiVo.getNotiNo());
		
		//그룹명 변경/ 그룹 강퇴당했을 시 바구니 세션 변경
		if(result == "success" && (notiVo.getNotiType() == 7 || notiVo.getNotiType() == 5)) {
			if(session.getAttribute("basketGroup") != null) {
				session.removeAttribute("basketGroup");
			}
			
			List<GroupVo> basketGroup = basketService.getBasketGroup(((UserVo)session.getAttribute("authUser")).getUserNo());
			session.setAttribute("basketGroup", basketGroup);
		}
		
		return result;
	}
	
}
