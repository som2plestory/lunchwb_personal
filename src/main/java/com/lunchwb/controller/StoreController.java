package com.lunchwb.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lunchwb.service.StoreService;
import com.lunchwb.vo.GPSVo;
import com.lunchwb.vo.ReportVo;
import com.lunchwb.vo.StoreVo;
import com.lunchwb.vo.UserVo;

@Controller
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	/*실험용메인*/
	@GetMapping("/genie/main")
	public String GenieMain() {
		return "/main/genie-index-test";
	}
	
	/* 모달 - 가게 정보 받기 */
	@ResponseBody
	@PostMapping("/store/info")
	public Map<String, Object> storeInfo(@RequestBody int storeNo, HttpSession session) {
		logger.info("storeInfo...storeNo={}", storeNo);
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		Map<String, Object> storeMap = storeService.storeInfo(storeNo, authUser);
		
		return storeMap;
	}
	
	
	/* 가게와 나의 거리 */
	@ResponseBody
	@PostMapping("/store/distance")
	public int storeDistance(@RequestBody int storeNo, HttpSession session) {
		logger.info("storeDistance...storeNo={}", storeNo);
		
		GPSVo gpsVo = (GPSVo)session.getAttribute("curr_location");
		
		if(gpsVo == null) {
			return 0;
		}
		
		logger.info("gpsVo={}", gpsVo);
		
		int distance = storeService.storeDistance(storeNo, gpsVo);
		logger.info("distance={}", distance);
		
		return distance;	
	}
	
	
	/* 리뷰 신고 */
	@ResponseBody
	@PostMapping("/store/review/report")
	public String reviewReport(@RequestBody ReportVo reportVo, HttpSession session) {
		logger.info("reviewReport...reportVo={}", reportVo);
		
		String result = "not login";
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		if(authUser != null) {
			result = storeService.reviewReport(reportVo, authUser);
		}
		
		return result;
	}
	
	
	/* 같은 카테 다른 가게(3곳) */
	@ResponseBody
	@PostMapping("/store/sameCate")
	public List<StoreVo> sameCateOtherStores(@RequestBody StoreVo storeVo, HttpSession session){
		logger.info("sameCateOtherStores...storeVo={}", storeVo);
		
		List<StoreVo> otherStores;
		GPSVo gpsVo = (GPSVo)session.getAttribute("curr_location");
		
		otherStores = storeService.sameCateOtherStores(storeVo, gpsVo);
		
		return otherStores;
	}

}
