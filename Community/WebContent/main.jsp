<%@page import="com.dtos.UserDto"%>
<%@page import="com.dtos.ListDto"%>
<%@page import="com.daos.ListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>
<script type="text/javascript">
	function regist(){
		location.href="LoginController.do?command=regist";
	}
</script>
</head>
<body>
<jsp:useBean id="util" class="com.utils.Util" />
<c:choose>
	<c:when test="${ldto == null}">
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
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${ldto.role eq 'ADMIN'}">
				<div>
					${ldto.nick}님 반갑습니다.
					<a href="LoginController.do?command=logout">로그아웃</a>
				</div>
				<ul>
					<li><a href="LoginController.do?command=alluserstatus">전체회원정보</a></li>
					<li><a href="LoginController.do?command=alluserlist">사용중인회원목록</a></li>
					<li><a href="ListController.do?command=listadmin">게시판 관리</a>
				</ul>
			</c:when>
			<c:otherwise>
				<div>
					${ldto.nick}님 반갑습니다.(등급 : 
					<c:choose>
						<c:when test="${ldto.role eq 'USER'}">
							일반회원)
						</c:when>
						<c:otherwise>
							정회원)
						</c:otherwise>
					</c:choose>
					<a href="LoginController.do?command=logout">로그아웃</a>
				</div>
				<ul>
					<li><a href="LoginController.do?command=userinfo&email=${ldto.email}">내 정보보기</a></li>
					<li><a href="ListController.do?command=addlistfrom">게시판 신청하기</a>
				</ul>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<c:if test="${msg != null}">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>
			
<h3>게시판목록</h3>
<ul>
<c:forEach items="${blist}" var="list">
	<c:if test="${list.enabled eq 'Y'}">
		<li><a href="BoardController.do?command=boardlist&kindseq=${list.kindseq}&pNum=1">${list.kind}</a></li>
	</c:if>
</c:forEach>
</ul>
<h3>베스트 게시글</h3>
<table border="1">
	<c:forEach items="${bestlist}" var="dto">
		<tr>
			<td>
				<a href="BoardController.do?command=boarddetail&seq=${dto.seq}">${dto.title}</a>
			</td>
			<th>
				<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
				<jsp:getProperty property="emailNick" name="util" />
			</th>
		</tr>
	</c:forEach>
</table>
</body>
</html>