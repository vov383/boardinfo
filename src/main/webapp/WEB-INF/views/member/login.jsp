<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<%@ include file="../include/js/header.jsp" %>
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
		document.form1.action="${path}/member/login_check.do";
		document.form1.submit();
	});
});

</script>
</head>
<body>
<div class="container">
 <h2>로그인</h2>
 <form method="post" name="form1" id="form1" >
  <div class="form-group">
   <label for="userid">ID: </label>
   <input type="text" class="form-control" id="userid" 
   placeholder="아이디를 입력하세요." name="userid">
  </div>
  <div class="form-group">
   <label for="pwd">Password : </label>
   <input type="password" class="form-control" id="passwd" 
   placeholder="비밀번호를 입력하세요." name="passwd">
  </div>
  <div class="form-check">
   <input type="checkbox" class="form-check-input" id="pwdCheck">
    <label class="form-check-label" for="pwdCheck">ID 저장</label>
  </div>
  <button type="button" class="btn btn-primary" name="btnLogin" id="btnLogin" >로그인</button>
  <c:if test="${param.message == 'nologin' }">
				<div style="color:red;">
					로그인 하신 후 사용하세요.
				</div>				
			</c:if>
			<c:if test="${message == 'error' }">
				<div style="color:red;">
					아이디 또는 비밀번호가 일치하지 않습니다.
				</div>
			</c:if>
			<c:if test="${message == 'logout' }">
				<div style="color:blue;">
					로그아웃 처리되었습니다.
				</div>
			</c:if>
 </form>
 <div class="dropdown-divider"></div>
  <a class="dropdown-item" href="#">메인으로</a>
  <a class="dropdown-item" href="${path}/member/member_join.do">회원가입</a>
  <a class="dropdown-item" href="#">아이디 찾기</a>
  <a class="dropdown-item" href="#">비밀번호 찾기</a>
 
</div>

</body>
</html>