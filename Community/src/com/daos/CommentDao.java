package com.daos;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.config.SqlMapConfig;
import com.dtos.CommentDto;

public class CommentDao extends SqlMapConfig{
	
	private String nameSpace = "com.comment.";
	
	public List<CommentDto> commentList(String seq) {
		List<CommentDto> clist = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			clist = sqlSession.selectList(nameSpace+"commentList", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return clist;
	}
	
	public boolean addcomment(CommentDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"addcomment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	public boolean recomment(CommentDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"recomment", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	public boolean delcomment(int reseq) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.delete(nameSpace+"delcomment", reseq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
}
