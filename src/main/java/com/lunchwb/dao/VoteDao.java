package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.VoteVo;

@Repository
public class VoteDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	// 로그인 안한 사용자가 투표No 가지고 접근 시
	public Integer selectGuestVoteState(int voteNo) {
		return sqlSession.selectOne("vote.selectGuestVoteState", voteNo);
	}
	
	
	// 로그인 한 사용자 투표중인지 확인
	public Integer selectMemberVoteNo(int userNo) {
		return sqlSession.selectOne("vote.selectMemberVoteNo", userNo);
	}
	
	
	// 투표생성하기(생성된 voteNo 리턴)
	public int insertNewVote(VoteVo voteMakeItems) {
		sqlSession.insert("vote.insertNewVote", voteMakeItems);
		
		return voteMakeItems.getVoteNo();
	}
	
	
	// 투표 멤버 insert
	public int insertVoteMember(Map<String, Object> voteMems) {
		return sqlSession.insert("vote.insertVoteMember", voteMems);
	}
	
	
	// 오늘 투표 참여 안하는 그룹원 insert
	public int insertNotTodayMember(Map<String, Object> notTodayMems) {
		return sqlSession.insert("vote.insertNotTodayMember", notTodayMems);
	}
	
	
	// voteAside 정보 가져오기
	public List<VoteVo> selectVoteInfo(int voteNo) {
		return sqlSession.selectList("vote.selectVoteInfo", voteNo);
	}
	
	
	// guest 동일ip 투표 여부 확인
	public Integer selectGuestVoted(Map<String, Object> map) {
		return sqlSession.selectOne("vote.selectGuestVoted", map);
	}
	
	
	// 투표 현황 불러오기
	public String selectVoteResults(int voteNo) {
		return sqlSession.selectOne("vote.selectVoteResults", voteNo);
	}
	
	
	// 투표 결과 업데이트
	public void updateVoteResults(VoteVo voteResults) {
		sqlSession.update("vote.updateVoteResults", voteResults);
	}
	
	
	// voteVoted 업데이트
	public void updateVoteVoted(VoteVo myVote) {
		sqlSession.update("vote.updateVoteVoted", myVote);
	}
	
	
	// 투표 현황
	public VoteVo currVote(int voteNo) {
		return sqlSession.selectOne("vote.currVote", voteNo);
	}
	
	
	// 투표 종료 > voteState 업데이트
	public int updateVoteEnd(int voteNo) {
		return sqlSession.update("vote.updateVoteEnd", voteNo);
	}
	
	
	// 투표 종료 > userState 업데이트
	public int updateUserEnd(int voteNo) {
		return sqlSession.update("vote.updateUserEnd", voteNo);
	}
	
	
	// 여기갈래요 > userState 업데이트
	public int updateUserVisited(int voteNo) {
		return sqlSession.update("vote.updateUserVisited", voteNo);
	}
	
	
	// 여기랄래여 > voteState 업데이트
	public int updateVoteVisited(int voteNo) {
		return sqlSession.update("vote.updateVoteVisited", voteNo);
	}
	
	
	// 비회원 투표하기
	public int updateGuestVoted(VoteVo myVote) {
		return sqlSession.update("vote.updateGuestVoted", myVote);
	}
	
	
	// 투표 취소 > userState = 0으로 변경
	public int updateUserReset(int voteNo) {
		return sqlSession.update("vote.updateUserReset", voteNo);
	}
	
	
	// 투표 취소 > 투표 삭제
	public int DeleteVote(int voteNo) {
		return sqlSession.delete("vote.DeleteVote", voteNo);
	}
	
	
	// 투표 종료 시각 업데이트
	public int updateVoteEndTime(Map<String, Object> map) {
		return sqlSession.update("vote.updateVoteEndTime", map);
	}
	
	
	// 투표 수정시 아직 투표 종료 안한 회원들 삭제
	public int deleteNotVoted(Map<String, Object> map) {
		return sqlSession.delete("vote.deleteNotVoted", map);
	}
	
	
	// 투표 수정시 투표 빠질 회원들 user_state = 0으로 변경
	public void updateState0(List<VoteVo> list) {
		sqlSession.update("vote.updateState0", list);
	}
	
	
	// 투표 수정 시 참여 안하는 멤버들 vote_voted = -1로 업데이트
	public void updateModifyMember(Map<String, Object> map) {
		sqlSession.update("vote.updateModifyMember", map);
	}
	
	
	// 탈주 > vote_members에서 나 삭제하기
	public void deleteEscape(VoteVo me) {
		sqlSession.delete("vote.deleteEscape", me);
	}
	
	
	// 투표하고 탈주 > voteResults에서 이 사람 투표 제외
	public void updateEscapeResult(VoteVo myVote) {
		sqlSession.update("vote.updateEscapeResult", myVote);
	}

	
	// 투표 생성 가능 여부 체크
	public int canMakeVote(int groupNo) {
		return sqlSession.selectOne("vote.canMakeVote", groupNo);
	}
	
	// 자정 투표 삭제
	public int deleteVoteMidnight() {
		return sqlSession.delete("vote.deleteVoteMidnight");
	}
}
