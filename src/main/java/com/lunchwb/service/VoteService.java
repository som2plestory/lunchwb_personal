package com.lunchwb.service;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lunchwb.dao.GroupDao;
import com.lunchwb.dao.UserDao;
import com.lunchwb.dao.VisitedDao;
import com.lunchwb.dao.VoteDao;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.StoreVo;
import com.lunchwb.vo.UserVo;
import com.lunchwb.vo.VoteVo;


@Service
public class VoteService {
	
	@Autowired
	private VoteDao voteDao;
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private VisitedDao visitedDao;
	
	public List<GroupVo> getVoteMember(int groupNo) {
		return groupDao.selectVoteMember(groupNo);
	}
	
	
	/////////// 투표 참여 못하는 회원 목록 불러오기 ///////////////////////////////
	public List<String> checkVoteMember(int[] checkMember) {
		List<Integer> checkMem = new ArrayList<>();
		for (int no: checkMember) checkMem.add(no);
		System.out.println(checkMem.toString());
		
		return userDao.selectImpossibleMember(checkMem);
	}
	
	
	
	//////// 해당 그룹이 투표 생성 가능한지 체크 /////////////////////////////////
	
	public boolean canMakeVote(int groupNo) {
		boolean result = true;
		
		if (voteDao.canMakeVote(groupNo) > 0) result = false;
		
		return result;
	}
	
	
	///////// 투표 생성하기 ///////////////////////////////////////////////////////////////////////
	public int makeVote(int userNo, Date voteEndTime, String voteMember, String notTodayMember, String currBasket, int groupNo, double currX, double currY) {
		System.out.println("**********************************************************************************************************************************************************");
		System.out.println("[투표 생성 데이터 정리하기]");
		System.out.println(voteEndTime.toString());
		System.out.println(currBasket);
		
		List<UserVo> voteMem = new ArrayList<>();
		List<UserVo> memberMem = new ArrayList<>();
		List<UserVo> notTodayMem = new ArrayList<>();
		System.out.println(voteMember);

		JSONObject iptData = new JSONObject(voteMember);
		JSONObject notToday = new JSONObject(notTodayMember);
		JSONArray jArray = (JSONArray)iptData.get("mem");
		JSONArray notArray = (JSONArray)notToday.get("mem");
		
		for (int i = 0; i < jArray.length(); i++) {
			JSONObject user = jArray.getJSONObject(i);
			UserVo member = new UserVo();
			
			member.setUserName(user.getString("userName"));
			if (user.has("userNo")) member.setUserNo(user.getInt("userNo"));
						
			if (user.has("userGrade")) {
				int userGrade = user.getInt("userGrade");
				member.setUserGrade(userGrade);
				
				memberMem.add(member);
			}
			voteMem.add(member);
		}		
		
		for (int i = 0; i < notArray.length(); i++) {
			JSONObject user = notArray.getJSONObject(i);
			UserVo member = new UserVo();
			
			member.setUserName(user.getString("userName"));
			member.setUserNo(user.getInt("userNo"));
						
			notTodayMem.add(member);
		}
		
		System.out.println("**********************************[vote 생성하기]**********************************");
		VoteVo voteItems = new VoteVo();
		voteItems.setUserNo(userNo);
		voteItems.setGroupNo(groupNo);
		voteItems.setVoteEndTime(voteEndTime);
		voteItems.setCurrX(currX);
		voteItems.setCurrY(currY);
		
		JSONArray basketArray = new JSONArray(currBasket);
		JSONArray resultArray = new JSONArray();
		
		for (int i = 0; i < basketArray.length(); i++) {
			resultArray.put(0);
		}
		
		voteItems.setVoteItems(basketArray.toString());
		voteItems.setVoteResults(resultArray.toString());
		
		System.out.println(voteItems.toString());
		int voteNo = voteDao.insertNewVote(voteItems);
				
		System.out.println("**********************************[vote_member 생성하기]**********************************");
		// 투표 참여자들
		Map<String, Object> voteMems = new HashMap<>();
		voteMems.put("voteMember", voteMem);
		voteMems.put("voteNo", voteNo);
		
		voteDao.insertVoteMember(voteMems);
		
		// 투표 참여 안하는 사람들
		if (notTodayMem.size() > 0) {
			Map<String, Object> notTodayMems = new HashMap<>();
			notTodayMems.put("voteMember", notTodayMem);
			notTodayMems.put("voteNo", voteNo);
			
			voteDao.insertNotTodayMember(notTodayMems);
		}
		
		System.out.println("**********************************[회원들 user_state 변경하기]**********************************");
		userDao.updateState1(memberMem);
		
		
		return voteNo;
	}

	

