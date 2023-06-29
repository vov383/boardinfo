<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<title>회원 정보 수정</title>
<%@ include file="../include/js/header.jsp" %>
<%@include file="../include/top.jsp" %>
<style type="text/css">
 body{
	padding-top: 130px;
}
</style>
<script type="text/javascript">
var oldNickName;
$(document).ready(function () {
	oldNickName= $("#nickname").val();
});

$(function() {
	
    $("#btnNickCheck").click(function() {
      var nickname = $("#nickname").val();
      if (nickname == "") {
        alert("닉네임을 입력하세요.");
        $("#nickname").focus();
        return;
      }
      $.ajax({
        url: "${path}/member/check_nick.do",
        type: "POST",
        data: {
          nickname: nickname
        },
        success: function(result) {
          if (oldNickName == $("#nickname").val() ){
          	alert("현재 닉네임과 동일합니다.");
        	isNickChecked = true;	
          } else if (result == "duplicate") {
            alert("이미 사용 중인 닉네임입니다.");
            $("#nickname").val("");
            $("#nickname").focus();
            isNickChecked = false;
          } else if (result == "available") {
            alert("사용 가능한 닉네임입니다.");
            isNickChecked = true;
            document.form1.nickname.readOnly = true;
          }
        },
        error: function() {
          alert("서버와의 통신에 실패했습니다.");
        }
      });
    });
  });

function check() {
	//이름 체크
	var name = $("#name").val();
	if(name==""){
		alert("이름은 필수 입력입니다.");
		$("#name").focus();
		return;
	}	

	//이름 정규식
	var exp3 = /^[가-힣]+$/;
	if(!exp3.test(name)){
		alert("이름은 한글로 입력하세요.");
		$("#name").focus();
		return;
	}
	
	//이메일 체크
	var email = $("#email").val();
	if(email==""){
		alert("이메일은 필수 입력입니다.");
		$("#email").focus();
		return;
	}
	//이메일 정규식
	var exp4 = /^[a-z0-9]{2,15}@[a-z0-9]{2,9}\.[a-z]{2,}$/;
	if(!exp4.test(email)){
		alert("이메일 형식이 잘못되었습니다. ex)abc@abc.com");
		$("#email").focus();
		return;
	}
	//핸드폰번호 정규식
	var hp = $("#hp").val();
	var exp5 = /^[\d]{11,12}$/;
	if(!exp5.test(hp)){
		alert("11~12자리를 숫자로 입력해주세요.");
		$("#hp").focus();
		return;
	}
		document.form1.action="${path}/member/update.do";
		document.form1.submit();
			alert("수정되었습니다.");
	
}
$(function() {
	$("#btnDelete").click(function(){
		if(confirm('탈퇴하시겠습니까?')){
			document.form1.action="${path}/member/delete.do";
			document.form1.submit();
			alert("회원탈퇴가 완료되었습니다.");
		}
	});
});

</script>
</head>
<body>

<h2>회원 정보 수정</h2>
<form name="form1" method="post" enctype="multipart/form-data">
<table border="1" style="width: 100%">
<tr>
  <td>프로필</td>
  <td><input name="profile_img" id="profile" type="file"></td> 
</tr>
<tr>
  <td>이름</td>
  <td><input value="${dto.name}" id="name" name="name"></td>
 </tr>
 <tr>
  <td>아이디</td>
  <td><input value="${dto.userid}" id="userid" name="userid" readonly></td>
 </tr>
 <tr>
  <td>닉네임</td>
  <td>
    <input value="${dto.nickname}" id="nickname" name="nickname" >
  	<button type="button" id="btnNickCheck" >중복확인</button>
  </td>
  
 </tr>
 <tr>
  <td>이메일</td>
  <td><input value="${dto.email}" id="email" name="email" ></td>
 </tr>
  <tr>
  <td>핸드폰</td>
  <td><input value="${dto.hp}"  id="hp" name="hp" ></td>
 </tr>
 <tr>
  <td>회원가입일자</td>
  <td>
     <fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd"/>
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="button" value="수정하기" name="btnUpdate" id="btnUpdate" onclick="check()">
   <input type="button" value="탈퇴하기" name="btnDelete" id="btnDelete" >
     <a href="${path}/"><button type="button">메인으로</button></a>
  </td>
 </tr>



</table>
</form>


</body>
</html>