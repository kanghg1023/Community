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
<title>정보수정하기</title>
</head>
<body>
<form action="LoginController.do">
	<input type="hidden" name="command" value="update"/>
	<input type="hidden" name="email" value="<%=ldto.getEmail()%>"/>
	<table border="1">
		<tr>
			<th>이메일</th>
			<td><%=ldto.getEmail()%></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nick" value="<%=ldto.getNick()%>"/></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="text" name="phone" value="<%=ldto.getPhone()%>"/></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="정보수정"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>