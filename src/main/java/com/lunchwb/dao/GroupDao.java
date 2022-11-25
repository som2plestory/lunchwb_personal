package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.GroupVo;

@Repository
public class GroupDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	/******************** 그룹 리스트 **********************************************/
	public List<GroupVo> userGroups(int userNo) {
		List<GroupVo> groupList = sqlSession.selectList("group.userGroups", userNo);
		return groupList;
	}
	
	/******************** 그룹 이름 *******************************************/
	public String selectedGpName(GroupVo groupVo) {
		String groupName = sqlSession.selectOne("group.selectedGpName", groupVo);
		return groupName;
	}
	
	/******************** 그룹 멤버 리스트 *******************************************/
	public List<GroupVo> groupMembers(int groupNo) {
		List<GroupVo> memberList = sqlSession.selectList("group.groupMembers", groupNo);
		return memberList;
	}
	
	/******************** 그룹 리더 ***********************************************/
	public int groupLeader(int groupNo) {
		int leader = sqlSession.selectOne("group.groupLeader", groupNo);
		return leader;
	}
	
	/******************** 찐 회원 수 ***********************************************/
	public int groupUsers(int groupNo) {
		return sqlSession.selectOne("group.groupUsers", groupNo);
	}
	
	/******************** 그룹 생성 ***********************************************/
	public void createGroup(GroupVo groupVo) {
		sqlSession.insert("group.createGroup", groupVo);
	}
	
	/******************** 그룹 개수 ***********************************************/
	public int groupCount(int userNo) {
		int groupCount = sqlSession.selectOne("group.groupCount", userNo);
		return groupCount;
	}
	
	/******************** 그룹 순서 변경 ***********************************************/
	public int changeOrder(GroupVo groupVo) {
		int count = sqlSession.update("group.changeOrder", groupVo);
		return count;
	}
	
	/*************** 그룹 정보 변경(이름/리더/그룹 비활성화(멤버 전원 탈퇴)) *******************/
	public int groupChange(GroupVo groupVo) {
		int count = sqlSession.update("group.groupChange", groupVo);
		return count;
	}
	
	/******************** 그룸장 제외 그룹원 목록 ***********************************************/
	public List<Integer> groupMembersForAlert(int groupNo) {
		List<Integer> groupMembers = sqlSession.selectList("group.groupMembersForAlert", groupNo);
		return groupMembers;
	}
	
	/******************** 그룹 보스 유무 ***********************************************/
	public int beBoss(int groupNo) {
		int count = sqlSession.selectOne("group.beBoss", groupNo);
		return count;
	}
	
	/******************** 그룹 보스 삭제 ***********************************************/
	public void deleteBoss(int groupNo) {
		sqlSession.update("group.deleteBoss", groupNo);
	}
	
	/******************** 그룹 멤버 여부 ***********************************************/
	public int memberCheck(GroupVo groupVo) {
		int count = sqlSession.selectOne("group.memberCheck", groupVo);
		return count;
	}
	
	/******************** 그룹 멤버 추가 ***********************************************/
	public void addMember(GroupVo groupVo) {
		sqlSession.insert("group.addMember", groupVo);
	}
	
	/******************** 그룹 멤버 1명 정보(방금 추가한 멤버 정보 조회) *********************/
	public GroupVo memberInfo(int memberNo) {
		GroupVo memberInfo = sqlSession.selectOne("group.memberInfo", memberNo);
		return memberInfo;
	}
	
	/******************** 그룹 멤버 강퇴 / 탈퇴 ***********************************************/
	public int outGroup(GroupVo groupVo) {
		int count = sqlSession.delete("group.outGroup", groupVo);
		return count;
	}
	
	/******************** 그룹 순서 조정(선택 변경x) **************************************/
	public void autoOrder(GroupVo groupVo) {
		sqlSession.update("group.autoOrder", groupVo);
	}
	
	/******************** 장바구니 그룹 선택 ***********************************************/
	public List<GroupVo> selectBasketGroup(int userNo) {
		List<GroupVo> basketGroup = sqlSession.selectList("group.selectBasketGroup", userNo);
		return basketGroup;
	}
	
	/******************** 추가된 그룹 정보 ***********************************************/
	public GroupVo addedGroup(int groupNo) {
		GroupVo groupVo = sqlSession.selectOne("group.addedGroup", groupNo);
		return groupVo;
	}
	
	/******************** 투표하기 그룹 멤버 불러오기 *****************************************/
	public List<GroupVo> selectVoteMember(int groupNo) {
		return sqlSession.selectList("group.selectVoteMember", groupNo);
	}
	
	/********************* 여기갈래요 선택될 그룹 멤버 불러오기 ********************************/
	public List<GroupVo> membersGoWith(GroupVo groupVo) {
		List<GroupVo> memberList = sqlSession.selectList("group.membersGoWith", groupVo);
		return memberList;
	}
	
	
}
