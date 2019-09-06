<%@page import="com.dtos.UserDto"%>
<%@page import="com.dtos.ListDto"%>
<%@page import="java.util.List"%>
<%@page import="com.daos.ListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
<script type="text/javascript">
	function regist(){
		location.href="LoginController.do?command=regist";
	}
</script>
</head>
<body>
	<%
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(ldto == null){
			%>
			<h1>로그인</h1>
			<form action="LoginController.do" method="post">
				<input type="hidden" name="command" value="login" />
				<table border="1">
					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" /></td>
					</tr>
					<tr>
						<th>패스워드</th>
						<td><input type="password" name="password" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="로그인" />
							<input type="button" value="회원가입" onclick="regist()" />
						</td>
					</tr>
				</table>
			</form>
			
			<%
		}else{
			if(ldto.getRole().equals("ADMIN")){
				%>
				<div>
					<%=ldto.getNick()%>님 반갑습니다.
					<a href="LoginController.do?command=logout">로그아웃</a>
				</div>
				<ul>
					<li><a href="LoginController.do?command=alluserstatus">전체회원정보</a></li>
					<li><a href="LoginController.do?command=alluserlist">사용중인회원목록</a></li>
				</ul>
				<%
			}else {
				%>
				<div>
					<%=ldto.getNick()%>님 반갑습니다.(등급 : <%=ldto.getRole().equals("USER") ? "일반회원" : "정회원"%>)
					<a href="LoginController.do?command=logout">로그아웃</a>
				</div>
				<ul>
					<li><a href="LoginController.do?command=userinfo&email=<%=ldto.getEmail()%>">내 정보보기</a></li>
				</ul>
				<%
			}
		}
		%>
		<h3>게시판목록</h3>
		<ul>
		<%
		ListDao dao = new ListDao();
		List<ListDto> list = dao.listlist();
		
		for(int i=0;i<list.size();i++){
			if(list.get(i).getEnabled().equals("Y")){
				%>
				<li><a href=""><%=list.get(i).getKind()%></a></li>
				<%
			}
		}
	%>
	</ul>
</body>
</html>