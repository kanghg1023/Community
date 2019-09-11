package com.daos;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.config.SqlMapConfig;
import com.dtos.LikeDto;

public class LikeDao extends SqlMapConfig{

	private String nameSpace = "com.like.";
	
	public boolean getLike(LikeDto dto){
		LikeDto likedto = new LikeDto();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			likedto = sqlSession.selectOne(nameSpace+"getLike", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return likedto!=null ? true : false;
	}
	
	public int likeCount(String seq) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.selectOne(nameSpace+"likeCount", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count;
	}
	
	public boolean insertLike(LikeDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"insertLike", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	public boolean deleteLike(LikeDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"deleteLike", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
}
