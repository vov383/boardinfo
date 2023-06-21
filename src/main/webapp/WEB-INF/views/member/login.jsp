<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<%@ include file="../include/js/header.jsp"%>
<script type="text/javascript">

$(function(){
	$("#btnLogin").click(function(){
		var userid=$("#userid").val();
		var passwd=$("#passwd").val();
		if(userid==""){
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}
		if(passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		$("#passwd").keyup(function(event){
		      if(window.event.keyCode === 13){
				$("#btnLogin").click();
			}
		});
		
		document.form1.action="${path}/member/login_check.do";
		document.form1.submit();
	});
});


$(document).ready(function(){
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $("#userid").val(key); 
     
    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    if($("#userid").val() != ""){ 
        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#userid").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#userid").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#userid").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});

// 쿠키 저장하기 
// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value)
			+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제
function deleteCookie(cookieName) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires="
			+ expireDate.toGMTString();
}
 
// 쿠키 가져오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cookieData.length;
            console.log("end위치  : " + end);
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}

function login_check() {
    if (window.event.keyCode === 13) {
      $("#btnLogin").click();
    }
  }
  

</script>
</head>
<body>
	<div class="container">
		<h2>로그인</h2>
		<form method="post" name="form1" id="form1">
			<div class="form-group">
				<label for="userid">ID: </label> <input type="text"
					class="form-control" id="userid" placeholder="아이디를 입력하세요."
					name="userid">
			</div>
			<div class="form-group">
				<label for="passwd">Password : </label> <input type="password"
					class="form-control" id="passwd" placeholder="비밀번호를 입력하세요."
					name="passwd" onkeyup="login_check()">
			</div>
			<div class="form-check">
				<input type="checkbox" class="form-check-input" id=checkId>
				<label class="form-check-label" for="checkId">ID 저장</label>
			</div>
			<button type="button" class="btn btn-primary" name="btnLogin"
				id="btnLogin">로그인</button>
			<c:if test="${param.message == 'nologin' }">
				<div style="color: red;">로그인 하신 후 사용하세요.</div>
			</c:if>
			<c:if test="${message == 'error' }">
				<div style="color: red;">아이디 또는 비밀번호가 일치하지 않습니다.</div>
			</c:if>
			<c:if test="${message == 'del' }">
				<div style="color: red;">회원 탈퇴된 아이디입니다.</div>
			</c:if>
		</form>
		<div class="dropdown-divider"></div>
		<a class="dropdown-item" href="${path}/">메인으로</a> 
		<a class="dropdown-item" href="${path}/member/member_join.do">회원가입</a> 
		<a class="dropdown-item" href="${path}/member/findidmove.do">아이디 찾기</a>
		<a class="dropdown-item" href="${path}/member/findpwmove.do">비밀번호 찾기</a>
		</div>

</body>
</html>