package com.utils;

import org.apache.ibatis.session.SqlSession;

import com.config.SqlMapConfig;

public class Util extends SqlMapConfig {

	private String arrowNbsp; //depth의 크기만큼 공백
	private String emailNick; //이메일을 닉네임으로
	private String kindchange;
	
	public String getKindchange() {
		return kindchange;
	}

	public void setKindchange(String kindseq) {
		String kind = "";
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			kind = sqlSession.selectOne("com.board.setKindchange",kindseq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		this.kindchange = kind;
	}

	public String getEmailNick() {
		return emailNick;
	}

	public void setEmailNick(String email) {
		String nick = "";
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			nick = sqlSession.selectOne("com.board.emailNick",email);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		this.emailNick = nick;
	}
	
	public String getArrowNbsp() {
		return arrowNbsp;
	}

	public void setArrowNbsp(String depth) {
		String nbsp = "";
		int depthInt = Integer.parseInt(depth);
		for (int i = 0; i < depthInt; i++) {
			nbsp += "&nbsp;&nbsp;&nbsp;";
		}
		//					답글이면 nbsp+<img> 출력, 부모글이면 ""
		this.arrowNbsp = depthInt>0 ? nbsp+"<img src='img/arrow.jpg' alt='답글' />" : "";
	}
	
}
