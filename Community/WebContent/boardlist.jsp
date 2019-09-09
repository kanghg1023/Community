<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	$(function(){
		$("#searchBtn").click(function(){
			var searchType = document.getElementById("searchType").value;
			var search = document.getElementById("search").value;
			location.href="BoardController.do?command=boardlist&pNum=1&searchType="+searchType+"&search="+search;
		});
		
		$("form").submit(function(){
			var bool = true;
			var count = $(this).find("input[name=chk]:checked").length; //체크된 input태그의 개수
			if(count == 0){
				alert("하나이상 선택하시오");
				bool = false;
			}
			return bool;
		});
	});
</script>
<style type="text/css">
	img{width: 12px; height: 12px;}
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<jsp:useBean id="util" class="com.utils.Util" />
<h1>글목록보기</h1>
<form action="BoardController.do" method="post">
<input type="hidden" name="command" value="muldel" />
<div>
	<select id="searchType">
		<option value="title">제목</option>
		<option value="nick">닉네임</option>
	</select>
	<input type="text" id="search" />
	<input type="button" id="searchBtn" value="검색" />
</div>
<table border="1">
	<col width="50px" />
	<col width="50px" />
	<col width="300px" />
	<col width="100px" />
	<col width="100px" />
	<col width="50px" />
	<tr>
		<th><input type="checkbox" name="all" onclick="allSel(this)" /></th>
		<th>번호</th>
		<th>제 목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:choose>
		<c:when test="${empty list}">
			<tr>
				<td colspan="10">----작성된 글이 없습니다.----</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${list}" var="dto">
				<tr align="center">
					<td>
						<c:if test="${dto.email == ldto.email}">
							<input type="checkbox" name="chk" value="${dto.seq}" />
						</c:if>
					</td>
					<td>${dto.seq}</td>
					<c:choose>
						<c:when test="${dto.enabled eq 'Y'}">
							<td>----삭제된 게시글입니다.----</td>
						</c:when>
						<c:otherwise>
							<td align="left">
								<jsp:setProperty property="arrowNbsp" name="util" value="${dto.depth}" />
								<jsp:getProperty property="arrowNbsp" name="util" />
								<a href="BoardController.do?command=boarddetail&seq=${dto.seq}">${dto.title}</a>
							</td>
						</c:otherwise>
					</c:choose>
					<td>
						<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
						<jsp:getProperty property="emailNick" name="util" />
					</td>
					<td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd"/></td>
					<td>${dto.readcount}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" align="center">
					<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.prePageNum}">◀</a>
					<c:forEach var="i" begin="1" end="${map.endPage}">
						<c:choose>
							<c:when test="${i == pNum}">
								<c:out value="${i}" />
							</c:when>
							<c:otherwise>
								<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${i}"><c:out value="${i}" /></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.nextPageNum}">▶</a>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
	<tr>
		<td colspan="6">
			<input type="button" value="글추가" onclick="location.href='BoardController.do?command=insertForm'" />
			<input type="submit" value="글삭제" />
		</td>
	</tr>
</table>
</form>
</body>
</html>