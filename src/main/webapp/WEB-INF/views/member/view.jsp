<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 가입</title>
<%@ include file="../include/js/header.jsp" %>
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

<h2>회원정보 수정</h2>
<form name="form1" method="post">
<table border="1" style="width: 100%">
 <tr>
  <td>아이디</td>
  <td><input name="userid" value="${dto.userid}" readonly> </td>
 </tr>
 <tr>
  <td>비밀번호</td>
  <td><input type="password" name="passwd"> </td>
 </tr>
 <tr>
  <td>이름</td>
  <td><input name="name" value="${dto.name}"> </td>
 </tr>
 <tr>
  <td>이메일</td>
  <td><input name="email" value="${dto.email}"> </td>
 </tr>
 <tr>
  <td>우편번호</td>
  <td><input name="zipcode" id="zipcode" value="${dto.zipcode}" readonly>
   <input type="text" onclick="daumZipCode()" value="우편번호 찾기">
  </td>
 </tr>
 <tr>
  <td>도로명주소</td>
  <td><input name="address1" id="address1" value="${dto.address1}"> </td>
 </tr>
 <tr>
  <td>상세주소</td>
  <td><input name="address2" id="address2" value="${dto.address2}"> </td>
 </tr>
 <tr>
  <td>회원가입일자</td>
  <td>
   <c:if test="${join_date != null}">
    <fmt:formatDate value="${join_date}" pattern="yyyy-MM-dd HH:mm:ss"/>
   </c:if>
  </td>
 </tr>
 <tr>
  <td colspan="2" align="center">
   <input type="button" value="수정" id="btnUpdate">
   <input type="button" value="삭제" id="btnDelete">
   <div style="color: red;">${message}</div>
  </td>
 </tr>
</table>
</form>


</body>
</html>