<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-20
    Time : 오후 2:10
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BOARDINFO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--부트스트랩--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <%@ include file="../include/js/header.jsp" %>
    <script src="../include/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <main>
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
                    <td><a href="${path}/admin/UserPostList?userid=${row.userid}">${row.nickname}</a></td>
                    <td>${row.email}</td>
                    <td>${row.hp}</td>
                    <td><fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
        </table>
    </main>
</div>
<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>