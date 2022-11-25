package com.lunchwb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.lunchwb.service.VoteService;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.StoreVo;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VoteVo;

@RequestMapping("/vote")
@Controller
public class VoteController {

	@Autowired
	private VoteService voteService;
	
	private static final Logger logger = LoggerFactory.getLogger(VoteController.class);

	
	// 새 투표 생성하기 페이지로 이동
	@SuppressWarnings("unchecked")
	@RequestMapping("")
	public String newVote(Model model, HttpSession session, HttpServletResponse response) throws IOException {
		logger.info("투표 생성 페이지로 이동");

		Integer groupNo = (Integer)session.getAttribute("curr_basket_group");
		
		// 선택 그룹이 투표 참여 가능한지 확인
		if (groupNo != null) {
			boolean check = voteService.canMakeVote(groupNo);
			
			if (!check) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('선택한 그룹은 오늘 이미 투표가 진행되었습니다.');location.replace('http://localhost:8088/lunchwb/');</script>");
				out.flush(); 
			}
		}
		
		Map<Integer, List<StoreVo>> basket = (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
		UserVo loginUser = (UserVo)session.getAttribute("authUser");
		
		if (loginUser == null || groupNo == null || groupNo == 0 || basket.get(groupNo).size() < 2) {
			return "redirect:/";
		}
		
		List<GroupVo> voteMember = voteService.getVoteMember(groupNo);
		model.addAttribute("voteMember", voteMember);
		
		List<GroupVo> basketGroup = (List<GroupVo>)session.getAttribute("basketGroup");
		for (int i = 0; i < basketGroup.size(); i++) {
			if (basketGroup.get(i).getGroupNo() == groupNo) {
				model.addAttribute("groupName", basketGroup.get(i).getGroupName());
				break;
			}
		}
				
		return "main/vote/newVote";
	}
	
	
	// 투표 만들기
	@ResponseBody
	@PostMapping("/makeVote")
	public int makeVote(@RequestBody Map<String, String> voteData, HttpSession session) throws ParseException {
		logger.info("새 투표 생성하기");

		String voteEndDate = voteData.get("voteEndDate");
		String voteMember = voteData.get("voteMember");
		String currBasket = voteData.get("currBasket");
		String notTodayMember = voteData.get("notTodayMember");
		Double currX = Double.parseDouble(voteData.get("currX"));
		Double currY = Double.parseDouble(voteData.get("currY"));		

		if (voteEndDate.contains(".")) {
			voteEndDate = voteEndDate.substring(0, voteEndDate.indexOf("."));
		}
		
		@SuppressWarnings("deprecation")
		Date date = new Date(voteEndDate);

		UserVo loginUser = (UserVo)session.getAttribute("authUser");
		int groupNo = (Integer)session.getAttribute("curr_basket_group");
		int voteNo = 0;
		
		if (loginUser != null) {
			voteNo = voteService.makeVote(loginUser.getUserNo(), date, voteMember, notTodayMember, currBasket, groupNo, currX, currY);
		}
		
		return voteNo;
	}
	
	
	// 투표 참여중인 회원인지 확인
	@ResponseBody
	@PostMapping("/checkVoteMem")
	public List<String> checkVoteMem(@RequestBody int[] checkVoteMem) {
		logger.info("투표 참여 불가능 회원 확인");
		
		return voteService.checkVoteMember(checkVoteMem);
	}
	
	
	// 투표하기
	@PostMapping("/submitVote")
	public String submitVote(@ModelAttribute VoteVo myVote, HttpSession session) throws JsonProcessingException {
		logger.info("투표하기");

		voteService.submitVote(myVote);
		
		String url = "redirect:/";
		if (session.getAttribute("authUser") == null) {
			url = url + myVote.getVoteNo();
		}
		return url;
	}
	
	
	// 여기갈래요
	@PostMapping("/visitConfirm")
	public String visitConfirm(@ModelAttribute VoteVo visitData) {
		logger.info("여기갈래요");

		voteService.visitConfirm(visitData);
		
		return "redirect:/";
	}
	
	
	// 투표 초기화하기
	@PostMapping("/resetVote")
	public String resetVote(@RequestParam("voteNo") int voteNo) {
		logger.info("투표 초기화하기");

		voteService.cancelVote(voteNo);
		
		return "redirect:/";		
	}
	
	
	// 투표 수정하기페이지 호출
	@PostMapping("/modifyVoteReady")
	public String modifyVoteReady(HttpSession session) {
		logger.info("투표 수정하기로 이동");
		
		UserVo loginUser = (UserVo)session.getAttribute("authUser");
			
		if (loginUser != null) {
			session.setAttribute("modifyState", 99);
		}
		
		return "redirect:/";
	}
	
	
	// 투표 수정하기
	@ResponseBody
	@PostMapping("/modifyVote")
	public boolean modifyVote(@RequestBody Map<String, Object> voteData) {
		logger.info("투표 수정하기");
		
		String voteEndDate = (String)voteData.get("voteEndDate");
		String voteMember = (String)voteData.get("voteMember");
		String notTodayMember = (String)voteData.get("notTodayMember");
		int voteNo = (int)voteData.get("voteNo");
		
		if (voteEndDate.contains(".")) {
			voteEndDate = voteEndDate.substring(0, voteEndDate.indexOf("."));
		}
		
		@SuppressWarnings("deprecation")
		Date date = new Date(voteEndDate);
		
		boolean result = false;
		result = voteService.modifyVote(date, voteMember, notTodayMember, voteNo);
		
		return result;
	}
	
	
	// 투표 > 다른 사람들이랑 먹을래요
	@PostMapping("/escapeVote")
	public String escapeVote(@ModelAttribute VoteVo myVote) {
		logger.info("다른 사람들이랑 먹을래요");
		
		voteService.escapeVote(myVote);
		
		return "redirect:/";
	}
	
	
	// 투표 완료 후 다른 가게로 변경
	@PostMapping("/changeVotedStore")
	public String changeVotedStore(@ModelAttribute VoteVo changeVote) {		
		logger.info("투표한 가게 변경");
	
		voteService.changeVotedStore(changeVote);
		
		return "redirect:/";
	}
	
	
	// 투표 종료하기
	@PostMapping("/finishVote")
	public String finishVote(@RequestParam int voteNo) {
		logger.info("투표종료");
	
		voteService.finishVote(voteNo);
		
		return "redirect:/";
	}
	
	/* --------------------- 매일 00시 00분 15초 db vote 삭제 ----------------------------------------------------- */
	@Scheduled(cron = "15 0 0 * * *") 
	public void deleteVoteMidnight() {
		voteService.deleteVoteMidnight();
	}
}
