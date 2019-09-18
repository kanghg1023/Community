<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<link rel="stylesheet" href="css/useroutfrom.css">
<script type="text/javascript">
	$(function() {
		$("form").submit(function(){
			var isDel = confirm("정말 탈퇴 시키시겠습니까?");
			if(isDel) {
				location.href = "LoginController.do?command=userout&withdraw&withdraw=${dto.email}";
			}else{
				return false;
			}
		});
	});
</script>
</head>
<body>
<div id="container">
<h3>아래 회원을 강제 탈퇴 시키시겠습니까?</h3>
<form action="LoginController.do" method="post">
	<input type="hidden" name="command" value="userout" />
	<input type="hidden" name="email" value="${dto.email}" />
	<table border="1" class="table">
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
					<input type="submit" value="강제탈퇴" class="button"/>
				</td>
			</tr>
		</c:if>
	</table>
</form>
</div>

</body>
</html>