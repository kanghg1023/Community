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
<script type="text/javascript">
	$(function(){
		$("form").submit(function(){
			var kind = $(this).find("input[name=kind]");
			if(kind.val().length == 0){
				alert("게시판 제목을 입력하시오");
				kind.focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<c:choose>
	<c:when test="${ldto.role eq 'ADMIN'}">
		<h1>게시판 추가하기</h1>
	</c:when>
	<c:otherwise>
		<h1>게시판 신청하기</h1>
	</c:otherwise>
</c:choose>
<form action="ListController.do" method="post">
	<input type="hidden" name="command" value="addlist" />
	<c:choose>
		<c:when test="${ldto.role eq 'ADMIN'}">
			<input type="hidden" name="enabled" value="Y" />
		</c:when>
		<c:otherwise>
			<input type="hidden" name="enabled" value="N" />
		</c:otherwise>
	</c:choose>
	<table border="1">
		<tr>
			<th>게시판 제목</th>
			<td><input type="text" name="kind" /></td>
		</tr>
		<tr>
			<th>게시판 소개</th>
			<td><textarea rows="10" cols="60" name="kindcontent"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="완료" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>