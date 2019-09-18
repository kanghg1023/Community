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
<link rel="stylesheet" href="css/listadmin.css">
<script type="text/javascript">
	function allSel(ele){
		$("input[name=chk]").prop("checked",$(ele).prop("checked"));
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
<div id="container">
<h2>개설 대기중인 갤러리</h2>
<form action="ListController.do" method="post">
<input type="hidden" name="command" value="openlist" />
<table border="1" class="table">
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
		<th>게시판 제목</th>
		<th>게시판 소개</th>
	</tr>
	<c:choose>
		<c:when test="${blist != null}">
			<c:forEach items="${blist}" var="list">
				<tr>
					<td id="chk"><input type="checkbox" name="chk" value="${list.kindseq}"></td>
					<td id="kind">${list.kind}</td>
					<td id="kc">${list.kindcontent}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="3" align="right" id="btn">
					<input type="submit" value="게시판 개설" class="button" />
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
<a href="ListController.do?command=addlistfrom" title="바로 추가">[게시판 추가하기]</a>
<table border="1" class="table">
	<tr>
		<th>게시판명</th>
		<th>게시판 소개</th>
		<th>상태</th>
	</tr>
	<c:forEach items="${alist}" var="list">
		<tr>
			<td>${list.kind}</td>
			<td>${list.kindcontent}</td>
			<td>
				<select name="role">
					<option value="Y" ${list.enabled eq "Y" ? "selected" : ""}>개설</option>
					<option value="S" ${list.enabled eq "S" ? "selected" : ""}>폐쇄</option>
				</select>
				<button class="listchange" value="${dto.email}">변경</button>
			</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="3" align="center">
			<a href="ListController.do?command=listadmin&listpNum=${map.prePageNum}">◀</a>
			<input type="text" id="pmove" value="${listpNum}" />
			&nbsp;/&nbsp;${map.endPage}
			<a href="ListController.do?command=listadmin&listpNum=${map.nextPageNum}">▶</a>
			<input type="button" id="pmoveBtn" value="이동" />
		</td>
	</tr>
</table>
</div>
</body>
</html>