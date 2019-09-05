package com.daos;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.dtos.UserDto;
import com.config.SqlMapConfig;

public class UserDao extends SqlMapConfig {

	public UserDao() {
		super();
	}
	
	private String nameSpace = "com.login.";
	
	//회원가입
	public boolean insertUser(UserDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(nameSpace+"insertUser", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	//로그인
	public UserDto getLogin(String email, String password) {
		UserDto dto = new UserDto();
		Map<String, String> map = new HashMap<>();
		map.put("email",email);
		map.put("password",password);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getLogin", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	//이메일 중복체크
	public UserDto emailChk(String email) {
		UserDto dto = new UserDto();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"emailChk", email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
}
