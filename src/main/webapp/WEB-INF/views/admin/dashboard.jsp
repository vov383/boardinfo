<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-20
    Time : 오후 1:41
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 홈</title>
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
        <div class="contentUpper">
            <h2>관리자 홈</h2>
            <nav>
                <ul>
                    <li><a href="${path}/admin/admin_list.do">관리자 목록</a></li>
                    <li><a href="${path}/admin/member_list">전체 회원 목록</a></li>
                    <li><a href="${path}/admin/userPostList">전체 글 목록</a></li>
                    <li><a href="#"></a></li>
                </ul>
            </nav>
        </div>
    </main>
</div>
<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>