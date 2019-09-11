<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1>등급변경</h1>
<form action="LoginController.do" method="post">
	<input type="hidden" name="command" value="userout" />
	<input type="hidden" name="email" value="${dto.email}" />
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>${dto.email}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${dto.nick}</td>
		</tr>
		<tr>
			<th>등급</th>
			<td>
				<c:choose>
					<c:when test="${dto.role eq 'ADMIN'}">
						관리자
					</c:when>
					<c:when test="${dto.role eq 'MANAGER'}">
						정회원
					</c:when>
					<c:otherwise>
						일반회원
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:if test="${dto.role != 'ADMIN'}">
			<tr>
				<td colspan="2">
					<input type="submit" value="강제탈퇴" />
				</td>
			</tr>
		</c:if>
	</table>
</form>
</body>
</html>