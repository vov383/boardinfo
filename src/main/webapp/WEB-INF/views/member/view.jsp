<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 가입</title>
<%@ include file="../include/js/header.jsp" %>
<%@include file="../include/top.jsp" %>
<style type="text/css">
 body{
	padding-top: 130px;
}
</style>
<script type="text/javascript">

$(function() {
	$("#btnEdit").click(function() {
		document.form1.action="${path}/member/pass_check.do";
		document.form1.submit();
	});	
});
</script>
</head>
<body>

<h2>회원정보 수정</h2>
<form name="form1" method="post">
<table border="1" style="width: 100%">
<tr>
  <td>프로필</td>
  <td><input value="${dto.profile}" name="profile"></td>
 </tr>
<tr>
  <td>이름</td>
  <td><input value="${dto.name}" name="name" readonly></td>
 </tr>
 <tr>
  <td>아이디</td>
  <td><input value="${dto.userid}" name="userid" readonly></td>
 </tr>
 <tr>
  <td>비밀번호</td>
  <td><input type="password" name="passwd"></td>
 </tr>
 <tr>
  <td>닉네임</td>
  <td>${dto.nickname}</td>
 </tr>
 <tr>
  <td>이메일</td>
  <td>${dto.email}</td>
 </tr>
  <tr>
  <td>핸드폰</td>
  <td>${dto.hp}</td>
 </tr>
 <tr>
  <td>회원가입일자</td>
  <td>
   <c:if test="${dto.join_date != null}">
    <fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd"/>
   </c:if>
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="button" value="수정하기" name="btnEdit" id="btnEdit" >
   <a href="${path}/"><button>메인으로</button></a>
   <div style="color: red;">${message}</div>
  </td>
 </tr>
</table>
</form>


</body>
</html>