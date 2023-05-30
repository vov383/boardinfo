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
$(function() {
	$("#btnUpdate").click(function(){
		document.form1.action="${path}/member/update.do";
		document.form1.submit();
	});
	$("#btnDelete").click(function(){
		if(confirm('삭제하시겠습니까?')){
			document.form1.action="${path}/member/delete.do";
			document.form1.submit();
		}
	});
});

</script>
</head>
<body>

<h2>회원 정보 수정</h2>
<form name="form1" method="post">
<table border="1" style="width: 100%">
<tr>
  <td>프로필</td>
  <td><input value="${dto.profile}" name="profile"></td> 
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
  <td>비밀번호</td>
  <td><input type="password" id="passwd" name="passwd"></td>
 </tr>
 <tr>
  <td>닉네임</td>
  <td><input value="${dto.nickname}" id="nickname" name="nickname" ></td>
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
   <input type="button" value="수정하기" name="btnUpdate" id="btnUpdate" >
   <input type="button" value="탈퇴하기" name="btnDelete" id="btnDelete" >
     <a href="${path}/"><button type="button">메인으로</button></a>
  </td>
 </tr>



</table>
</form>


</body>
</html>