package com.lunchwb.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.ReportVo;

@Repository
public class ReportDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	/* 리뷰 신고 */
	public int reviewReport(ReportVo reportVo) {
		int count = sqlSession.insert("report.reviewReport", reportVo);
		return count;
	}
}
