<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	//사용한 이벤트 : onload,onsubmit
	//submit 이벤트를 취소하는 방법 : return false
	//DOM의 개념 : 탐색하는 메서드 - getElementsByTagName(), querySelectorAll() ...
	//input 태그의 입력값을 구하는 방법 : input.value
	window.onload = function(){
		var form = document.getElementsByTagName("form")[0];
		form.onsubmit = function(){
			var inputs = document.querySelectorAll("table input");
			if(inputs[2].value != inputs[3].value){
				alert("비밀번호를 확인하시오");
				inputs[2].value = "";
				inputs[3].value = "";
				inputs[2].focus();
				return false;
			}else{
				for (var i=0;i<inputs.length;i++) {
					if(inputs[i].value == ""){
						var tagEleTxt = inputs[i].parentNode.previousElementSibling.textContent;
						//							부모태그		앞에있는개체				내용
						alert(tagEleTxt+"을(를) 입력하시오");
						inputs[i].focus();
						return false;
					}
				}
			}
		}
	}
	
	function emailChk(){
		var email = document.getElementsByName("email")[0].value;
		//open("url","title","창의 속성설정")
		window.open("LoginController.do?command=emailChk&email="+email,"","width=300px,height=300px");
	}
</script>
</head>
<body>
<h1>회원가입</h1>
<form action="LoginController.do" method="post">
	<input type="hidden" name="command" value="insertuser" />
	<table border="1">
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="email" class="n" />
				<input type="button" value="중복체크" onclick="emailChk()" />
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" /></td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" name="password2" /></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nick" /></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="tel" name="phone" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="가입완료" />
			</td>
		</tr>
	</table>
</form>

</body>
</html>