package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	SqlSession sqlSession;

	public UserVo login(UserVo userVo) {
		UserVo authUser = sqlSession.selectOne("user.login", userVo);
		return authUser;
	}

	public UserVo getUser(UserVo userVo) {
		UserVo userInfo = sqlSession.selectOne("user.getUser", userVo);
		return userInfo;
	}

	public int join(UserVo userVo) {
		int count = sqlSession.insert("user.join", userVo);
		return count;
	}
	
	public int modifyUser(UserVo userVo) {
		int count = sqlSession.update("user.modifyUser", userVo);
		return count;
	}
	
	public int updatePw(UserVo userVo) {
		int count = sqlSession.update("user.updatePw", userVo);
		return count;
	}
	
	/* 자동로그인 */
	public void autoLogin(Map<String, Object> map) {
		sqlSession.update("user.autoLogin", map);
	}
	
	public UserVo selectSession(String sessionId) {
		UserVo autoLogin = sqlSession.selectOne("user.selectSession", sessionId);
		return autoLogin;
	}
	
	/* SNS로그인 */
	/* 네이버 */
	public UserVo snsConnectionCheck(Object userEmail) {
		UserVo snsCheck = sqlSession.selectOne("user.snsConnectionCheck", userEmail);
		return snsCheck;
	}
	
	public UserVo snsLogin(Map<String, Object> apiJson) {
		UserVo snsLogin = sqlSession.selectOne("user.snsLogin", apiJson);
		return snsLogin;
	}
	
	public UserVo modifyAfterNaverLogin(UserVo userVo) {
		UserVo naverLogin = sqlSession.selectOne("user.modifyAfterNaverLogin", userVo);
		return naverLogin;
	}
	
	public void setSNSConnection(Map<String, Object> apiJson) {
		sqlSession.update("user.setSNSConnection", apiJson);
	}
	
	public int userJoinSns(Map<String, Object> apiJson) {
		int count = sqlSession.insert("user.userJoinSns", apiJson);
		return count;
	}
	
	
	/* SNS 유저 확인 */
	public UserVo checkSNSUser(String userEmail) {
		UserVo checkSNSUser = sqlSession.selectOne("user.checkSNSUser", userEmail);
		return checkSNSUser;
	}
	
	
	/* SNS 유저 회원 정보 수정 */
	public int modifySNSUser(UserVo userVo) {
		int count = sqlSession.update("user.modifySNSUser", userVo);
		return count;
	}
	
	/* Json */
	/* 이메일 중복확인 */
	public UserVo checkEmail(String userEmail) {
		UserVo checkEmail = sqlSession.selectOne("user.checkEmail", userEmail);
		return checkEmail;
	}
	
	/* 이지희 */
	/* 그룹 비회원 멤버 추가*/
	public void addGpMember(UserVo userVo) {
		//logger.info("addGroupMem()");
		sqlSession.insert("user.addGpMember", userVo);
	}
	
	/* 그룹에 초대할 회원 존재 여부 */
   public UserVo userCheck(String userEmail) {
      UserVo userVo = sqlSession.selectOne("user.userCheck", userEmail);
      return userVo;
   }
   
	/* 그룹 여기갈래요(바로방문) 선택 - userState 4로 변경 */
   public void groupUpdateState4(List<Integer> memberList) {
	   sqlSession.update("user.groupUpdateState4", memberList);
   }
   

   /* 정원 */
   /* 한 번에 바꾸는 경우 */
   /* userState 0으로 변경 */
   public void updateState0(List<UserVo> voteMembers) {
	   for (UserVo user: voteMembers) {
		   sqlSession.update("user.updateState0", user.getUserNo());
	   }
   }
   
   /* userState 1로 변경 */
   public void updateState1(List<UserVo> voteMembers) {
	   for (UserVo user: voteMembers) {
		   sqlSession.update("user.updateState1", user.getUserNo());
	   }
   }
   
   /* userState 2로 변경 */
   public void updateState2(List<UserVo> voteMembers) {
	   for (UserVo user: voteMembers) {
		   sqlSession.update("user.updateState2", user.getUserNo());
	   }
   }
   
   /* userState 3으로 변경 */
   public void updateState3(List<UserVo> voteMembers) {
	   for (UserVo user: voteMembers) {
		   sqlSession.update("user.updateState3", user.getUserNo());
	   }
   }
   
   /* userState 4로 변경 */
   public void updateState4(List<UserVo> voteMembers) {
	   for (UserVo user: voteMembers) {
		   sqlSession.update("user.updateState4", user.getUserNo());
	   }
   }
   
   
   /* 하나씩 바꾸는 경우 */
   /* userState 0으로 변경 */
   public int updateState0(int userNo) {
	   return sqlSession.update("user.updateState0", userNo);
   }
   
   /* userState 1로 변경 */
   public int updateState1(int userNo) {
	   return sqlSession.update("user.updateState1", userNo);
   }
   
   /* userState 2로 변경 */
   public int updateState2(int userNo) {
	   return sqlSession.update("user.updateState2", userNo);
   }
   
   /* userState 3으로 변경 */
   public int updateState3(int userNo) {
	   return sqlSession.update("user.updateState3", userNo);
   }
   
   /* userState 4로 변경 */
   public int updateState4(int userNo) {
	   return sqlSession.update("user.updateState4", userNo);
   }
   
   /* userState 불러오기 */
   public int selectUserState(int userNo) {
	   return sqlSession.selectOne("user.selectUserState", userNo);
   }
   
   /* 투표 참여 못하는 사용자 불러오기 */
   public List<String> selectImpossibleMember(List<Integer> checkVoteMember) {
	   return sqlSession.selectList("user.selectImpossibleMember", checkVoteMember);
   }
   
   /* 모든 user userState 0으로 초기화 */
   public int updateAllUsers() {
	   return sqlSession.update("user.updateAllUsers");
   }
}
