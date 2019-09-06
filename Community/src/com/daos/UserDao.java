package com.daos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	
	public List<UserDto> getAllUserStatus(){
		List<UserDto> list = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"getAllUserStatus");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public List<UserDto> getAllUserList(){
		List<UserDto> list = new ArrayList<>();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"getAllUserList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	public boolean authchange(String email, String role){
		int count = 0; 
		Map<String, String> map = new HashMap<>();
		map.put("email",email);
		map.put("role",role);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"authchange", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	
	public boolean userUpdate(UserDto dto){
		int count = 0; 
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"userUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	public boolean withdraw(String email){
		int count = 0; 
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"withdraw", email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	
	
	public UserDto getInfo(String email) {
		UserDto dto = new UserDto();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getInfo", email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	
}
