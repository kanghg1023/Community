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
	function allSel(ele){
		$("input[name=chk]").prop("checked",$(ele).prop("checked"));
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<form action="ListController.do" method="post">
<input type="hidden" name="command" value="openlist" />
<table border="1">
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
		<th>게시판 제목</th>
		<th>게시판 소개</th>
	</tr>
	<c:choose>
		<c:when test="${blist != null}">
			<c:forEach items="${blist}" var="list">
				<tr>
					<td><input type="checkbox" name="chk" value="${list.kindseq}"></td>
					<td>${list.kind}</td>
					<td>${list.kindcontent}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="3" align="right">
					<input type="submit" value="게시판 개설" />
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<td>신청된 게시판이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>
</form>
<ul><li><a href="ListController.do?command=addlistfrom">게시판 추가하기</a></li></ul>
</body>
</html>