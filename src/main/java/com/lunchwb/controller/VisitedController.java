package com.lunchwb.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lunchwb.service.VisitedService;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.ReviewVo;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VisitedVo;

@RequestMapping("/visited")
@Controller
public class VisitedController {
	
	@Autowired
	private VisitedService visitedService;
	
	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	
	/* 여기갈래요 그룹 멤버 리스트 for selection */
	@ResponseBody
	@PostMapping("members/goWith")
	public List<GroupVo> membersGoWith(@RequestBody int groupNo, HttpSession session){
		logger.info("VisitedController > memberGoWith()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		List<GroupVo> memberList = visitedService.membersGoWith(authUser, groupNo);
		
		return memberList;
	}
	
	
	/* 방문 결정 */
	@PostMapping("decision/{storeNo}/{groupNo}")
	public String decideVisit(@PathVariable("storeNo") int storeNo, @PathVariable("groupNo") int groupNo, 
							  @RequestParam(name="memberList", defaultValue = "") List<Integer> memberList, HttpSession session) {
		logger.info("VisitedController > decideVisit()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		visitedService.decideVisit(storeNo, groupNo, memberList, authUser);
		return "redirect:/";
	}
	
	
	/* 방문 취소 */
	@GetMapping("cancel/{visitedNo}")
	public String cancelVisit(@PathVariable("visitedNo") int visitedNo, HttpSession session) {
		logger.info("VisitedController > decideVisit()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		visitedService.cancelVisit(authUser, visitedNo);
		
		return "redirect:/";
	}
	
	
	/* 방문 결정 후 메인 */
	@GetMapping("/")
	public String visitedMain(Model model, HttpSession session) {
		logger.info("VisitedController > visitedMain()");
		
		//여기 온 것 자체가 이미 여기갈래요를 했다고 생각할거지만 주소로 들어온다면
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		if(authUser.getUserState() < 4 ) {
			return "redirect: /";
		}
		
		HashMap<String, Object> visitedMap = visitedService.visitedMain(authUser);	
		
		model.addAttribute("visitedMap", visitedMap);
		
		return "/main/visitedMain";
	}
	
	
	/* 리뷰 작성 */
	@PostMapping("/{visitedNo}/review/add")
	public String addReview(@PathVariable("visitedNo") int visitedNo, HttpSession session, ReviewVo reviewVo) {
		logger.info("VisitedController > addReview()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		visitedService.addReview(visitedNo, authUser, reviewVo);
		
		return "redirect:/";
	}
	
	
	/* 같은 카테 다른 가게를 조회할 "그룹 번호"(for 캘린더 - by 방문일자) */
	@ResponseBody
	@PostMapping("/group/byDate")
	public int groupByDate(@RequestBody VisitedVo visitedVo) {
		logger.info("VisitedController > groupByDate()");
		return visitedService.groupByDate(visitedVo);
	}

	

}
