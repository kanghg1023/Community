<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<link rel="stylesheet" href="css/boardlist.css">
<script type="text/javascript">
	function allSel(ele) {
		$("input[name=chk]").prop("checked", $(ele).prop("checked"));
	}

	$(function() {
		$("#pmoveBtn").click(function() {
			var pNum = $("#pmove").val();
			var endPage = ${map.endPage};
			if(pNum > endPage){
				pNum = endPage;
			}
			location.href = "BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum="+pNum;
		});

		$("#searchBtn").click(function() {
			var searchType = $("#searchType").val();
			var search = $("#search").val();
			location.href = "BoardController.do?command=boardlist&pNum=1&searchType="+searchType+"&search="+search;
		});

		$("form").submit(function() {
			var bool = true;
			var count = $(this).find("input[name=chk]:checked").length; //체크된 input태그의 개수
			if (count == 0) {
				alert("하나이상 선택하시오");
				bool = false;
			}else{
				var isDel = confirm(count+" 개 게시글을 정말 삭제하시겠습니까?");
				if(!(isDel)){
					bool = false;
				}
			}
			return bool;
		});
	});
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<jsp:useBean id="util" class="com.utils.Util" />
	<h1>
		<jsp:setProperty property="kindchange" name="util" value="${kindseq}" />
		<jsp:getProperty property="kindchange" name="util" />
		갤러리
	</h1>
	<form action="BoardController.do" method="post">
		<input type="hidden" name="command" value="muldel" />
		<div id="container">
			<table border="1" class="table">
				<col width="30px" />
				<col width="30px" />
				<col width="300px" />
				<col width="100px" />
				<col width="100px" />
				<col width="30px" />
				<tr>
					<td colspan="6">
						<select id="searchType">
							<option value="title">제목</option>
							<option value="nick">닉네임</option>
						</select> 
						<input type="text" id="search" /> <input type="button" id="searchBtn" value="검색" />
					</td>
				<tr>
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
							<td colspan="10" id="noList">----작성된 글이 없습니다.----</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list}" var="dto">
							<tr align="center">
								<td id="chk"><c:if test="${dto.email == ldto.email}">
										<input type="checkbox" name="chk" value="${dto.seq}" />
									</c:if></td>
								<td id="seq">${dto.seq}</td>
								<c:choose>
									<c:when test="${dto.enabled eq 'Y'}">
										<td id="title1">----삭제된 게시글입니다.----</td>
									</c:when>
									<c:otherwise>
										<td align="left" id="title2">
											<jsp:setProperty property="arrowNbsp" name="util" value="${dto.depth}" />
											<jsp:getProperty property="arrowNbsp" name="util" />
											<a href="BoardController.do?command=boarddetail&seq=${dto.seq}">${dto.title}</a>
										</td>
									</c:otherwise>
								</c:choose>
								<td id="nick">
									<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
									<jsp:getProperty property="emailNick" name="util" />
								</td>
								<td id="regdate">
									<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd" />
								</td>
								<td id="cnt">${dto.readcount}</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6" align="center">
								<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.prePageNum}">◀</a>
								<c:choose>
									<c:when test="${pNum==null || pNum==''}">
										<input type="text" id="pmove" value="1" />
									</c:when>
									<c:otherwise>
										<input type="text" id="pmove" value="${pNum}" />
									</c:otherwise>
								</c:choose>
								&nbsp;/&nbsp;${map.endPage}
								<a href="BoardController.do?command=boardlist&searchType=${searchType}&search=${search}&pNum=${map.nextPageNum}">▶</a>
								<input type="button" id="pmoveBtn" value="이동" />
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<c:if test="${ldto != null}">
				<tr>
					<td colspan="6">
						<input type="button" value="글추가" onclick="location.href='BoardController.do?command=insertForm'" id="btn1" />
						<input type="submit" value="글삭제" id="btn2" />
					</td>
				</tr>
				</c:if> 
			</table>
		</div>
	</form>
</body>
</html>