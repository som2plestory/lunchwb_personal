package com.lunchwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.StoreVo;

@Repository
public class StoreDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	/* 가게 기본 정보 불러오기 */
	public StoreVo basicStoreInfo(int storeNo) {
		StoreVo StoreBasic = sqlSession.selectOne("store.basicStoreInfo", storeNo);
		return StoreBasic;
	}
	
	
	/* 가게와의 거리 */
	public int storeDistance(Map<String, Object> map) {
		int distance = sqlSession.selectOne("store.storeDistance", map);
		return distance;
	}
	
	
	/* 같은 카테 다른 가게(3곳) */
	public List<StoreVo> sameCateOtherStores(Map<String, Object> map){
		List<StoreVo> otherStores = sqlSession.selectList("store.sameCateOtherStores", map);
		return otherStores;
	}
	
	
	/* 가게 정보 따로 불러오기 */
	public StoreVo selectOneStore(Map<String, Object> map) {
		return sqlSession.selectOne("store.selectOneStore", map);
	}
}
