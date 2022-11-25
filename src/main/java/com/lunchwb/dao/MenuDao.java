package com.lunchwb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lunchwb.vo.MenuVo;

@Repository
public class MenuDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<MenuVo> menuList(int storeNo) {
		List<MenuVo> menuList = sqlSession.selectList("menu.menuList", storeNo);
		return menuList;
	}

}
