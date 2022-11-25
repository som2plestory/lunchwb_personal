package com.lunchwb.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lunchwb.dao.BlackDao;
import com.lunchwb.dao.GroupDao;
import com.lunchwb.dao.NotiDao;
import com.lunchwb.dao.UserDao;
import com.lunchwb.vo.BlacklistVo;
import com.lunchwb.vo.GroupVo;
import com.lunchwb.vo.NotificationVo;
import com.lunchwb.vo.UserVo;

@Service
public class GroupService {
	
	@Autowired
	private GroupDao groupDao;
	@Autowired
	private BlackDao blackDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private NotiDao notiDao;
	
	
	/******************** 그룹 없으면 userAside에서 블랙리스트 가림 **************************/
	public boolean isThereGroup(int userNo) {
		boolean result = false;
		
		int count = groupDao.groupCount(userNo);
		if(count > 0) {
			result = true;
		}

		return result;
	}
	
	
	/******************** 그룹 리스트 페이지 ********************************************/
	public Map<String, Object> groupList(UserVo authUser, int groupNo) {
		Map<String, Object> map = new HashMap<>();
		
		/////////////////// 유저 그룹 리스트  /////////////////////////////
		int userNo = authUser.getUserNo();
		List<GroupVo> groupList = groupDao.userGroups(userNo);
		map.put("groupList", groupList);
		
		//그룹 개수
		//그룹이 없으면 그룹 생성페이지로 전송
		int groupCount = groupList.size();
		map.put("groupCount", groupCount);
		
		/////////////////// 그룹 //////// //////////////////////////////
		//나의그룹 접근 groupNo == 0: 첫번째 그룹페이지
		
		if(groupCount != 0) {
			
			if(groupNo == 0) {
				groupNo = groupList.get(0).getGroupNo();
			}
			
			//그룹 이름
			GroupVo groupVo = new GroupVo();
			groupVo.setUserNo(userNo);
			groupVo.setGroupNo(groupNo);
			
			
			String groupName = groupDao.selectedGpName(groupVo);
			
			//주소접근 > 내 그룹이 아니면 에러
			if(groupName != null && groupName != "") {
				
				//그룹 이름
				map.put("groupName", groupName);
				map.put("groupNo", groupNo);
				
				//그룹원 리스트
				List<GroupVo> memberList = groupDao.groupMembers(groupNo);
				map.put("memberList", memberList);
				
				//그룹원 수(혼자인지 아닌지 판단하게)
				int memberCount = memberList.size();
				map.put("memberCount", memberCount);
				
				//그룹 리더 
				int leader = groupDao.groupLeader(groupNo);
				map.put("leader", leader);
				
				if(userNo == leader) {
					int userCount = groupDao.groupUsers(groupNo);
					map.put("userCount", userCount);
				}

				//초대중인 회원 수(그룹장만 표기)
				if(leader == userNo) {
					int inviteCount = notiDao.membersInvitedCount(groupNo);
					map.put("inviteCount", inviteCount);
				}
				
			}
		}
		
		return map;
	}
	
	
	/******************** 그룹 추가 페이지 *******************************************/
	public Map<String, Object> addGroupForm(UserVo authUser) {
		Map<String, Object> map = new HashMap<>();
		
		/////////////////// 유저 그룹 리스트  /////////////////////////////
		int userNo = authUser.getUserNo();
		List<GroupVo> groupList = groupDao.userGroups(userNo);
		map.put("groupList", groupList);
		
		//그룹 개수
		int groupCount = groupList.size();
		map.put("groupCount", groupCount);
		
		return map;
	}
	
	
	/******************** 그룹 생성 ***********************************************/
	public HashMap<String, Object> addGroup(UserVo authUser, GroupVo groupVo) {
		//그룹 최대 4개 보유 가능 > 4개 이후 생성 못함 (새 그룹 추가 버튼이 보이지 않음 - 혹시 주소접근은 새 그룹 추가 페이지 접근시 막을 것)
		HashMap<String, Object> map = new HashMap<>();
		
		int userNo = authUser.getUserNo();
		
		//////////////////// 그룹 생성 //////////////////////////////////
		//그룹 생성 > 생성자가 첫번째 리더
		groupVo.setGroupLeader(userNo);
		groupDao.createGroup(groupVo);
		
		/////////////////// 그룹 멤버 추가 ////////////////////////////////
		//groupVo : groupNo / bossCheck 있음
		//생성된 그룹 번호
		int groupNo = groupVo.getGroupNo();
		
		//groupOrder는 1부터 시작 순서대로 해당 유저의 그룹개수 +1로
		int groupOrder = groupDao.groupCount(userNo) + 1;
		
		//vo 정보 추가
		groupVo.setUserNo(userNo);
		groupVo.setGroupOrder(groupOrder);
		
		//그룹 멤버 추가
		groupDao.addMember(groupVo);
		
		
		////////////Basket////////////////////////////////
		//바스켓에서 필요한 추가된 그룹 정보 불러오기
		GroupVo gpVo = groupDao.addedGroup(groupNo);
		map.put("gpVo", gpVo);
		
		//이제 막 시작한 유저야?(새 그룹이 첫번째 그룹)
		int groupCount = groupDao.groupCount(userNo);
		map.put("groupCount", groupCount);
		
		return map;
	}
	
	
	/******************** 그룹 순서 변경 ***********************************************/
	public String changeOrder(HashMap<String, Integer> gpOrder, UserVo authUser) {
		GroupVo groupVo = new GroupVo();
		
		int userNo = authUser.getUserNo();
		groupVo.setUserNo(userNo);
		
		int count = 0;
		int groupCount = gpOrder.get("groupCount");
		
		for(int i=1; i<=groupCount; i++) {
			groupVo.setOrder(i);
			
			int groupNo = gpOrder.get("order"+i);
			groupVo.setGroupNo(groupNo);
			
			count += groupDao.changeOrder(groupVo);
		}
		
		String result = "";
		
		if(count == groupCount) {
			result = "success";
			
		}else {
			result = "fail";
		}
		
		return result;
	}
	
	
	/******************** 그룹 이름 변경 *********************************************/
public Map<String, Object> nameChange(GroupVo groupVo) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "fail";
		
