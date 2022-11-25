package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.VisitedVo;

@Repository
public class VisitedDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// ================================ 달력 ================================
	// 이번달 방문장소
	public List<VisitedVo> getCalendar(VisitedVo vstVo){
		List<VisitedVo> calendarList = sqlSession.selectList("visited.calendar",vstVo); 
		
		
		return calendarList;
	};
	
	// ================================ 달력 끝 ================================

	
	/* 지니 */
	public void decideVisit(Map<String, Object> map) {
		sqlSession.insert("visited.decideVisit", map);
	}
	
	public void cancelVisit(VisitedVo visitedVo) {
		sqlSession.delete("visited.cancelVisit", visitedVo);
	}
	
	public VisitedVo recentVisit(VisitedVo visitedVo) {
		visitedVo = sqlSession.selectOne("visited.recentVisit", visitedVo);
		return visitedVo;
	}
	
	public List<VisitedVo> recentMenu(int storeNo) {
		List<VisitedVo> menuList = sqlSession.selectList("visited.recentMenu", storeNo);
		return menuList;
	}
	
	public VisitedVo todayStoreInfo(int userNo) {
		VisitedVo visitedVo = sqlSession.selectOne("visited.todayStoreInfo", userNo);
		return visitedVo;
	}
	
	public VisitedVo storeAndMe(VisitedVo visitedVo) {
		VisitedVo relVo = sqlSession.selectOne("visited.storeAndMe", visitedVo);
		return relVo;
	}
	
	public void todayMenu(VisitedVo visitedVo) {
		sqlSession.update("visited.todayMenu", visitedVo);
	}
	
	public int groupByDate(VisitedVo visitedVo) {
		return sqlSession.selectOne("visited.groupByDate", visitedVo);
	}
	
	public void insertVoteVisit(Map<String, Object> map) {
		sqlSession.insert("visited.insertVoteVisit", map);
	}
	

}
