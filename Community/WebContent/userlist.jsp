<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%
	List<UserDto> list = (List<UserDto>)request.getAttribute("list");
%>
<h1>회원리스트조회</h1>
<table border="1">
	<tr>
		<th>이메일</th>
		<th>닉네임</th>
		<th>등급</th>
	</tr>
	<%
		for(UserDto dto:list){
			%>
			<tr>
				<td><%=dto.getEmail()%></td>
				<td><%=dto.getNick()%></td>
				<%
					if(dto.getRole().equals("ADMIN")){
						%>
						<td>관리자</td>
						<%
					}else{
						%>
						<td>
							<select name="role" id="<%=dto.getEmail()%>">
								<option value="MANAGER" <%=dto.getRole().equals("MANAGER") ? "selected" : ""%>>정회원</option>
								<option value="USER" <%=dto.getRole().equals("USER") ? "selected" : ""%>>일반회원</option>
							</select>
							<button onclick="authchange('<%=dto.getEmail()%>',this)">변경</button>
						</td>
						<%
					}
				%>
			</tr>
			<%
		}
	%>
</table>
<script type="text/javascript">
	function authchange(email,btn){
// 		var role = $("#"+email);
// 		alert(role);
// 		alert($(btn).prev("select").prop("tagName"));
		var role=$(btn).prev("select").val();
// 		alert(role);
		location.href="LoginController.do?command=authchange&email="+email+"&role="+role;
	}
</script>
</body>
</html>