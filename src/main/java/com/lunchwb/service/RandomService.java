package com.lunchwb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lunchwb.dao.RandomDao;
import com.lunchwb.dao.TestDao;
import com.lunchwb.dao.UserDao;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.RandomVo;
import com.lunchwb.vo.StoreVo;

@Service
public class RandomService {

	@Autowired
	RandomDao randomDao;
	@Autowired
	TestDao testDao;
	@Autowired
	UserDao userDao;
	
	// 랜덤 결과 저장하기
	public int makeResult(int stopAtValue, String currBasket, int currBasketGroup, int creatorUserNo) {
		System.out.println("**********************************************************************************************************************************************************");
		System.out.println("랜덤 결과 저장하기");
		///////////////////////////////////////// 조회 /////////////////////////////////////////

		RandomVo checkRandomVo = randomDao.checkRandomResult(creatorUserNo);
		System.out.println("기존의 랜덤 결과를 조회합니다 : " + checkRandomVo);
		
		///////////////////////////////////////// 삭제 /////////////////////////////////////////
		if(checkRandomVo != null) {
			randomDao.deleteRandomResult(creatorUserNo);
		}
		
		///////////////////////////////////////// 생성 /////////////////////////////////////////		
		RandomVo randomVo = new RandomVo();
		
		// 룰렛을 진행한 그룹명 알아내기
		GroupVo groupName = testDao.getGroupName(currBasketGroup);
		randomVo.setGroupName(groupName.getGroupName());
		
		// 결과 각도
		randomVo.setStopAtValue(stopAtValue);
		

		// 장바구니에 담긴 가게
		
		JSONArray basketArray = new JSONArray(currBasket);
		randomVo.setStoreInfo(basketArray.toString());
		
		// 랜덤 돌린 유저
		randomVo.setUserNo(creatorUserNo);
		
		System.out.println(randomVo.toString());
		
		int randomNo = randomDao.insertRandomResult(randomVo);
		
		System.out.println("randomNo = " + randomNo);
		
		
		return randomNo;
	}
	
	// 랜덤 결과 조회 (저장된 랜덤 정보가 있는지 randomNo로 확인)
	public RandomVo checkRandomResult(int userNo) {
		RandomVo randomVo = randomDao.checkRandomResult(userNo);
		return randomVo;
	}
	
	// 랜덤 정보 조회 (jsp사용을 위한 정보 추출)
	public Map<String, Object> checkAllRandomResult(int randomNo) throws Exception {
		
		Map<String, Object> randomInfo = new HashMap<>();
		
		RandomVo checkAllRandomResult = randomDao.checkAllRandomResult(randomNo);
		
		// userState가 4가 아니면 RandomVo 데이터 삭제
		// userState 조회
		int userState = userDao.selectUserState(checkAllRandomResult.getUserNo());
		System.out.println("랜덤 정보 조회 중 유저 상태입니다 = " + userState);
		
		if(userState != 4) {
			// 랜덤 정보가 있는지 다시 한 번 조회
			RandomVo checkRandomVo = randomDao.checkRandomResult(checkAllRandomResult.getUserNo());
			System.out.println("기존의 랜덤 결과를 조회합니다 : " + checkRandomVo);
			
			// 유저 상태가 4가 아닌데, Random에 자료가 있다면 삭제.
			if(checkRandomVo != null) {
				randomDao.deleteRandomResult(checkAllRandomResult.getUserNo());
			}
			
			// Random에 자료가 있든 없든 null 반환.
			randomInfo = null;
		}else {
			
			// 가게 정보
			JSONArray storeInfo = new JSONArray(checkAllRandomResult.getStoreInfo());
			List<StoreVo> rouletteStoreInfo = new ArrayList<>();
			for (int i = 0; i < storeInfo.length(); i++) {
				// 장바구니 정보 파싱
				StoreVo store = new StoreVo();
				JSONObject jstore = (JSONObject)storeInfo.getJSONObject(i);
				
				String storeName = jstore.getString("storeName");
				if (storeName.length() >= 13) {
					storeName = storeName.substring(0, 13);
					if (storeName.charAt(storeName.length()-1) == ' ') storeName = storeName.substring(0, storeName.length()-1);
				}
				store.setStoreName(storeName);
				store.setStoreNo(jstore.getInt("storeNo"));
				store.setDistance(jstore.getInt("distance"));
				store.setMenu2ndCateName(jstore.getString("menu2ndCateName"));
				store.setStoreX(jstore.getDouble("storeX"));
				store.setStoreY(jstore.getDouble("storeY"));
				
				rouletteStoreInfo.add(store);
			}
			checkAllRandomResult.setRouletteStoreInfo(rouletteStoreInfo);
			ObjectMapper mapper = new ObjectMapper();
			String store = mapper.writeValueAsString(rouletteStoreInfo);
			// randomData에 자료 넣기
			
			randomInfo.put("stopAtValue", checkAllRandomResult.getStopAtValue());
			randomInfo.put("randomNo", checkAllRandomResult.getRandomNo());
			randomInfo.put("groupName", checkAllRandomResult.getGroupName());
			randomInfo.put("groupNo", checkAllRandomResult.getGroupNo());
			randomInfo.put("basketInfo", rouletteStoreInfo);
			randomInfo.put("storeInfo", store);
			
			System.out.println("스토어 정보 = " + store);
			System.out.println("그룹 넘버 = " + randomInfo.get("groupNo"));
			
		}
		return randomInfo;
	}
	
	public void deleteRandomInfo() {
		randomDao.deleteRandomInfo();
	}
	public void deleteRandomInfoOverHalf() {
		randomDao.deleteRandomInfoOverHalf();
	}
}
