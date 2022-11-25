package com.lunchwb.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lunchwb.service.RandomService;
import com.lunchwb.service.TestService;
import com.lunchwb.service.VisitedService;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.UserVo;

@RequestMapping("/random")
@Controller
public class RandomController {
	
	@Autowired
	TestService testService;
	@Autowired
	RandomService randomService;
	@Autowired
	VisitedService visitedService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@GetMapping("/roulette")
	public String roulette(Model model) {
		
		logger.info("/roulette");
		return "main/random/randomRoulette";
	}
	
	@RequestMapping(value = {"", "/{randomNo}"})
	public String randomMain(Model model,
							HttpSession session,
							@PathVariable(required = false, name = "randomNo") Integer randomNo) throws Exception {
		logger.info("/randomMain");
		
		
		
		if(randomNo == null) {
			return "main/random/randomMain";
		}else {
			Map<String, Object> randomInfo = randomService.checkAllRandomResult(randomNo);
			
			if(randomInfo == null) {
				return "main/random/randomMain";
			}else {
				model.addAllAttributes(randomInfo);
				return "main/random/randomRouletteResult";
			}
		}
		
	}
	
	@ResponseBody
	@RequestMapping("/getGroupName")
	public String getGroupName(@RequestBody String groupNo, HttpSession session) {
		logger.info("/getGroupName");
		System.out.println("groupNo = " + groupNo);
		int intGroupNo = Integer.parseInt(groupNo);
		
		System.out.println(intGroupNo);
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		GroupVo nowGroup = testService.getGroupName(intGroupNo);
		
		String groupName = nowGroup.getGroupName();
		System.out.println("groupName = " + groupName);
		return groupName;
	}
	
	@ResponseBody
	@RequestMapping("/randomResult")
	public String randomResult(@RequestBody String groupNo, HttpSession session) {
		logger.info("/randomResult");
		
		int intGroupNo = Integer.parseInt(groupNo);
		System.out.println(intGroupNo);
		
		String result = testService.updateRandomState3(intGroupNo);
		System.out.println("groupNo = " + groupNo);
		System.out.println("result = " + result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/makeRandomResult")
	public int randomResult(@RequestBody Map<String, String> randomData, HttpSession session) {
		System.out.println("랜덤 정보 = " + randomData);
		
		int stopAtValue = Integer.parseInt(randomData.get("stopAt"));
		String currBasket = randomData.get("currBasket");
		int currBasketGroup = Integer.parseInt(randomData.get("currBasketGroup"));
		int creatorUserNo = Integer.parseInt(randomData.get("creatorNo"));
		
		System.out.println("룰렛 각도 = " + stopAtValue);
		System.out.println("현재 장바구니 = " + currBasket);
		System.out.println("현재 장바구니 그룹 = " + currBasketGroup);
		System.out.println("랜덤 제작자 = " + creatorUserNo);
		
		UserVo loginUser = (UserVo)session.getAttribute("authUser");
		
		int randomNo = 0;
		if (loginUser != null) {
			randomNo = randomService.makeResult(stopAtValue, currBasket, currBasketGroup, creatorUserNo);
		}
		
		return randomNo;
	}
	
	/* 방문 결정 */
	@PostMapping("decision/{storeNo}/{groupNo}")
	public String decideVisit(@PathVariable("storeNo") int storeNo, @PathVariable("groupNo") int groupNo, 
							  @RequestParam(name="memberList", defaultValue = "") List<Integer> memberList, HttpSession session) {
		logger.info("VisitedController > decideVisit()");
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		int randomNo = (randomService.checkRandomResult(authUser.getUserNo())).getRandomNo();
		visitedService.decideVisit(storeNo, groupNo, memberList, authUser);
		return "redirect:/random/" + randomNo;
	}
	
	
	/* 매일 자정 랜덤 정보 삭제 */
	@Scheduled(cron = "0 0 0 * * *") 
	public void deleteRandomInfo() {
		randomService.deleteRandomInfo();
	}
	
	/* 추후에 사용자가 많아져서 데이터가 많이 쌓이게 되면 실행할 컨트롤러.
	// 15분마다 30분 넘은 랜덤 정보 삭제 
	@Scheduled(cron = "0 0/15 * * * *") 
	public void deleteRandomInfoQuarter() {
		randomService.deleteRandomInfoOverHalf();
	}
	*/
}