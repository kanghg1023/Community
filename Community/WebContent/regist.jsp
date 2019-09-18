<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<link rel="stylesheet" href="css/regist.css">
<link rel="stylesheet" href="css/button.css">
<script src="js/regist.js"></script>
</head>
<body>
	<div id="container">
		<!-- 상단 로고 -->
		<div id="logo">
			<a href="index.jsp"> <img src="img/logo.jpg"
				alt="홈" />
			</a>
		</div>
		<!-- LoginController.do -->
		
		<form action="LoginController.do" method="post">
			<input type="hidden" name="command" value="insertuser" />
			<table border="1" class="table">
				<tr>
					<td scope="row" colspan="2" class="info">'인사이드낫아웃사이드'는 대한민국 인터넷 최소의 커뮤니티 사이트이다. 
					다른 커뮤니티의 게시판격에 해당되는 갤러리 서비스로 이루어져 있다. 
					각각의 갤러리마다 매우 다양한 성향을 가지고 있으며 익명성이 강한 것이 공통된 특징이다. 
					설립 당시부터 현재에 이르기까지 한국의 인터넷 문화에 좋든 나쁘든 엄청난 영향을 끼치고 있지 않은 사이트이다.</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td><input type="email" name="email" id="email" /></td>
				</tr>
				<tr>
					<th scope="row">비밀번호</th>
					<td><input type="password" name="password" id="pw" /></td>
				</tr>
				<tr>
					<th scope="row">비밀번호 확인</th>
					<td><input type="password" name="password2" id="pw2" /></td>
				</tr>
				<tr>
					<th scope="row">별명</th>
					<td><input type="text" name="nick" id="nick" /></td>
				</tr>
				<tr>
					<th scope="row">전화번호</th>
					<td><input type="tel" name="phone" id="phone" /></td>
				</tr>
				<tr>
					<td colspan="2" class="btn">
						<input type="submit" value="가입완료" class="button" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>