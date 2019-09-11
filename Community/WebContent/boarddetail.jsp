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
<style type="text/css">
	#replyForm {display: none;}
	#container {
		height: 400px;
		width: 600px;
		border: 1px solid red;
		overflow: auto;
	}
</style>
<script type="text/javascript">
		
	function replyForm2(){
		$("#replyForm").hide(1000);
	}
	
	$(function(){
		$("#reply").click(function(){
			$("#replyForm").toggle(1000);
			var replyPosition = $("#replyForm").offset().top;
			$("#container").animate({
				"scrollTop":replyPosition
			},1000);
		});
		
		$("#like").click(function(){
			var aCount = $(this);
			
			$.ajax({
				url:"BoardController.do",
				data:{"command":"likechange","seq":"${dto.seq}"},
				method:"post",
				datatype:"text",
				async:false, // t=비동기 (되는대로 실행) / f=동기 (순서대로 실행)
				success:function(likechange){
					var a = likechange.split(",");
					if(eval(a[0])){
						aCount.val("<img alt='좋아요' src='img/heart1.png'>a[1]");
					}else {
						aCount.val("<img alt='좋아요' src='img/heart2.png'>a[1]");
					}
				},
				error:function(){
					alert("서버통신실패!!");
				}
			});
		});
		
		$("form").submit(function(){
			var title = $(this).find("input[name=title]");
			if(title.val().length == 0){
				alert("제목을 입력하시오");
				title.focus();
				return false;
			}
			var content = $(this).find("textarea[name=content]");
			if(content.val().length == 0){
				alert("내용을 입력하시오");
				content.focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<jsp:useBean id="util" class="com.utils.Util" />
<div id="container">
<h1>게시글 상세보기</h1>
<table border="1">
	<tr>
		<th>번호</th>
		<td>${dto.seq}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
			<jsp:getProperty property="emailNick" name="util" />
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.title}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.content}</textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="left">
			<c:if test="${ldto != null}">
				<button id="reply">답글</button>
			</c:if>
			<c:if test="${dto.email == ldto.email}">
				<button onclick="location.href='BoardController.do?command=updateForm&seq=${dto.seq}'">수정</button>
				<button onclick="location.href='BoardController.do?command=muldel&chk=${dto.seq}'">삭제</button>
			</c:if>
			<button onclick="location.href='BoardController.do?command=boardlist'">목록</button>
			<c:choose>
				<c:when test="${ldto != null}">
					<a href="" id="like"><img alt="좋아요" src="img/heart${like ? '2' : '1'}.png">${likecount}</a>
				</c:when>
				<c:otherwise>
					<img alt="좋아요" src="img/heart1.png">${likecount}
				</c:otherwise>
			</c:choose>
			
		</td>
	</tr>
</table>
<div id="replyForm">
	<h1>답글달기</h1>
	<form action="BoardController.do" method="post">
	<input type="hidden" name="command" value="replyboard" />
	<input type="hidden" name="seq" value="${dto.seq}" />
	<table border="1">
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" /></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" name="content" ></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="완료" />
				<input type="button" value="취소" onclick="replyForm2()" />
			</td>
		</tr>
	</table>
	</form>
</div>
</div>
</body>
</html>