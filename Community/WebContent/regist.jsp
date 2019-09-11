<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<script src="js/regist.js"></script>
</head>
<body>
<h1>회원가입</h1>
<!-- LoginController.do -->
<form action="LoginController.do" method="post">
	<input type="hidden" name="command" value="insertuser" />
	<table border="1">
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email" id="email" /></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" id="pw" /></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="password2" id="pw2" /></td>
		</tr>
		<tr>
			<th>별명</th>
			<td><input type="text" name="nick" id="nick" /></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="tel" name="phone" id="phone" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="가입완료" />
			</td>
		</tr>
	</table>
</form>

</body>
</html>