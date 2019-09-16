<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/userlist_status.css">
</head>
<body>
	<div id="container">
		<h1>전체 회원 정보조회</h1>
		<table border="1" class="table">
			<tr>
				<th>이메일</th>
				<th>닉네임</th>
				<th>전화번호</th>
				<th>탈퇴여부</th>
				<th>회원등급</th>
			</tr>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="1">----가입된 회원이 존재하지 않습니다.----</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.email}</td>
							<td>${dto.nick}</td>
							<td>${dto.phone}</td>
							<td>${dto.enabled}</td>
							<td>${dto.role}</td>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>