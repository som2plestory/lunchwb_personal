package com.lunchwb.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lunchwb.dao.BasketDao;
import com.lunchwb.dao.GroupDao;
import com.lunchwb.dao.StoreDao;
import com.lunchwb.vo.GPSVo;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.StoreVo;

@Service
public class BasketService {

	@Autowired
	private GroupDao groupDao;	
	@Autowired
	private BasketDao basketDao;
	@Autowired
	private StoreDao storeDao;
	
	
	// 초기 로드 시 장바구니 그룹 선택
	public List<GroupVo> getBasketGroup(int userNo) {
		List<GroupVo> basketGroup = new ArrayList<>();
		basketGroup = groupDao.selectBasketGroup(userNo);
		
		return basketGroup;
	}
	
	
	// 비회원 새 장바구니 만들기
	public Map<Integer, List<StoreVo>> makeNewbasket() {
		Map<Integer, List<StoreVo>> basket = new HashMap<>();	
		basket.put(0, new ArrayList<>());
						
		return basket;
	}
	
	
	// 회원 새 장바구니 만들기
	public Map<Integer, List<StoreVo>> makeNewbasket(List<GroupVo> basketGroup) {
		Map<Integer, List<StoreVo>> basket = new HashMap<>();	
		
		for (GroupVo group: basketGroup) {
			basket.put(group.getGroupNo(), new ArrayList<>());
		}
		
		return basket;
	}
	
	
	// 회원 장바구니 그룹 추가
	public Map<Integer, List<StoreVo>> addBasketGroup(Map<Integer, List<StoreVo>> basket, Integer groupNo) {		
		basket.put(groupNo, new ArrayList<>());
				
		return basket;
	}
	
	
	// 회원 장바구니 그룹 제거
	public Map<Integer, List<StoreVo>> deleteBasketGroup(Map<Integer, List<StoreVo>> basket, Integer groupNo) {
		basket.remove(groupNo);
		
		return basket;
	}
	
	
	// 장바구니에 아이템 3개 추가하기
	public List<StoreVo> addItemsToBasket(List<StoreVo> basket, Integer groupNo, GPSVo curr_location, List<Integer> filter_excluded, boolean firstTime, boolean user) {
		Map<String, Object> basketInput = new HashMap<>();
		basketInput.put("basket", basket);
		basketInput.put("curr_location", curr_location);
		//basketInput.put("curr_location", new GPSVo(126.9520316, 37.4810793, ""));
		basketInput.put("filter_excluded", filter_excluded);
		basketInput.put("groupNo", groupNo);
		
		List<StoreVo> basketItem = null;
		if (user) {
			if (groupNo == 0) {
				// 이후에 알고리즘 추가
				basketItem = basketDao.guestStoreRecommend(basketInput);
				
			} else {
				basketItem = basketDao.groupStoreRecommend(basketInput);
			}
			
		} else {
			basketItem = basketDao.guestStoreRecommend(basketInput);
		}
		
		Calendar cal = Calendar.getInstance();
		int day = (cal.get(Calendar.DAY_OF_WEEK)+5) % 7;
		
		int i = 0;
		
		for (StoreVo store: basketItem) {
			ArrayList<String> opening = new ArrayList<String>();   
			JSONArray jsonArray = new JSONArray(store.getStoreOpeningHours());
			if (jsonArray != null) { 
			    int len = jsonArray.length();
				for (int j = 0; j < len; j++){ 
					opening.add(jsonArray.get(j).toString());
				} 
			} 
			
			ArrayList<String> breakTime = new ArrayList<String>();   
			jsonArray = new JSONArray(store.getStoreOpeningHours());
			if (jsonArray != null) { 
			    int len = jsonArray.length();
				for (int j = 0; j < len; j++){ 
					breakTime.add(jsonArray.get(j).toString());
				} 
			}

			store.setOpeningHours(opening);
			store.setBreaktime(breakTime);
			store.setStoreBreaktime(null);
			store.setStoreOpeningHours(null);
			
			String storeName = store.getStoreName();

			if (storeName.length() > 15) {
				String[] names = storeName.split(storeName);
				if (names.length > 2) storeName = names[0] + " " + names[1];								
				if (storeName.length() > 15 && names.length > 1) storeName = names[0]; 				
				if (storeName.length() > 15) storeName = storeName.substring(0, 15);				
				if (storeName.charAt(storeName.length()-1) == ' ') storeName = storeName.substring(0, storeName.length()-1);
				
				store.setStoreName(storeName);
			}			
			
			String today = jsonArray.get(day).toString();
			
			String time = "00";
			if (today.contains("~")) {
				time = today.substring(0, today.indexOf(":"));
			}
						
			if (!today.equals("휴무일") && Integer.parseInt(time) <= 12) {
				if (firstTime) {
					store.setStored(true);
				} else {
					store.setStored(false);
				}
				basket.add(store);
				i++;
			}
			if (i >= 3 || basket.size() >= 15) break;
		}
		
		return basket;
	}
	
	
	// 장바구니에서 아이템 삭제
	public List<StoreVo> deleteBasket(List<StoreVo> basketItems, Integer storeNo) {
		for (StoreVo store: basketItems) {
			if (store.getStoreNo() == storeNo) {
				store.setStored(false);
				break;
			}
		}

		return basketItems;
	}
	
	
	// 장바구니에 아이템 추가
	public List<StoreVo> addBasket(List<StoreVo> basketItems, int storeNo, GPSVo gpsVo) {
		int cnt = 0;

		for (int i = 0; i < basketItems.size(); i++) {
			StoreVo store = basketItems.get(i);

			if (store.getStoreNo() == storeNo) {
				store.setStored(true);
				basketItems.set(i, store);
				cnt++;
				
				break;
			}
		}

		if (cnt == 0 && basketItems.size() < 15) {
			Map<String, Object> map = new HashMap<>();
			map.put("gpsVo", gpsVo);
			map.put("storeNo", storeNo);
			
			StoreVo newStore = storeDao.selectOneStore(map);
		    			
			ArrayList<String> opening = new ArrayList<String>();   
			JSONArray jsonArray = new JSONArray(newStore.getStoreOpeningHours());
			if (jsonArray != null) { 
			    int len = jsonArray.length();
				for (int j = 0; j < len; j++){ 
					opening.add(jsonArray.get(j).toString());
				} 
			} 
			
			ArrayList<String> breakTime = new ArrayList<String>();   
			jsonArray = new JSONArray(newStore.getStoreOpeningHours());
			if (jsonArray != null) { 
			    int len = jsonArray.length();
				for (int j = 0; j < len; j++){ 
					breakTime.add(jsonArray.get(j).toString());
				} 
			}
			
			newStore.setOpeningHours(opening);
			newStore.setBreaktime(breakTime);
			newStore.setStoreBreaktime(null);
			newStore.setStoreOpeningHours(null);
			
			newStore.setStored(true);
					
			basketItems.add(newStore);
		}

		return basketItems;
	}
	
	
	// 세션 장바구니 그룹에 그룹 추가
	public List<GroupVo> basketGroupAdd(List<GroupVo> basketGroup, GroupVo newGroup) {
		basketGroup.add(newGroup);
		
		return basketGroup;
	}
	
	
	// 세션 장바구니 그룹에 그룹 제거
	public List<GroupVo> basketGroupDel(List<GroupVo> basketGroup, Integer groupNo) {
		for (GroupVo group: basketGroup) {
			if (group.getGroupNo() == groupNo) {
				basketGroup.remove(group);
				break;
			}
		}
		
		return basketGroup;
	}
}