package com.daos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public boolean addlist(ListDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"addlist",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	public List<ListDto> sublist() {
		List<ListDto> list = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"sublist");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return list;
	}
	
	public boolean openlist(String[] kindseqs) {
		int count = 0;
		Map<String, String[]> map = new HashMap<>();
		map.put("kindseqs",kindseqs);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"openlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return count>0 ? true : false;
	}
	
}
