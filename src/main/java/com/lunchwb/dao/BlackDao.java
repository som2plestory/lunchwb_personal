package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.BlacklistVo;

@Repository
public class BlackDao {
	
	@Autowired
	SqlSession sqlSession;

	
	/******************** 블랙리스트 ***********************************************/
	public List<BlacklistVo> blacklist(int groupNo){
		return sqlSession.selectList("blacklist.blacklist", groupNo);
	}
	
	/******************** 블랙한 가게인가? *******************************************/
	public int isBlack(BlacklistVo blackVo) {
		return sqlSession.selectOne("blacklist.isBlack", blackVo);
	}
	
	/*********************** 블랙스토어 정보(1건) ************************************/
	public BlacklistVo blackStore(int blackNo) {
		return sqlSession.selectOne("blacklist.blackStore", blackNo);
	}
	
	/*********************** 블랙추가 *********************************************/
	public int addBlack(BlacklistVo blackVo) {
		return sqlSession.insert("blacklist.addBlack", blackVo);
	}
	
	/*********************** 블랙삭제 *********************************************/
	public int deleteBlack(BlacklistVo blackVo) {
		return sqlSession.delete("blacklist.deleteBlack", blackVo);
	}
	
	/*********************** 가게 검색(블랙 제외) ************************************/
	public List<BlacklistVo> blackStoreSearch(BlacklistVo blackVo){
		return sqlSession.selectList("blacklist.blackStoreSearch", blackVo);
	}
	

}
