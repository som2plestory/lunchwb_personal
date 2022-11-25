package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.FaqVo;

@Repository
public class FaqDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<FaqVo> faqList(){
		List<FaqVo> faqList = sqlSession.selectList("faq.faqList");  
		
		
		return faqList;
	};
	

}
