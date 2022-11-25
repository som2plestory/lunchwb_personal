package com.lunchwb.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lunchwb.dao.GroupDao;
import com.lunchwb.dao.MenuDao;
import com.lunchwb.dao.ReviewDao;
import com.lunchwb.dao.UserDao;
import com.lunchwb.dao.VisitedDao;
import com.lunchwb.vo.BlacklistVo;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.MenuVo;
import com.lunchwb.vo.ReviewVo;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VisitedVo;

@Service
public class VisitedService {
	
	@Autowired
	private VisitedDao vstDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private UserDao userDao;
	
	
	//THIS IS 즉각적으로 결정했을 경우 (투표 no)
	//그룹원 선택 
	/****************** 여기갈래요> 함께할 그룹 멤버 리스트 for selection *****************/
	public List<GroupVo> membersGoWith(UserVo authUser, int groupNo){
		GroupVo groupVo = new GroupVo();
		groupVo.setUserNo(authUser.getUserNo());
		groupVo.setGroupNo(groupNo);
		
		List<GroupVo> memberList = groupDao.membersGoWith(groupVo);
		
		return memberList;
	}
	
	
	
	/******************************* 여기갈래요 결정 ********************************/
	public void decideVisit(int storeNo, int groupNo, List<Integer> memberList, UserVo authUser) {
		//나 빼고 선택해서 리스트를 가져왔기 때문에
		memberList.add(authUser.getUserNo());
		
		//방문할 그룹 멤버 userState = 4로 변경
		userDao.groupUpdateState4(memberList);
		
		//오늘 방문 저장
		Map<String, Object> map = new HashMap<>();
		map.put("storeNo", storeNo);
		map.put("groupNo", groupNo);
		map.put("memberList", memberList);
		
		vstDao.decideVisit(map);
		
	}
	
	
	/**************************** 여기갈래요 취소(당일만) ******************************/
	public void cancelVisit(UserVo authUser, int visitedNo) {
		//방문 취소
		int userNo = authUser.getUserNo();
		
		VisitedVo visitedVo = new VisitedVo();
		visitedVo.setUserNo(userNo);
		visitedVo.setVisitedNo(visitedNo);
		
		vstDao.cancelVisit(visitedVo);
		
		userDao.updateState0(userNo);
	}
	
	
	/********************* 여기갈래요 후 리뷰 작성 메인페이지 ***************************/
	public HashMap<String, Object> visitedMain(UserVo authUser) {
		HashMap<String, Object> visitedMap = new HashMap<>();
		
		int userNo = authUser.getUserNo();
		
		//오늘 내가 다녀온 곳의 정보
		VisitedVo visitedVo = vstDao.todayStoreInfo(userNo);
		visitedMap.put("visitedVo", visitedVo);
		
		//가게 최근 리뷰 2건(최대)
		int storeNo = visitedVo.getStoreNo();
		List<ReviewVo> reviewList = reviewDao.recentReview(storeNo); 
		visitedMap.put("reviewList", reviewList);
		visitedMap.put("reviewCount", reviewList.size());
		
		//다녀와서 블랙리스트 추가 했는지(있으면 1)
		BlacklistVo blackVo = new BlacklistVo();
		blackVo.setStoreNo(storeNo);
		blackVo.setUserNo(userNo);
		
		//그룹장 여부 체크
		int groupLeader = groupDao.groupLeader(visitedVo.getGroupNo());
		visitedMap.put("groupLeader", groupLeader);
		
		//나의 방문 정보
		VisitedVo vstVo = new VisitedVo();
		vstVo.setUserNo(userNo);
		vstVo.setStoreNo(storeNo);
		
		VisitedVo relVo = vstDao.storeAndMe(vstVo);
		visitedMap.put("relVo", relVo);
		
		//오늘 리뷰를 했나?
		ReviewVo reviewVo = reviewDao.todayReview(userNo);
		if(reviewVo != null) {
			visitedMap.put("reviewVo", reviewVo);
		}
		
		//리뷰 메뉴리스트
		List<MenuVo> menuList = menuDao.menuList(storeNo);
		visitedMap.put("menuList", menuList);
		
		return visitedMap;
	}
	
	
	/********************* 오늘 다녀온 가게 리뷰 작성 ***************************/
	public void addReview(int visitedNo, UserVo authUser, ReviewVo reviewVo) {
		//////////////////// visited > 메뉴 기록 /////////////////////////////
		VisitedVo visitedVo = new VisitedVo();
		visitedVo.setVisitedNo(visitedNo);
		visitedVo.setMenuNo(reviewVo.getMenuNo());
		
		vstDao.todayMenu(visitedVo);
		
		///////////////// 리뷰 저장 ////////////////////////////////
		reviewVo.setUserNo(authUser.getUserNo());
		//리뷰 사진 파일
		MultipartFile file = reviewVo.getFile();
		
		if(!file.isEmpty()) {
			String saveDir = "C:\\javaStudy\\upload";									//윈도우용
			//String saveDir = "/Users/choijungphil/javaStudy/upload";					//맥OS용
			String orgName = file.getOriginalFilename();
			String exName = orgName.substring(orgName.lastIndexOf("."));
			String saveName = System.currentTimeMillis()+UUID.randomUUID().toString()+exName;
			String filePath = saveDir + "\\" + saveName;								//윈도우용
			//String filePath = saveDir + "/" + saveName;								//맥OS용
			
			reviewVo.setReviewFileName(saveName);
			
			try {
				byte[] fileData = file.getBytes();
				OutputStream os = new FileOutputStream(filePath);
				BufferedOutputStream bos = new BufferedOutputStream(os);
				
				bos.write(fileData);
				bos.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//리뷰 작성
		reviewDao.addReview(reviewVo);
	}
	
	
	/*************** 같은 카테 다른 가게를 조회할 "그룹 번호" (for 캘린더 - by 그룹순서) *****************/
	public int groupByDate(VisitedVo visitedVo) {
		return vstDao.groupByDate(visitedVo);
	}
	

}
