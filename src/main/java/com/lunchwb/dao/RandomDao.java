package com.lunchwb.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.RandomVo;

@Repository
public class RandomDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int insertRandomResult(RandomVo randomVo) {
		sqlSession.insert("random.insertRandomResult", randomVo);
		return randomVo.getRandomNo();
	}
	
	public RandomVo checkRandomResult(int userNo) {
		RandomVo checkRandomVo = sqlSession.selectOne("random.checkRandomResult", userNo);
		return checkRandomVo;
	}
	
	public RandomVo checkAllRandomResult(int randomNo) {
		RandomVo checkAllRandomResult = sqlSession.selectOne("random.checkAllRandomResult", randomNo);
		return checkAllRandomResult;
	}
	
	public int deleteRandomResult(int userNo) {
		return sqlSession.delete("random.deleteRandomResult", userNo);
	}
	
	
	public void deleteRandomInfo() {
		sqlSession.delete("random.deleteRandomInfo");
	}
	
	public void deleteRandomInfoOverHalf() {
		sqlSession.delete("random.deleteRandomInfoOverHalf");
	}

}
