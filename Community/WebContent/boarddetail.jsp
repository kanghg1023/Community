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
<style type="text/css">
	#commentForm {display: none;}
	.recomment {display: none;}
	#container {
		height: 400px;
		width: 600px;
		border: 1px solid red;
		overflow: auto;
	}
	img{width: 12px; height: 12px;}
	
</style>
<script type="text/javascript">
	function delcomment(reseq){
		location.href="BoardController.do?command=delcomment&reseq="+reseq+"&seq=${dto.seq}";
	}
	
	$(function(){
		$("#commentBtn").click(function(){
			$("#commentForm").toggle(1000);
			var replyPosition = $("#commentForm").offset().top;
			$("#container").animate({
				"scrollTop":replyPosition
			},1000);
		});
		
		var reseq;
		
// 		$("td").off().on("click",".cancelBtn",function(){
// 			$("#recomment").remove();
// 			$(this).attr('class','recommentForm');
// 		});
		$("body").on("click",".recommentForm",function(){
			$("#recomment").remove();
			$(".cancelBtn").attr('class','recommentForm');
			reseq = $(this).val();
			var aCount = $(this).parent().parent().next();
			aCount.after("<tr id='recomment'>"+
					"<td></td>"+
					"<td><textarea rows='2' cols='55' id='content2' ></textarea>"+
					"<input type='button' id='recommentBtn' value='등록' />"+
					"</td></tr>");
			$(this).attr('class','cancelBtn');
		});
		
		$("body").on("click",".cancelBtn",function(){
			$("#recomment").remove();
 			$(this).attr('class','recommentForm');
		});
		
		$("body").on("click","#recommentBtn",function(){
			var content = $("#content2");
			if(content.val().length == 0){
				alert("내용을 입력하시오");
				content.focus();
				return false;
			}
			location.href="BoardController.do?command=recomment&seq=${dto.seq}&reseq="+reseq+"&content="+content.val();
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
			<button id="commentBtn">댓글</button>
			<c:if test="${ldto != null}">
				<button onclick="location.href='BoardController.do?command=replyForm&seq=${dto.seq}'">답글</button>
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
<div id="commentForm">
	<form action="BoardController.do" method="post">
		<input type="hidden" name="command" value="addcomment" />
		<input type="hidden" name="seq" value="${dto.seq}" />
		<c:if test="${ldto != null || clist != null}">
			<table border="1">
				<c:if test="${clist != null}">
					<c:forEach items="${clist}" var="cdto">
					<tr>
						<c:if test="${cdto.depth > 0}">
							<td rowspan="2"><img src="img/arrow.jpg" alt="답글" /></td>
						</c:if>
						<th>
							<jsp:setProperty property="emailNick" name="util" value="${cdto.email}" />
							<jsp:getProperty property="emailNick" name="util" />
						</th>
						<td>
							<fmt:formatDate value="${cdto.regdate}" pattern="yyyy-MM-dd"/>
							<c:if test="${ldto != null}">
								<button type="button" class="recommentForm" value="${cdto.reseq}">답글</button>
							</c:if>
							<c:if test="${cdto.email eq ldto.email}">
								<button type="button" onclick="delcomment(${cdto.reseq})">삭제</button>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="3">${cdto.content}</td>
					</tr>
					
					</c:forEach>
				</c:if>
				<c:if test="${ldto != null}">
					<tr>
						<td colspan="3">
							<textarea rows="2" cols="60" name="content" ></textarea>
							<input type="submit" value="등록" />
						</td>
					</tr>
				</c:if>
			</table>
		</c:if>
	</form>
</div>
</div>
</body>
</html>