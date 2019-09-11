<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보보기</title>
</head>
<body>
<h1>내 정보보기</h1>
<table border="1">
	<tr>
		<th>이메일</th>
		<td>${ldto.email}</td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>${ldto.nick}</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>${ldto.phone}</td>
	</tr>
	<tr>
		<th>회원등급</th>
		<td>${ldto.role eq "USER" ? "일반회원" : "정회원"}</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<button onclick="location.href='LoginController.do?command=withdraw&email=${ldto.email}'">회원탈퇴</button>
			<button onclick="location.href='LoginController.do?command=userUpdate'">정보수정</button>
		</td>
	</tr>
</table>
</body>
</html>