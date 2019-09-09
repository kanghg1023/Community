<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<title></title>
<script type="text/javascript">

	$(function(){
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
		
// 		$("form").submit(function(){
// 			var bool = true;
// 			vat input = $(this).find("td").children().filter("[name]");
// 			input.each(function(i){
// 				if($(this).val()==""){
// 					alert($(this).parent().prev().text()+"를 입력하세요");
// 					$(this).focus();
// 					bool = false;
// 					return false;
// 				}
// 			});
// 			return bool;
// 		});
	});
</script>
</head>
<body>
<jsp:useBean id="util" class="com.utils.Util" />
<h1>게시글 수정하기</h1>
<form action="BoardController.do">
<input type="hidden" name="command" value="updateboard" />
<input type="hidden" name="seq" value="${dto.seq}" />
<table border="1">
	<tr>
		<th>작성자</th>
		<td>
			<jsp:setProperty property="emailNick" name="util" value="${dto.email}" />
			<jsp:getProperty property="emailNick" name="util" />
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="${dto.title}" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content">${dto.content}</textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정완료" />
			<input type="button" onclick="location.href='BoardController.do?command=muldel&chk=${dto.seq}'" value="삭제" />
			<input type="button" onclick="location.href='BoardController.do?command=boarddetail&seq=${dto.seq}'" value="취소" />
			<input type="button" onclick="location.href='BoardController.do?command=boardlist'" value="목록" />
		</td>
	</tr>
</table>
</form>
</body>
</html>