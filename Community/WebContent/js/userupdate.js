/**
 * 
 */

var nickChk;
var phoneChk;

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
	
	$("#nick").blur(function(){
		nickChkfun();
	});
	
	$("#phone").blur(function(){
		phoneChkfun();
	});
	
	$("form").submit(function(){
		if(nickChk && phoneChk){
			return true;
		}else{
			nickChkfun();
			phoneChkfun();
			return false;
		}
	});
});