	///////// voteAside 필요한 파라미터 불러오기 ////////////////////////////////////////////////////////////
	
	public Map<String, Object> getVoteAsideData(int voteNo, int userState) {
		Map<String, Object> voteData = new HashMap<>();
		
		List<VoteVo> voteVo = voteDao.selectVoteInfo(voteNo);
		Date voteEndTime = voteVo.get(0).getVoteEndTime();
		int voteState = voteVo.get(0).getVoteState();
		
		// 시간 됐으면 투표 종료
		if (voteEndTime.before(new Date()) && voteState < 3) {			
			System.out.println("****************************************************[" + voteNo + "번 투표 종료]*************************************************************");
			voteDao.updateVoteEnd(voteNo);
			voteDao.updateUserEnd(voteNo);
			
			voteVo = voteDao.selectVoteInfo(voteNo);
			voteState = 3;
		}
		
		
		// 끝나는 시각, 가게 정보, 투표 만든 사람
		VoteVo voteInfo = new VoteVo();
		voteInfo.setVoteEndTime(voteEndTime);
		voteInfo.setVoteNo(voteNo);
		voteInfo.setVoteState(voteState);
		voteInfo.setGroupName(voteVo.get(0).getGroupName());
		voteInfo.setVoteMadeUser(voteVo.get(0).getVoteMadeUser());
		voteInfo.setVoteResults(voteVo.get(0).getVoteResults());
		voteInfo.setGroupNo(voteVo.get(0).getGroupNo());
		voteInfo.setCurrX(voteVo.get(0).getCurrX());
		voteInfo.setCurrY(voteVo.get(0).getCurrY());
		
		
		// 장바구니 담긴 가게 정보		
		JSONArray storeInfo = new JSONArray(voteVo.get(0).getVoteItems());
		//JSONArray voteStatus = new JSONArray(voteVo.get(0).getVoteResults());
		
		List<StoreVo> voteStoreInfo = new ArrayList<>();
		List<Integer> voteResult = new ArrayList<>();
		
		for (int i = 0; i < storeInfo.length(); i++) {
			// 장바구니 정보 파싱
			StoreVo store = new StoreVo();
			JSONObject jstore = (JSONObject)storeInfo.getJSONObject(i);
			
			String storeName = jstore.getString("storeName");
			if (storeName.length() > 12) {
				String[] names = storeName.split(storeName);
				if (names.length > 2) storeName = names[0] + " " + names[1];								
				if (storeName.length() > 12 && names.length > 1) storeName = names[0]; 				
				if (storeName.length() > 12) storeName = storeName.substring(0, 12);				
				if (storeName.charAt(storeName.length()-1) == ' ') storeName = storeName.substring(0, storeName.length()-1);
			}
			store.setStoreName(storeName);
			store.setStoreNo(jstore.getInt("storeNo"));
			store.setDistance(jstore.getInt("distance"));
			store.setMenu2ndCateName(jstore.getString("menu2ndCateName"));
			store.setStoreX(jstore.getDouble("storeX"));
			store.setStoreY(jstore.getDouble("storeY"));
			
			voteStoreInfo.add(store);
			
			
			// vote_result 파싱
			//voteResult.add(voteStatus.getInt(i));
		}
		
		voteInfo.setVoteResultList(voteResult);
		
		
		// vote member 데이터 정리
		List<VoteVo> voteMember = new ArrayList<>();
		
		for (VoteVo member: voteVo) {
			VoteVo mem = new VoteVo();
			
			mem.setVoteMemberNo(member.getVoteMemberNo());
			mem.setUserNo(member.getUserNo());
			mem.setUserName(member.getUserName());
			mem.setVoteVoted(member.getVoteVoted());
			mem.setBossCheck(member.getBossCheck());
			mem.setUserGrade(member.getUserGrade());
			
			voteMember.add(mem);
		}
		
				
		// model에 추가할 Map에 데이터 넣기
		voteData.put("voteInfo", voteInfo);
		voteData.put("voteBasket", voteStoreInfo);
		voteData.put("voteMember", voteMember);
		
		
		// 투표 진행상황(userStaet == 2일 때)
		if (userState >= 2) {
			VoteVo currVote = voteDao.currVote(voteNo);
			voteData.put("currVote", currVote);
		}
		
		// 투표 결과 정리한 것(userState == 3일 때)
		if (userState == 3) {
			JSONArray jArray = new JSONArray(voteVo.get(0).getVoteResults());
			List<StoreVo> voteResults = new ArrayList<>();
			
			for (int i = 0; i < jArray.length(); i++) {
				int votes = jArray.getInt(i);
				voteStoreInfo.get(i).setVotes(votes);
				
				int j = 0;
				while (j < voteResults.size()) {
					if (votes > voteResults.get(j).getVotes()) break;
					j++;
				}
				voteResults.add(j, voteStoreInfo.get(i));
			}	
			
			int maxVote = voteResults.get(0).getVotes();
			
			for (int i = 0; i < voteResults.size(); i++) {
				if (voteResults.get(i).getVotes() == maxVote) {
					voteResults.get(i).setVote1st(true);
					
				} else {
					voteResults.get(i).setVote1st(false);
				}
			}
			
			voteData.put("voteResults", voteResults);
		}
				
		return voteData;
	}
	
	
	
