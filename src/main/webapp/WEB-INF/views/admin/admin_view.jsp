<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-20
    Time : 오전 10:44
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 마이페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--부트스트랩--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <title>관리자 상세 정보</title>
    <%@ include file="../include/js/header.jsp" %>

    <style type="text/css">
        body {
            padding-top: 130px;
        }
    </style>
    <script type="text/javascript">

        $(function () {
            $("#btnEdit").on("click", function () {
                document.form1.action = "${path}/admin/pass_check.do";
                document.form1.submit();
            });
        });
    </script>
</head>

<body>

<h2>회원 상세 정보</h2>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <main>
        <form name="form1" method="post">
            <table border="1" style="width: 100%">
                <tr>
                    <td>프로필</td>
                    <td><img src="${path}/images/${dto.profile}" width="100px" height="100px"></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><input value="${dto.name}" name="name" readonly></td>
                </tr>
                <tr>
                    <td>아이디</td>
                    <td><input value="${dto.admin_id}" name="admin_id" readonly></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="passwd"></td>
                </tr>
                <tr>
                    <td>닉네임</td>
                    <td><input value="${dto.nickname}" name="nickname" readonly></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input value="${dto.email}" name="email" readonly></td>
                </tr>
                <tr>
                    <td>핸드폰</td>
                    <td><input value="${dto.hp}" name="hp" readonly></td>
                </tr>
                <tr>
                    <td>회원가입일자</td>
                    <td>
                        <fmt:formatDate value="${dto.create_date}" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="button" value="내 정보 수정" name="btnEdit" id="btnEdit">
                        <a href="${path}/">
                            <button type="button">메인으로</button>
                        </a>
                        <div style="color: red;">${message}</div>
                    </td>
                </tr>
            </table>
        </form>
    </main>
</div>
<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
<script src="../include/js/jquery-3.6.3.min.js"></script>
</body>
</html>