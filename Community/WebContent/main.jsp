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
<link rel="stylesheet" href="css/main.css">
<script type="text/javascript">
	function regist(){
		location.href="LoginController.do?command=regist";
	}
</script>
</head>
<body>
<jsp:useBean id="util" class="com.utils.Util" />
<!-- 	상단로고 -->
	<div id="logo">
		<a href="index.jsp"> <img src="img/logo.jpg" alt="홈" /></a>
	</div>
<ul class="line">
  <li><a href="#"></a></li>
</ul>
<!-- 	/상단로고 -->
<div id="main_content"><!-- 메인컨텐츠 -->
<div id="rightbar"><!-- 오른쪽바 -->
<div id="login"><!-- 로그인폼 -->
<div class="wrapper">
  <div id="formContent">
<c:choose>
	<c:when test="${ldto == null}">
		<form action="LoginController.do" method="post">
			<input type="hidden" name="command" value="login" />
			<form>
					<input type="email" name="email" id="email" placeholder="이메일"/>
					<input type="password" name="password" id="password" placeholder="비밀번호"/>
					<input type="submit" value="로그인" />
					<input type="button" value="회원가입" onclick="regist()" />
			</form>
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
</div><!-- #formContent -->
</div><!-- .wrapper -->
</div><!-- /로그인폼 -->
<div id="best"><!-- 베스트 -->
<div class="wrapper">
<h4>베스트 게시글</h4>
<table border="1" class="sel">
	<tr>
		<td>제목</td>
		<td>작성자</td>
		<td><img alt="좋아요" src="img/heart2.png"></td>
	</tr>
	<c:forEach items="${bestlist}" var="dto">
		<tr>
			<td>
				<a href="BoardController.do?command=boarddetail&seq=${dto.seq}&kindseq=${dto.kindseq}">${dto.title}</a>
			</td>
			<td>
				<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
				<jsp:getProperty property="emailNick" name="util" />
			</td>
			<td>${dto.rk}</td>
		</tr>
	</c:forEach>
</table>
</div><!-- .wrapper -->
</div><!-- /베스트 -->
</div><!-- /오른쪽바 -->
<c:if test="${msg != null}">
	<script type="text/javascript">
		alert("${msg}");
	</script>
</c:if>
<div id="centerbar"><!-- 중간바 -->
<div id="list"><!-- 게시판목록 -->
<h3>게시판목록</h3>
<ul>
<c:forEach items="${blist}" var="list">
	<c:if test="${list.enabled eq 'Y'}">
		<li><a href="BoardController.do?command=boardlist&kindseq=${list.kindseq}&pNum=1">${list.kind}</a></li>
	</c:if>
</c:forEach>
</ul>
</div><!-- /게시판목록 -->
</div><!-- /중간바 -->
</div><!-- /메인컨텐츠 -->
</body>
</html>