	//////// 투표하기 ///////////////////////////////////////////////////////////
	
	public String submitVote(VoteVo myVote) throws JsonProcessingException {
		// 투표 업데이트
		int voteIdx = myVote.getVoteIdx();
		int voteNo = myVote.getVoteNo();
		
		JSONArray jArray = new JSONArray(voteDao.selectVoteResults(voteNo));
		int[] voteResults = new int[jArray.length()];
		
		for (int i = 0; i < jArray.length(); i++) {
			voteResults[i] = jArray.getInt(i);
			
			if (i == voteIdx) voteResults[i]++;
		}
		
		
		ObjectMapper mapper = new ObjectMapper();
		myVote.setVoteResults(mapper.writeValueAsString(voteResults));
		
		voteDao.updateVoteResults(myVote);
				
		// userState, voteVoted 업데이트
		if (myVote.getUserNo() != null) {
			voteDao.updateVoteVoted(myVote);
			userDao.updateState2(myVote.getUserNo());
		
		} else {
			voteDao.updateGuestVoted(myVote);
		}
				
		
		// 만약 내가 마지막 투표자면 투표 종료
		VoteVo currVote = voteDao.currVote(voteNo);
		
		if (currVote.getTotCnt() == currVote.getVotedCnt()) {
			int cnt = voteDao.updateVoteEnd(voteNo);
			
			if (cnt == 1) {
				System.out.println(voteNo + "번 투표 종료");
				
				voteDao.updateUserEnd(voteNo);
				
			} else {
				System.out.println("투표 종료 실패");
			}
		}
		
		return "redirect:/";
	}
	
	
	
	///////////////////// 여기갈래요 누르기 ///////////////////////////////////////////
	
	public void visitConfirm(VoteVo visitData) {	
		List<Integer> voteMember = visitData.getVoteMember();

		System.out.println("[투표 종료]");
		
		int cnt = voteDao.updateUserVisited(visitData.getVoteNo());
		
		System.out.println("[회원 " + cnt + "명 방문 완료로 상태 변경]");
		
		if (voteMember.size() > 0 ) {
			Map<String, Object> map = new HashMap<>();
			map.put("groupNo", visitData.getGroupNo());
			map.put("storeNo", visitData.getStoreNo());
			map.put("voteMember", voteMember);
			
			visitedDao.insertVoteVisit(map);
		}
		
	}
	
	
	///////////////// 투표 취소하기 ///////////////////////////////////////
	
	public void cancelVote(int voteNo) {
		int cnt = voteDao.updateUserReset(voteNo);
		
		if (cnt > 0) {
			System.out.println("[회원 " + cnt + "명 투표 전으로 상태 변경]");
			cnt = voteDao.DeleteVote(voteNo);
			
			if (cnt > 0) System.out.println("[투표가 성공적으로 삭제되었습니다.]");
		
		} else {
			System.out.println("[회원 투표 삭제 실패]");
			
		}
	}
	
	
	///////// 투표 수정하기 ///////////////////////////////////////////////////////////////////////
	
