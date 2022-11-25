package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.NotificationVo;

@Repository
public class NotiDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	/* 알림 개수 */
	public int notiCount(int userNo) {
		return sqlSession.selectOne("notification.notiCount", userNo);
	}
	
	/* 알림 리스트 */
	public List<NotificationVo> notiList(NotificationVo notiVo) {
		return sqlSession.selectList("notification.notiList", notiVo);
	}
	
	/* 그룹 이름 변경 알림 7 */
	public int alertOfGroupChange(NotificationVo notiVo) {
		return sqlSession.insert("notification.alertOfGroupChange", notiVo);
	}
	
	/* 그룹원 알림 5/6 */
	public int addGroupNoti(NotificationVo notiVo) {
		return sqlSession.insert("notification.addGroupNoti", notiVo);
	}

	/* 그룹 알림(회신) 1/2/3/4/10 */
	public int addGroupReNoti(NotificationVo notiVo) {
		return sqlSession.insert("notification.addGroupReNoti", notiVo);
	}
	
	/* 리뷰 삭제 알림 8 */
	public int addReportNoti(NotificationVo notiVo) {
		return sqlSession.insert("notification.addReportNoti", notiVo);
	}
	
	/* 문의 답변 알림 9 */
	public int addReplyNoti(NotificationVo notiVo) {
		return sqlSession.insert("notification.addReplyNoti", notiVo);
	}
	
	/* 그룹원 리스트 : 초대중인 멤버 수 */
	public int membersInvitedCount(int groupNo) {
		return sqlSession.selectOne("notification.membersInvitedCount", groupNo);
	}
	
	/* 초대 중 여부 확인 */
	public int alreadyInvite(Map<String, Object> map) {
		return sqlSession.selectOne("notification.alreadyInvite", map);
	}
	
	/* 보스 초대 중? */
	public int invitingBoss(int groupNo) {
		return sqlSession.selectOne("notification.invitingBoss", groupNo);
	}
	
	/* 알림 확인 처리 */
	public int notiChangeToCheck(int groupNo) {
		return sqlSession.update("notification.notiChangeToCheck", groupNo);
	}
	

}
