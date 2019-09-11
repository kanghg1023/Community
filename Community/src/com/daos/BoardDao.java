package com.daos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.config.SqlMapConfig;
import com.dtos.BoardDto;
import com.dtos.LikeDto;

public class BoardDao extends SqlMapConfig {
	
private String nameSpace = "com.board.";
	
	public BoardDao() {
		super();
	}
	
	//글 목록 조회(list 반환)
	public List<BoardDto> getAllList(String kindseq, String pNum){
		List<BoardDto> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("kindseq",kindseq);
		map.put("pNum",pNum);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"boardlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	//새글 추가
	public boolean insertBoard(BoardDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"insertBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	//글 상세보기(AnsDto반환)
	public BoardDto getBoard(String kindseq, String seq){
		BoardDto dto = new BoardDto();
		
		SqlSession sqlSession = null;
		Map<String, String> map = new HashMap<>();
		map.put("kindseq",kindseq);
		map.put("seq",seq);
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	
	
	//글 수정하기(title,content 전달받음)
	public boolean updateBoard(BoardDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	//글 삭제하기(+여러글) (seq)
	public boolean mulDel(String[] seqs) {
		int count = 0;
		Map<String, String[]> map = new HashMap<>();
		map.put("seqs", seqs);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"mulDel", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	//조회수증가(seq)
	public boolean readCount(String seq) {
		int count = 0;

		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"readCount", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	//답글달기
	public boolean replyBoard(BoardDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(false);
			sqlSession.update(nameSpace+"replyUpdate", dto);
			count = sqlSession.insert(nameSpace+"replyInsert", dto);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	// 페이징
	public int pageMax(String kindseq) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.selectOne(nameSpace+"pageMax", kindseq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count;
	}
	
	public int pageMaxSearchTitle(String kindseq, String title) {
		int count = 0;
		Map<String, String> map = new HashMap<>();
		map.put("title",title);
		map.put("kindseq",kindseq);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.selectOne(nameSpace+"pageMaxSearchTitle",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count;
	}
	
	public int pageMaxSearchEmail(String kindseq, String email) {
		int count = 0;
		Map<String, String> map = new HashMap<>();
		map.put("kindseq",kindseq);
		map.put("email",email);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.selectOne(nameSpace+"pageMaxSearchEmail",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count;
	}
	
	//검색
	//제목검색
	public List<BoardDto> searchTitle(String title, String kindseq, String pNum){
		List<BoardDto> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("title",title);
		map.put("kindseq",kindseq);
		map.put("pNum",pNum);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"boardlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	//닉네임을 이메일로
	public String nickEmail(String nick) {
		String email = "";
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			email = sqlSession.selectOne(nameSpace+"nickEmail", nick);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return email;
	}
	
	//이메일 검색
	public List<BoardDto> searchEmail(String email, String kindseq, String pNum){
		List<BoardDto> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("email",email);
		map.put("kindseq",kindseq);
		map.put("pNum",pNum);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"boardlist",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
}