		int count = groupDao.groupChange(groupVo);
		
		if(count > 0) {
			result = "success";

			//그룹장 제외(본인이 바꿨으니까) 멤버원 알림 전송 (noti_type = 7)
			List<Integer> groupMembers = groupDao.groupMembersForAlert(groupVo.getGroupNo());
			
			for(int i=0; i<groupMembers.size(); i++) {
				NotificationVo notiVo = new NotificationVo();
				notiVo.setUserNo(groupMembers.get(i));
				notiVo.setGroupNo(groupVo.getGroupNo());
				//확인 전에 여러번 변경 되는 경우 고려
				String alertCmt = groupVo.getBeforeGroupName()+"의 이름이 "+groupVo.getGroupName()+"로 변경되었습니다.";
				notiVo.setAlertCmt(alertCmt);

				notiDao.alertOfGroupChange(notiVo);
			}
			
			map.put("members", groupMembers);
		}
		
		map.put("result", result);
		
		return map;
	}
	
	
	/******************** 그룹에 보스가 있는지 *****************************************/
	public String beBoss(int groupNo) {
		String result = "can't";
		
		int count = groupDao.beBoss(groupNo);
		
		if(count == 0) {
			if(notiDao.invitingBoss(groupNo) > 0) {
				result = "can't: inviting";
				
			}else {
				result = "can";
			}
		}
		
		return result;
	}
	
	
	
	/******************** 그룹에 초대할 회원 체크 ******************************************/
	public Map<String, Object> userCheck(Map<String, Object> map, UserVo authUser) {
		Map<String, Object> checkMap = new HashMap<String, Object>(); 
		
		String userEmail = (String)map.get("userEmail");
		UserVo userVo = userDao.userCheck(userEmail);
		
		
		String state = "not user";
		if(userVo != null) {
			int userNo = userVo.getUserNo();

			if(userNo == authUser.getUserNo()) {
				state = "It's U";
				
			}else {
				
				//이미 초대를 보냈는지?
				int already = notiDao.alreadyInvite(map);
				if(already > 0) {
					state = "already invite";

				}else {
					int gpCount = groupDao.groupCount(userNo);
					
					//해당 회원이 그룹 추가 가능
					if(gpCount < 4) {
						state = "possible";
						checkMap.put("userNo", userNo);
						checkMap.put("gpCount", gpCount);
						
						//그룹 추가 불가(최대 개수 보유)
					}else {
						state = "impossible";
					}
				}
			}
		}
		
		checkMap.put("state", state);
		
		return checkMap;
	}
	
	
	/******************** 그룹 멤버 여부 ************************************************/
	public String memberCheck(GroupVo groupVo) {
		String state = "ok";
		
		int count = groupDao.memberCheck(groupVo);
		if(count == 1) {
			state = "already";
		}
		
		return state;
	}
	
	
	/******************** 회원 그룹 멤버 초대 ********************************************/
	public String invtMember(GroupVo groupVo, UserVo authUser) {
		
		//그룹 초대 보내기 
		NotificationVo notiVo = new NotificationVo(); 
		notiVo.setUserNo(groupVo.getUserNo());
		notiVo.setGroupNo(groupVo.getGroupNo());
		notiVo.setSendUser(authUser.getUserNo());
		
		//보스 변경
		if(groupVo.getBossCheck() == 1) {
			groupDao.deleteBoss(groupVo.getGroupNo());
			
			//부장님으로 초대 type : 10
			notiVo.setNotiType(10);
		}else {
			
			//일반 그룹원으로 초대 type : 1d
			notiVo.setNotiType(1);
		}
		
		//멤버 추가 안함(초대 수락 후)
		/*
		 * groupDao.addMember(groupVo); int memberNo = groupVo.getGroupMemberNo();
		 * GroupVo memberVo = groupDao.memberInfo(memberNo);
		 */
		
		//알림 추가
		if(notiDao.addGroupReNoti(notiVo) > 0) {
			return "success";
			
		}else {
			return "fail";
		}
		
	}
	
	
	/******************** 유령회원 그룹 멤버 추가 ********************************************/
	public GroupVo addMember(GroupVo groupVo) {
		/////// 비회원 그룹 멤버 유령회원 생성 ////////////////////////////////
		UserVo userVo = new UserVo();
		userVo.setUserName(groupVo.getUserName());
		userVo.setUserBirthYear(groupVo.getUserBirthYear());
		userVo.setUserSex(groupVo.getUserSex());
		//user_grade = 0 고정
		userDao.addGpMember(userVo);
		
		/////////////// 그룹에 비회원 멤버 추가 ////////////////////////////
		//보스 변경
		if(groupVo.getBossCheck() == 1) {
			groupDao.deleteBoss(groupVo.getGroupNo());
		}
		
		//groupVo : groupNo, bossCheck 있음
		//유령회원 번호 가져오기
		int userNo = userVo.getUserNo();
		
		//groupVo 정보 추가
		groupVo.setUserNo(userNo);
		//비회원한테 그룹순서는 필요 없어
		groupVo.setGroupOrder(0);
		groupDao.addMember(groupVo);
		
		//방금 추가한 그룹멤버번호
		int memberNo = groupVo.getGroupMemberNo();
		GroupVo memberVo = groupDao.memberInfo(memberNo);
	
		return memberVo;
	}
	
	
	/******************** 그룹 멤버 내보내기(강퇴) *****************************************/
	public String outMember(GroupVo groupVo) {
		String result = "fail";
		//int userNo = groupVo.getUserNo();
		///////////////////// 그룹 멤버에서 삭제 //////////////////////////
		int count = groupDao.outGroup(groupVo);
		
		if(count > 0) {
			result = "success";
			
			//count != 1 > 그 사이에 멤버가 탈퇴를 먼저 했을 경우 그룹 오더를 조정하면 안됨
			//group_order 조정
			groupDao.autoOrder(groupVo);
			
			//강퇴 알림 noti_type : 5
			NotificationVo notiVo = new NotificationVo(); 
			notiVo.setUserNo(groupVo.getUserNo());
			notiVo.setNotiType(5);
			notiVo.setGroupNo(groupVo.getGroupNo());
			
			notiDao.addGroupNoti(notiVo);
			
		}
		
		return result;
	}
	
	
	/******************** 그룹 탈퇴 ****************************************************/
	public int leaveGroup(UserVo authUser, int groupNo, int groupLeader) {
		int userNo = authUser.getUserNo();
		
		GroupVo groupVo = new GroupVo();
		groupVo.setUserNo(userNo);
		groupVo.setGroupNo(groupNo);
	
		groupDao.outGroup(groupVo);
		groupDao.autoOrder(groupVo);
		
		//내가 그룹장이었나요? > 그룹 비활성화 group - leader no = 0
		if(userNo == groupLeader) {
			groupVo.setGroupLeader(0);
			groupDao.groupChange(groupVo);
			
		}else {
			//탈퇴 알림(그룹장에게) type : 4
			NotificationVo notiVo = new NotificationVo(); 
			notiVo.setUserNo(groupLeader);
			notiVo.setNotiType(4);
			notiVo.setGroupNo(groupNo);
			notiVo.setSendUser(userNo);
			
			notiDao.addGroupReNoti(notiVo);
		}
		
		//그룹장이 아닐 때만 알림(그룹장이면 보낼 사람이 없어)

		int groupCount = groupDao.groupCount(userNo); 
		
		return groupCount;
	}
	
	
	/******************** 그룹장 위임 ****************************************************/
	public String leaderChange(GroupVo groupVo) {
		if(groupDao.groupChange(groupVo) > 0) {
			
			//그룹장 위임 알림(type : 6)
			NotificationVo notiVo = new NotificationVo(); 
			notiVo.setUserNo(groupVo.getGroupLeader());
			notiVo.setNotiType(6);
			notiVo.setGroupNo(groupVo.getGroupNo());
			
			notiDao.addGroupNoti(notiVo);
			
			return "success";
		}else {
			return "fail";
		}
	}
	
	
	/******************** 블랙리스트 페이지 ****************************************************/
	public Map<String, Object> blacklist(UserVo authUser, int groupNo) {
		Map<String, Object> map = new HashMap<>();
		
		/////////////////// 유저 그룹 리스트  /////////////////////////////
		int userNo = authUser.getUserNo();
		List<GroupVo> groupList = groupDao.userGroups(userNo);
		map.put("groupList", groupList);
		
		//그룹 개수
		//그룹이 없으면 그룹 생성페이지로 전송
		int groupCount = groupList.size();
		map.put("groupCount", groupCount);
		
		if(groupCount != 0) {
			
			if(groupNo == 0) {
				groupNo = groupList.get(0).getGroupNo();
			}
			
			//그룹 이름
			GroupVo groupVo = new GroupVo();
			groupVo.setUserNo(userNo);
			groupVo.setGroupNo(groupNo);
			
			
			String groupName = groupDao.selectedGpName(groupVo);
			
			//주소접근 > 내 그룹이 아니면 에러
			if(groupName != null && groupName != "") {
				
				//그룹 이름
				map.put("groupName", groupName);
				map.put("groupNo", groupNo);
				
				//블랙리스트
				List<BlacklistVo> blacklist = blackDao.blacklist(groupNo);
				map.put("blacklist", blacklist);
				
				//블랙 개수
				int blackCount = blacklist.size();
				map.put("blackCount", blackCount);
				
				//그룹 리더 
				int groupLeader = groupDao.groupLeader(groupNo);
				map.put("groupLeader", groupLeader);
				
				//그룹 어사이드 링크 구분
				map.put("black", true);
			}
		}
		
		return map;
		
	}
	
	
	/******************** 블랙리스트 여부 확인 *************************************************/
	public String isBlack(BlacklistVo blackVo) {
		if(blackDao.isBlack(blackVo) == 0 ) {
			//아니야
			return "N";
		}else {
			//맞아 : 블랙리스트
			return "Y";
		}
	}
	
	
	/******************** 블랙리스트 추가(목록 추가) *********************************************/
	public BlacklistVo addBlacklist(BlacklistVo blackVo) {
		blackDao.addBlack(blackVo);
		int blackNo = blackVo.getBlackNo();
		return blackDao.blackStore(blackNo);
	}
	
	
	/******************** 블랙리스트 추가 ****************************************************/
	public String addBlack(BlacklistVo blackVo) {
		if(blackDao.addBlack(blackVo) > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	
	/******************** 블랙리스트 삭제 ****************************************************/
	public String deleteBlack(BlacklistVo blackVo) {
		if(blackDao.deleteBlack(blackVo) > 0) {
			return "success";
		}else {
			return "fail";
		}
	}

	
	/******************** Search for Store that would be added ******************************/
	public List<BlacklistVo> blackStoreSearch(BlacklistVo blackVo){
		return blackDao.blackStoreSearch(blackVo);
	}
	
	
	/********************* 초대 수락 전 그룹 개수 확인하기 *****************************************/
	public int groupCount(int userNo) {
		return groupDao.groupCount(userNo);
	}
	
	
	
}
