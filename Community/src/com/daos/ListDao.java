package com.daos;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.config.SqlMapConfig;
import com.dtos.ListDto;

public class ListDao extends SqlMapConfig{

	private String nameSpace = "com.list.";
	
	public List<ListDto> listlist() {
		List<ListDto> list = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"list");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return list;
	}
	
}
