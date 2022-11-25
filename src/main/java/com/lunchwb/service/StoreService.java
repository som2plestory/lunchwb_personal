package com.lunchwb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lunchwb.dao.ReportDao;
import com.lunchwb.dao.ReviewDao;
import com.lunchwb.dao.StoreDao;
import com.lunchwb.dao.VisitedDao;
import com.lunchwb.vo.GPSVo;
import com.lunchwb.vo.ReportVo;
import com.lunchwb.vo.ReviewVo;
import com.lunchwb.vo.StoreVo;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VisitedVo;

@Service
public class StoreService {

	@Autowired
	private StoreDao storeDao; 
	@Autowired
	private VisitedDao visitedDao; 
	@Autowired
	private ReviewDao reviewDao; 
	@Autowired
	private ReportDao reportDao;
	
	
	/* 가게 정보 받아오기 */
	public Map<String, Object> storeInfo(int storeNo, UserVo authUser){
		Map<String, Object> storeMap = new HashMap<>();
		
		///////// 기본 정보 //////////////////////////////////////
		StoreVo storeVo = storeDao.basicStoreInfo(storeNo);
		
		//영업시간
		ArrayList<String> openingHours = new ArrayList<String>();   
		JSONArray jsonArray = new JSONArray(storeVo.getStoreOpeningHours());
		if (jsonArray != null) { 
		    int len = jsonArray.length();
			for (int j = 0; j < len; j++){ 
				openingHours.add(jsonArray.get(j).toString());
			} 
		} 

		storeVo.setOpeningHours(openingHours);
		storeVo.setStoreOpeningHours(null);
		
		//휴식시간
		ArrayList<String> breaktime = new ArrayList<String>();   
		jsonArray = new JSONArray(storeVo.getStoreBreaktime());
		if (jsonArray != null) { 
		    int len = jsonArray.length();
			for (int j = 0; j < len; j++){ 
				breaktime.add(jsonArray.get(j).toString());
			} 
		}

		storeVo.setBreaktime(breaktime);
		storeVo.setStoreBreaktime(null);
		
		storeMap.put("storeVo", storeVo);
		
		
		/////// 나와 이곳 : visit (방문횟수/최근 방문날짜 그룹) /////////////////
		if(authUser != null) {
			int userNo = authUser.getUserNo();
			
			VisitedVo visitedVo = new VisitedVo();
			visitedVo.setUserNo(userNo);
			visitedVo.setStoreNo(storeNo);
			
			visitedVo = visitedDao.recentVisit(visitedVo);
			storeMap.put("visitedVo", visitedVo);
		}
		
		//////////////// 전체 리뷰 ///////////////////////////////////
		List<ReviewVo> reviewList = reviewDao.storeReviews(storeNo);
		storeMap.put("reviewList", reviewList);
		
		//최근 사진 최대 3개
		List<String> imgList = reviewDao.recentImages(storeNo);
		storeMap.put("imgList", imgList);
		
		////////////// 최근 한달 선택된 메뉴 ///////////////////////////
		List<VisitedVo> menuList = visitedDao.recentMenu(storeNo);
		storeMap.put("menuList", menuList);
		
		return storeMap;
	}
	
	
	/* 가게와의 거리 표기 */
	public int storeDistance(int storeNo, GPSVo gpsVo) {
		Map<String, Object> map = new HashMap<>();
		map.put("storeNo", storeNo);
		map.put("gpsVo", gpsVo);
		
		int distance = storeDao.storeDistance(map);
		
		return distance;
	}
	
	
	/* 리뷰 신고 */
	public String reviewReport(ReportVo reportVo, UserVo authUser) {
		String result = "fail";

		int userNo = authUser.getUserNo();
		reportVo.setUserNo(userNo);
		
		int count = reportDao.reviewReport(reportVo);
		if(count > 0) {
			result = "success";
		}
		
		return result;
	}
	
	
	/* 같은 카테 다른 가게 */
	public List<StoreVo> sameCateOtherStores(StoreVo storeVo, GPSVo gpsVo) {
		Map<String, Object> map = new HashMap<>();
		map.put("storeVo", storeVo);
		map.put("gpsVo", gpsVo);
		
		List<StoreVo> otherStores = storeDao.sameCateOtherStores(map);
		System.out.println("다른 가게 정보가 있어? " + otherStores);
		
		return otherStores;
	}
	
	
}
