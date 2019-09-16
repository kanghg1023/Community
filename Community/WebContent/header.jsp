<%@page import="com.dtos.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	UserDto ldto = (UserDto)session.getAttribute("ldto");
%>
	<a href="index.jsp"><img src="img/head_logo.jpg"
				alt="메인메뉴" /></a>
<hr />
</body>
</html>