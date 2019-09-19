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
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title>정보수정하기</title>
<link rel="stylesheet" href="css/userupdate.css">
<script src="js/userupdate.js"></script>
</head>
<body>
<div id="container">
<h2>내 정보 수정</h2>
<form action="LoginController.do">
	<input type="hidden" name="command" value="update"/>
	<input type="hidden" name="email" value="${ldto.email}"/>
	<table border="1" class="table">
		<tr>
			<th>이메일</th>
			<td>${ldto.email}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nick" value="${ldto.nick}" id="nick"/></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="phone" value="${ldto.phone}" id="phone"/></td>
		</tr>
		<tr>
			<td colspan="2" id="btn">
				<input type="submit" value="정보수정" class="button"/>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>