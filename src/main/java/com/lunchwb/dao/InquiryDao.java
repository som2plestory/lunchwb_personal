package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.InquiryVo;

@Repository
public class InquiryDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<InquiryVo> userInqList(int userNo){
		List<InquiryVo> userInqList = sqlSession.selectList("inquiry.inquiryList",userNo);
		
		return userInqList;
	};	
	
	
	public int writeInquiry(InquiryVo inqVo) {
		int count = sqlSession.insert("inquiry.writeInquiry",inqVo);
		
		return count;
	};
	
	public InquiryVo getInq(int inquiryNo){
		InquiryVo inqVo = sqlSession.selectOne("inquiry.readInquiry",inquiryNo);
		
		return inqVo;
	};
	
	
	

}
