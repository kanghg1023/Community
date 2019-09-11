/**
 * 
 */

var emailChk;
var pwChk;
var pw2Chk;
var nickChk;
var phoneChk;

//이메일 체크
function emailChkfun(){
	var aCount = $("#email");
	var email = aCount.val();
	var regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/g;
	aCount.next("div").remove();
	
	if(email==""){
		aCount.after("<div class='chkFalse'>"+"필수 정보입니다."+"</div>");
		emailChk = false;
	}else{
		if(regexEmail.test(email)) {
			$.ajax({
				url:"LoginController.do",
				data:{"command":"emailChk","email":email},
				method:"post",
				datatype:"text",
				async:false, // t=비동기 (되는대로 실행) / f=동기 (순서대로 실행)
				success:function(isS){
					if(eval(isS)){
						aCount.after("<div class='chkFalse'>"+"이미 사용중이거나 탈퇴한 이메일입니다."+"</div>");
						emailChk = false;
					}else {
						aCount.after("<div class='chkTrue'>"+"사용 가능한 이메일입니다."+"</div>");
						emailChk = true;
					}
				},
				error:function(){
					alert("서버통신실패!!");
				}
			});
		}else{
			aCount.after("<div class='chkFalse'>"+"이메일 형식이 아닙니다."+"</div>");
			emailChk = false;
		}
	}
}

//비밀번호 체크
function pwChkfun(){
	var aCount=$("#pw");
	var pw = aCount.val();
	aCount.next("div").remove();
	
	if(pw==""){
		aCount.after("<div class='chkFalse'>"+"필수 정보입니다."+"</div>");
		pwChk = false;
	}else{
		pwChk = true;
	}
}

//비밀번호확인 체크
function pw2Chkfun(){
	var aCount=$("#pw2");
	var pw = $("#pw").val();
	var pw2 = aCount.val();
	aCount.next("div").remove();
	
	if(pw2==""){
		aCount.after("<div class='chkFalse'>"+"필수 정보입니다."+"</div>");
		pw2Chk = false;
	}else{
		if(pw == pw2){
			aCount.after("<div class='chkTrue'>"+"비밀번호가 일치합니다."+"</div>");
			pw2Chk = true;
		}else {
			aCount.val("");
			aCount.after("<div class='chkFalse'>"+"비밀번호가 일치하지 않습니다."+"</div>");
			pw2Chk = false;
		}
	}
}

//닉네임 체크
function nickChkfun(){
	var aCount = $("#nick");
	var nick = aCount.val();
	
	aCount.next("div").remove();
	
	if(nick==""){
		aCount.after("<div class='chkFalse'>"+"필수 정보입니다."+"</div>");
		nickChk = false;
	}else{
		$.ajax({
			url:"LoginController.do",
			data:{"command":"nickChk","nick":nick},
			method:"post",
			datatype:"text",
			async:false, // t=비동기 (되는대로 실행) / f=동기 (순서대로 실행)
			success:function(isS){
				if(eval(isS)){
					aCount.after("<div class='chkFalse'>"+"이미 사용중인 별명입니다."+"</div>");
					nickChk = false;
				}else {
					aCount.after("<div class='chkTrue'>"+"사용 가능한 별명입니다."+"</div>");
					nickChk = true;
				}
			},
			error:function(){
				alert("서버통신실패!!");
			}
		});
	}
}

//전화번호 체크
function phoneChkfun(){
	var aCount = $("#phone");
	var phone = aCount.val();
	var regexPhone = /^[0-9]{3,11}$/g;
	
	aCount.next("div").remove();
	
	if(phone==""){
		aCount.after("<div class='chkFalse'>"+"필수 정보입니다."+"</div>");
		phoneChk = false;
	}else{
		if(regexPhone.test(phone)) {
			phoneChk = true;
		}else{
			aCount.val("");
			aCount.after("<div class='chkFalse'>"+"전화번호 형식이 아닙니다."+"</div>");
			phoneChk = false;
		}
	}
}

$(function(){
	$("#email").blur(function(){
		emailChkfun();
	});
	
	$("#pw").blur(function(){
		pwChkfun();
	});
	
	$("#pw2").blur(function(){
		pw2Chkfun();
	});
	
	$("#nick").blur(function(){
		nickChkfun();
	});
	
	$("#phone").blur(function(){
		phoneChkfun();
	});
	
	$("form").submit(function(){
		if(emailChk && pwChk && pw2Chk && nickChk && phoneChk){
			return true;
		}else{
			emailChkfun();
			pwChkfun();
			pw2Chkfun();
			nickChkfun();
			phoneChkfun();
			return false;
		}
	});
});