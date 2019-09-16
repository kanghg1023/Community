<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
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
<link rel="stylesheet" href="css/userlist.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div id="container">
		<h1>회원 리스트 조회</h1>
		<table border="1" class="table">
			<tr>
				<th>이메일</th>
				<th>닉네임</th>
				<th>등급</th>
			</tr>
			<c:forEach items="${list}" var="dto">
				<tr>
					<td>${dto.email}</td>
					<td><a
						href="LoginController.do?command=useroutfrom&email=${dto.email}" title="강제탈퇴">${dto.nick}</a>
					</td>
					<c:choose>
						<c:when test="${dto.role eq 'ADMIN'}">
							<td>관리자</td>
						</c:when>
						<c:otherwise>
							<td><select name="role">
									<option value="MANAGER"
										${dto.role eq "MANAGER" ? "selected" : ""}>정회원</option>
									<option value="MANAGER" ${dto.role eq "USER" ? "selected" : ""}>일반회원</option>
							</select>
								<button onclick="authchange(${dto.email},this)">변경</button></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
	<script type="text/javascript">
	function authchange(email,btn){
// 		var role = $("#"+email);
// 		alert(role);
// 		alert($(btn).prev("select").prop("tagName"));
		var role = $(btn).prev("select").val();
// 		alert(role);
		location.href="LoginController.do?command=authchange&email="+email+"&role="+role;
	}
	</script>
	</div>
</body>
</html>