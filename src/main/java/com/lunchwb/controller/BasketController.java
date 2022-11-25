package com.lunchwb.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lunchwb.service.BasketService;
import com.lunchwb.vo.GPSVo;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.StoreVo;


@RequestMapping("/basket")
@Controller
public class BasketController {
	
	@Autowired
	private BasketService basketService;
	
	private static final Logger logger = LoggerFactory.getLogger(BasketController.class);

	// 로그인 회원 장바구니 그룹 목록 가져오기
	@ResponseBody
	@PostMapping("/getBasketGroup")
	public List<GroupVo> getBasketGroup(@RequestBody int userNo) {
		logger.info("basket group 불러오기");
		
		List<GroupVo> basketGroup = basketService.getBasketGroup(userNo);
		
		return basketGroup;
	}
	
	
	// 현재 장바구니 그룹 세션 저장
	@ResponseBody
	@PostMapping("/setSessionBasketGroup")
	public boolean setSessionBasketGroup(@RequestBody Map<String, Object> basket_group, HttpSession session) {
		logger.info("세션 장바구니 그룹 저장");
		
		boolean result = true;
		
		if (basket_group == null) {
			result = false;
		}
		
		Integer currBasketGroup = (Integer)basket_group.get("curr_basket_group");
		
		if (session.getAttribute("curr_basket_group") != null) {
			session.removeAttribute("curr_basket_group");
		}
		session.setAttribute("curr_basket_group", currBasketGroup);
		
		return result;
		
	}
	
	
	// 페이지 로드시 장바구니 불러오기
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/loadBasket")
	public Map<Integer, List<StoreVo>> loadBasket(HttpSession session) {
		logger.info("장바구니 불러오기");
		
		return (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
	}
	                                                                                                                                                                                                                                                                                          
	
	// 비로그인 회원 장바구니 생성 + 초기 3개 항목 담기
	@ResponseBody
	@PostMapping("/guestMakeBasket")
	public Map<Integer, List<StoreVo>> guestMakeBasket(HttpSession session) {
		logger.info("비로그인 회원 장바구니 생성");
		
		GPSVo curr_location = (GPSVo)session.getAttribute("curr_location");
		
		@SuppressWarnings("unchecked")
		List<Integer> filter_excluded = (List<Integer>)session.getAttribute("filter_excluded");
		
		boolean user = false;
		if (session.getAttribute("authUser") != null) {
			user = true;
		}
					
		Map<Integer, List<StoreVo>> basket = basketService.makeNewbasket();	
		basket.put(0, basketService.addItemsToBasket(basket.get(0), 0, curr_location, filter_excluded, true, user));	

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		session.setAttribute("basket", basket);
		
		return basket;
	}
		
	
	// 로그인 회원 장바구니 생성 + 초기 3개 항목 담기
	@ResponseBody
	@PostMapping("/groupMakeBasket")
	public Map<Integer, List<StoreVo>> groupMakeBasket(@RequestBody List<GroupVo> basketGroup, HttpSession session) {
		logger.info("로그인 회원 장바구니 생성");
		
		GPSVo curr_location = (GPSVo)session.getAttribute("curr_location");
		
		@SuppressWarnings("unchecked")
		List<Integer> filter_excluded = (List<Integer>)session.getAttribute("filter_excluded");
		
		if (basketGroup.size() == 0) {
			GroupVo noGroup = new GroupVo();
			noGroup.setGroupNo(0);
			
			basketGroup.add(noGroup);
		}
		
		Map<Integer, List<StoreVo>> basket = basketService.makeNewbasket(basketGroup);	
		
		for (GroupVo group: basketGroup) {
			Integer groupNo = group.getGroupNo();
			basket.put(groupNo, basketService.addItemsToBasket(basket.get(groupNo), groupNo, curr_location, filter_excluded, true, true));	
		}

		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		session.setAttribute("basket", basket);
		
		return basket;
	}
	
	
	// 다른 가게 추천받기
	@ResponseBody
	@PostMapping("/addMoreStore")
	public Map<Integer, List<StoreVo>> addMoreStore(HttpSession session) {
		logger.info("장바구니 추가 추천");
		
		GPSVo curr_location = (GPSVo)session.getAttribute("curr_location");
		
		@SuppressWarnings("unchecked")
		List<Integer> filter_excluded = (List<Integer>)session.getAttribute("filter_excluded");
		
		boolean user = false;
		if (session.getAttribute("authUser") != null) {
			user = true;
		}
		
		Integer groupNo = (Integer)session.getAttribute("curr_basket_group");
		
		@SuppressWarnings("unchecked")
		Map<Integer, List<StoreVo>> basket = (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
		basket.put(groupNo, basketService.addItemsToBasket(basket.get(groupNo), groupNo, curr_location, filter_excluded, false, user));
		
		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		session.setAttribute("basket", basket);
		
		return basket;
	}
		
	
	// 장바구니에서 항목 삭제 > 세션 반영
	@ResponseBody
	@PostMapping("/deleteFromBasket")
	public Map<Integer, List<StoreVo>> deleteFromBasket(@RequestBody Map<String, Object> deleteStore, HttpSession session) {
		logger.info("장바구니 아이템 삭제");
		
		@SuppressWarnings("unchecked")
		Map<Integer, List<StoreVo>> basket = (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
		Integer groupNo = (Integer)session.getAttribute("curr_basket_group");
		Integer storeNo = (Integer)deleteStore.get("storeNo");
		
		basket.put(groupNo, basketService.deleteBasket(basket.get(groupNo), storeNo));
		
		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		session.setAttribute("basket", basket);
		
		return basket;
	}

	
	// 장바구니 항목 추가 > 세션 반영
	@ResponseBody
	@PostMapping("/addToBasket")
	public Map<Integer, List<StoreVo>> addToBasket(@RequestBody Map<String, Object> addStore, HttpSession session) {
		logger.info("장바구니 항목 추가");

		@SuppressWarnings("unchecked")
		Map<Integer, List<StoreVo>> basket = (Map<Integer, List<StoreVo>>)session.getAttribute("basket");
		Integer groupNo = (Integer)session.getAttribute("curr_basket_group");
		int storeNo = (Integer)addStore.get("storeNo");
		GPSVo gpsVo = (GPSVo)session.getAttribute("curr_location");
		
		basket.put(groupNo,	basketService.addBasket(basket.get(groupNo), storeNo, gpsVo));
		
		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
		session.setAttribute("basket", basket);
		
		return basket;
	}
	
	
	// 장바구니 비우기
	@ResponseBody
	@PostMapping("/clearBasket")
	public void clearBasket(HttpSession session) {
		logger.info("장바구니 비우기");
		
		if (session.getAttribute("basket") != null) {
			session.removeAttribute("basket");
		}
	}
	
	
	// GPS 위치 세션에 저장
	@ResponseBody
	@PostMapping("/setGPS")
	public boolean setGPS(@RequestBody GPSVo gpsVo, HttpSession session) {
		logger.info("GPS 설정하기");
				
		Boolean result;
		
		if (gpsVo == null) {
			result = false;
			
		} else {
			result = true;
		}
		
		if (session.getAttribute("curr_location") != null) {
			session.removeAttribute("curr_location");
		}
		session.setAttribute("curr_location", gpsVo);
		
		return result;
	}
	
	
	// 세션에 필터 없을 때 필터 생성
	@ResponseBody
	@PostMapping("/makeFilterSession")
	public boolean makeFilterSession(HttpSession session) {
		logger.info("세션 필터 생성");
		
		List<Integer> filter_excluded = new ArrayList<>();
		
		session.setAttribute("filter_excluded", filter_excluded);
		
		return true;
	}
	
	
	// 필터 모달에서 저장 버튼 눌렀을 때 > 세션에 값 저장
	@ResponseBody
	@PostMapping("/saveFilterSession")
	public boolean saveFilterSession(@RequestBody List<Integer> filter_excluded, HttpSession session) {
		logger.info("세션 필터 저장");
		
		if (session.getAttribute("filter_excluded") != null) {
			session.removeAttribute("filter_excluded");
		}
		session.setAttribute("filter_excluded", filter_excluded);
		
		return true;
	}
}