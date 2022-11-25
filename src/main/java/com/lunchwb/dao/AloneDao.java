package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.AloneVo;

@Repository
public class AloneDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 전체 리뷰 정보 가져오기 
	public List<AloneVo> reviewList(int userNo) {
		List<AloneVo> reviewList = sqlSession.selectList("alone.reviewList", userNo);
		
		return reviewList;
	};
	
	// 리뷰 정보 가져오기 (1개)
	public AloneVo getReview(int reviewNo) {
		AloneVo aloneVo = sqlSession.selectOne("alone.getReview", reviewNo);
		
		return aloneVo;
		
	};
	
	// 리뷰 수정
	public int updateReview(AloneVo aloneVo) {
		int count = sqlSession.update("alone.updateReview",aloneVo);
		
		return count;
	};
	
	
	// 리뷰 삭제
	public int delReview(int reviewNo) {
		int count = sqlSession.delete("alone.deleteReview",reviewNo);
		
		return count;
	};
	
	

}
