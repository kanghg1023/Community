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
			var bool = true;
			var input = $(this).find("td").children().filter("[name]");
			input.each(function(i){
				if($(this).val()==""){
					alert($(this).parent().prev().text()+"를 입력하세요");
					$(this).focus();
					bool = false;
					return false;
				}
			});
			return bool;
		});
	});
</script>
</head>
<body>
<h1>게시글 추가하기</h1>
<form action="BoardController.do" method="post">
<input type="hidden" name="command" value="insertboard" />
<table border="1">
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" class="inputval" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" class="inputval" ></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="완료" />
			<input type="button" value="목록" onclick="location.href='BoardController.do?command=boardlist'" />
		</td>
	</tr>
</table>
</form>
</body>
</html>