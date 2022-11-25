package com.lunchwb.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lunchwb.service.StatService;
import com.lunchwb.vo.AloneVo;
import com.lunchwb.vo.StatVo;
import com.lunchwb.vo.VisitedVo;

@Controller
@RequestMapping(value="/stat")
public class StatController {
	
	@Autowired
	private StatService statService;
	
	private static final Logger logger = LoggerFactory.getLogger(StatController.class);
	
	
	// ============================================ 캘린더 ============================================
	// =============== 달력폼 ===============
	@GetMapping("/statCalendar")
	public String statCalendarForm() {
		
		return "stat/statCalendar";
	};
	
	
	// =============== 달력폼에 방문한 곳 정보가져오기(ajax + json) ===============
	@ResponseBody
	@RequestMapping(value = "/showVstList",method = {RequestMethod.GET,RequestMethod.POST})
	public List<VisitedVo> showVstList(@RequestBody VisitedVo vstVo){
		List<VisitedVo> vstList = statService.showCalendar(vstVo);
	
		return vstList;
	};
	
	// ============================================ 리뷰 ============================================
	// =============== 리뷰내역폼 ===============
	@GetMapping("/reviewList")
	public String reviewListForm() {
		
		return "stat/reviewList";
	};
	
	// =============== 리뷰내역 가져오기 ===============
	@ResponseBody
	@RequestMapping(value="/showReviewList", method = {RequestMethod.GET,RequestMethod.POST})
	public List<AloneVo> reviewListForm(@RequestBody AloneVo aloneVo) {
		// 현재 접속중인 유저의 리뷰들 가져오기
		int userNo = aloneVo.getUserNo();
		List<AloneVo> reviewList = statService.reviewList(userNo);
		
		return reviewList;
	};
	
	// ============================================ 리뷰 수정 ============================================
	// =============== 리뷰수정하기 폼 ===============
	@GetMapping("/modifyReview/{reviewNo}")
	public String modifyReviewForm(@PathVariable("reviewNo")int reviewNo, Model model) {
		AloneVo aloneVo = statService.getReview(reviewNo);
		
		model.addAttribute("aloneVo",aloneVo);
		return "stat/modifyReview";
	};
	
	// =============== 리뷰 수정하기(DB반영) ===============
	@RequestMapping(value = "/modifyReview",method = {RequestMethod.GET,RequestMethod.POST})
	public String modifyReview(@RequestParam int reviewNo, @RequestParam String reviewContent ,
			@RequestParam int userScore, @RequestPart(value = "file", required = false) MultipartFile file) {
		AloneVo aloneVo = new AloneVo(reviewNo,reviewContent,userScore);
		statService.modifyReview(aloneVo,file);
		
		return "stat/reviewList";
	};
	
	// ============================================ 리뷰 삭제 ============================================
	@ResponseBody
	@RequestMapping(value = "/deleteReview",method = {RequestMethod.GET,RequestMethod.POST})
	public String deleteReview(@RequestBody AloneVo aloneVo) {
		int reviewNo = aloneVo.getReviewNo();
		String result = statService.delReviewResult(reviewNo);
		
		return result; 
	};
	
	
	// =============== 따로갔어요폼 ===============
	@GetMapping("/addAlone")
	public String addAloneForm() {
		logger.info("StatController > addAloneForm()");
		return "stat/addReview";
	};
	
	@PostMapping("/addAlone")
	public String addAlone() {
		logger.info("StatController > addAlone()");
		
		return "stat/reviewList";
	};
	

	// ============================================ 통계 ============================================
	// =============== 통계폼 ===============
	@GetMapping("/statChart")
	public String statChartForm() {
		
		return "stat/statChart";
	};
	
	// =============== 차트그리기 ===============
	@ResponseBody
	@RequestMapping(value = "/getStatChart", method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String,List<String>> getStatChart(@RequestBody StatVo statVo){
		Map<String,List<String>> chartMap = statService.getStatChart(statVo);
		
		return chartMap;
	};
	
	
	
	
}

