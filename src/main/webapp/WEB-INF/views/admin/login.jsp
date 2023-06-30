<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-19
    Time : 오후 1:26
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 로그인</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous">


    <style>
        #container{
            align-items: center;
            max-width: 600px;
            margin: auto auto;
        }

        #imgArea{
            display: flex;
            justify-content: center;
        }

        #container img{
            cursor: pointer;
            margin-bottom: 30px;
        }


        #container form[name='form1'] {
            text-align: left;
        }

    </style>


    <%--부트스트랩--%>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <%--헤더--%>
    <%@ include file="../include/js/header.jsp"%>
    <script type="text/javascript">
        $(function(){
            $("#btnLogin").click(function(){
                var admin_id=$("#admin_id").val();
                var passwd=$("#passwd").val();
                if(admin_id==""){
                    alert("아이디를 입력하세요.");
                    $("#admin_id").focus();
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

                document.form1.action="${path}/admin/login_check.do";
                document.form1.submit();
            });
        });

        function login_check() {
            if (window.event.keyCode === 13) {
                $("#btnLogin").click();
            }
        }


    </script>
</head>
<body>

<%@include file="../include/top.jsp" %>

<div id="contents">

    <div id="contentsHeader">
        <h2>관리자 로그인</h2>
    </div>
    <div id="contentsLocation">
        홈 &gt 관리자 로그인
    </div>


    <div id="contentsMain">
        <div id="container">
            <a id="imgArea" href="${path}/" title="보드인포">
                <img src="${path}/images/logo.png" width="400px">
            </a>
            <form method="post" name="form1" id="form1">
                <div class="form-group">
                    <label for="admin_id">ID: </label> <input type="text"
                                                            class="form-control" id="admin_id" placeholder="아이디를 입력하세요."
                                                            name="admin_id">
                </div>
                <div class="form-group">
                    <label for="passwd">Password : </label> <input type="password"
                                                                   class="form-control" id="passwd" placeholder="비밀번호를 입력하세요."
                                                                   name="passwd" onkeyup="login_check()">
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="pwdCheck">
                    <label class="form-check-label" for="pwdCheck">ID 저장</label>
                </div>
                <button type="button" class="btn btn-primary" name="btnLogin"
                        id="btnLogin">관리자 로그인</button>
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
            <a class="dropdown-item" href="${path}/admin/admin_join.do">관리자 id 등록</a>
        </div>
    </div>
</div>

</body>
</html>