	public boolean modifyVote(Date voteEndTime, String voteMember, String notTodayMember, int voteNo) {
		System.out.println("**********************************************************************************************************************************************************");
		System.out.println("[투표 수정 데이터 정리하기]");
		
		boolean result = true;
		
		System.out.println(voteEndTime.toString());
		
		List<UserVo> voteMem = new ArrayList<>();
		List<UserVo> memberMem = new ArrayList<>();
		List<UserVo> notTodayMem = new ArrayList<>();
		System.out.println(voteMember);

		JSONObject iptData = new JSONObject(voteMember);
		JSONObject notToday = new JSONObject(notTodayMember);
		JSONArray jArray = (JSONArray)iptData.get("mem");
		JSONArray notArray = (JSONArray)notToday.get("mem");
		
		for (int i = 0; i < jArray.length(); i++) {
			JSONObject user = jArray.getJSONObject(i);
			UserVo member = new UserVo();
			UserVo mem = new UserVo();
			
			member.setUserName(user.getString("userName"));
			mem.setUserName(user.getString("userName"));
			
			if (user.has("userNo")) {
				member.setUserNo(user.getInt("userNo"));
				mem.setUserNo(user.getInt("userNo"));
			}
						
			if (user.has("userGrade")) {
				int userGrade = user.getInt("userGrade");
				member.setUserGrade(userGrade);
				mem.setUserGrade(userGrade);
				
				if (userGrade == 1) memberMem.add(mem);
			}			
			voteMem.add(member);
		}		
		
		for (int i = 0; i < notArray.length(); i++) {
			JSONObject user = notArray.getJSONObject(i);
			UserVo member = new UserVo();
			
			member.setUserName(user.getString("userName"));
			member.setUserNo(user.getInt("userNo"));
			
			notTodayMem.add(member);
		}
		
		System.out.println(voteMem.toString());
		System.out.println(notTodayMem.toString());
		
		System.out.println("**********************************************************[vote 수정하기]**********************************************************************");
		
		Map<String, Object> map = new HashMap<>();
		map.put("voteNo", voteNo);
		map.put("voteEndTime", voteEndTime);
		
		int cnt = voteDao.updateVoteEndTime(map);
		if (cnt < 1) return false;
				
		System.out.println("*********************************************************[vote_member 수정하기]*******************************************************************");
		
		// 투표 안가는 멤버들 처리
	    userDao.updateState0(notTodayMem);
	   
	    map = new HashMap<>();
	    map.put("voteNo", voteNo);
	    map.put("notTodayMem", notTodayMem);
	    
	    voteDao.updateModifyMember(map);
		
		// 투표 가는 멤버들 처리
	    map = new HashMap<>();
	    map.put("voteNo", voteNo);
	    map.put("voteMem", memberMem);
	    
		voteDao.deleteNotVoted(map);
		
		map = new HashMap<>();
		map.put("voteMember", voteMem);
		map.put("voteNo", voteNo);
		
		voteDao.insertVoteMember(map);
		
		userDao.updateState1(memberMem);
		
		System.out.println("**********************************************************************************************************************************************************");
	
		
		return result;
	}
	
	
	
	///////// 따로먹을래요 ///////////////////////////////////////////////////////////////////////////////////////////
	
	public void escapeVote(VoteVo myVote) {
		int userNo = myVote.getUserNo();
		int voteVoted = myVote.getVoteVoted();
		
		// userState 0으로 변경
		userDao.updateState0(userNo);
		
		// voteMembers에서 나 삭제
		voteDao.deleteEscape(myVote);
		
		// 투표를 했다면 voteResults에 결과반영
		if (voteVoted != 0) {
			int voteIdx = myVote.getVoteIdx();
			String currVote = myVote.getVoteResults();
			System.out.println("currVote " + currVote);
			
			JSONArray jArray = new JSONArray(currVote);
			jArray.put(voteIdx, jArray.getInt(voteIdx)-1);
			
			currVote = jArray.toString();
			myVote.setVoteResults(currVote);
			System.out.println("변경 후 currVote " + currVote);
			
			voteDao.updateEscapeResult(myVote);
		}
	}
	
	
	////////////// 투표한 가게 다른 가게로 변경 ///////////////////////////////////////////////////////////////////////////////
	
	public void changeVotedStore(VoteVo changeVote) {
		// vote_members 테이블 voteVoted 업데이트
		voteDao.updateVoteVoted(changeVote);
		
		// vote 테이블 vote_results 업데이트
		int newIdx = changeVote.getVoteIdx();
		int currIdx = changeVote.getVoteVotedIdx();
		
		String currVote = changeVote.getVoteResults();
		System.out.println("currVote " + currVote);
		
		JSONArray jArray = new JSONArray(currVote);
		jArray.put(newIdx, jArray.getInt(newIdx)+1);
		jArray.put(currIdx, jArray.getInt(currIdx)-1);
		
		currVote = jArray.toString();
		changeVote.setVoteResults(currVote);
		System.out.println("변경 후 currVote " + currVote);
				
		voteDao.updateVoteResults(changeVote);
	}
	
	
	/////////////// 시간 다 돼서 투표 종료하기 ///////////////////////////////////////////////////////////////////////////////////////////
	
	public void finishVote(int voteNo) {
		voteDao.updateVoteEnd(voteNo);
		voteDao.updateUserEnd(voteNo);
	}
	
	
	////////// 매일 자정 투표 삭제하기 //////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void deleteVoteMidnight() {
		System.out.println("=================================================================================================================================================");
		System.out.println("어제 투표 삭제");
		System.out.println("=================================================================================================================================================");

		int cnt = voteDao.deleteVoteMidnight();
		
		System.out.println("[투표 " + cnt + "건 삭제 완료]");
		
		System.out.println("=================================================================================================================================================");
		System.out.println("=================================================================================================================================================");

	}
 }
