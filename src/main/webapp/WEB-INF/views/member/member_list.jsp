<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/js/header.jsp" %>
</head>
<body>
<table border="1" style="width: 100%">
  <tr>
    <th>프로필</th>
    <th>이름</th>
    <th>아이디</th>
    <th>비번</th>
    <th>닉네임</th>
    <th>이메일</th>
    <th>핸드폰</th>
    <th>가입일자</th>
  </tr>
 <c:forEach var="row" items="${list}">
  <tr>
    <td><img src="${path}/images/${row.profile}" width="100px" height="100px"></td>
    <td>${row.name}</td>
    <td>${row.userid}</td>
    <td>${row.passwd}</td>
    <td>${row.nickname}</td>
    <td>${row.email}</td>
    <td>${row.hp}</td>
    <td><fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
  </tr>
 </c:forEach>
  
</table>


</body>
</html>