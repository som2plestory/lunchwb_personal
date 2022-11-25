package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.StatVo;

@Repository
public class StatDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	// 지난 한달간 음식별 여기갈래요 수 조회
	public List<StatVo> lastMonth(){
		List<StatVo> lastMonthList = sqlSession.selectList("stat.lastMonth");
		return lastMonthList;
	};
	
	// 로그인 한 유저의 그룹간 식사수
	public List<StatVo> withGroup(int userNo){
		List<StatVo> withGroupList = sqlSession.selectList("stat.withGroup",userNo);
		return withGroupList;
	};
	
	
	
	
	// 지난 6개월 간 선택한 음식의 인기 조회
	public List<StatVo> getFoodHit(String menu1stCateName){
		List<StatVo> getFoodHitList = sqlSession.selectList("stat.halfYear",menu1stCateName);
		return getFoodHitList;
	}
	
	// 연령별 조회
	public List<StatVo> getAgeHit(String menu1stCateName){
		List<StatVo> getAgeHitList = sqlSession.selectList("stat.ageStat",menu1stCateName);
		return getAgeHitList;
	}
	
	
	

}
