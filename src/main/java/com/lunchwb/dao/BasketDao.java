package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.StoreVo;

@Repository
public class BasketDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	public List<StoreVo> guestStoreRecommend(Map<String, Object> basketInput) {
		List<StoreVo> basketItem = sqlSession.selectList("store.guestStoreRecommend", basketInput);
		
		return basketItem;
	}
	
	
	public List<StoreVo> groupStoreRecommend(Map<String, Object> basketInput) {
		List<StoreVo> basketItem = sqlSession.selectList("store.groupStoreRecommend", basketInput);
		
		return basketItem;
	}
}
