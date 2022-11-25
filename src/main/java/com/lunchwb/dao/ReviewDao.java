package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.ReviewVo;

@Repository
public class ReviewDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<ReviewVo> storeReviews(int storeNo){
		List<ReviewVo> reviewList = sqlSession.selectList("review.storeReviews", storeNo);
		return reviewList;
	}
	
	public List<ReviewVo> recentReview(int storeNo){
		List<ReviewVo> reviewList = sqlSession.selectList("review.recentReview", storeNo);
		return reviewList;
	}
	
	public List<String> recentImages(int storeNo){
		List<String> imgList = sqlSession.selectList("review.recentImages", storeNo);
		return imgList;
	}
	
	public ReviewVo todayReview(int userNo) {
		ReviewVo reviewVo = sqlSession.selectOne("review.todayReview", userNo);
		return reviewVo;
	}
	
	public int addReview(ReviewVo reviewVo) {
		int count = sqlSession.insert("review.addReview", reviewVo);
		return count;
	}

}
