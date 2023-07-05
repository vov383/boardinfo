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
    <style>
        .navbar a {
            /*color: #ffffff;*/
        }
        .navbar-nav .nav-link {
            color: #000000;
        }
        ul.show {
            background-color: #F9841A;
        }
    </style>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div class="contentsHeader">
        <h2>관리자 홈</h2>
        <div id="contentsLocation">
            홈 &gt 관리자 페이지
        </div>
        <main class="container text-center">
            <%--관리자 페이지 컨텐츠--%>
            <div class="admin-contents-wrapper">
                <%--관리자 내부 navbar--%>
                <div class="admin-contents-top">
                    <%--부트스트랩 navbar--%>
                    <nav class="navbar navbar-expand-md" style="background-color: #F9841A;">
                        <div class="container-fluid">
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                                    aria-expanded="false"
                                    aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"><i class="fa-regular fa-square-minus"></i></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                                <ul class="navbar-nav" >
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" role="button"
                                           data-bs-toggle="dropdown"
                                           aria-expanded="false">
                                            전체 글 목록
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="post-link nav-link" href="#"
                                                   onclick="listTab('game_rating', this, 1)">게임평가</a></li>
                                            <li><a class="post-link nav-link" href="#"
                                                   onclick="listTab('game', this, 1)">게임 정보</a></li>
                                            <li><a class="post-link nav-link" href="#"
                                                   onclick="listTab('review', this, 1)">자유게시판</a></li>
                                            <li><a class="post-link nav-link" href="#"
                                                   onclick="listTab('gathering', this, 1)">오프모임</a></li>
                                            <li><a class="post-link nav-link" href="#"
                                                   onclick="listTab('trade', this, 1)">중고거래</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${path}/admin/confirmList/insert">게임등록 대기목록</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#" onclick="listAdminTab('reply', this, 1)">전체 댓글 목록</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${path}/admin/member_list" onclick="listAdminTab('like', this, 1)">전체 회원 목록</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${path}/admin/admin_list.do" onclick="listAdminTab('like', this, 1)">전체 관리자 목록</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <%--마이페이지의 컨텐츠--%>
            <div class="adminPage-contents-wrapper">
                <div class="adminPage-contents">
                    <div class="adminPage-subtitle">
                        <div>
                            <div class="flexdiv">
                                <div class="thumbnail"></div>
                                <div>
                                    <div class="flexdiv">
                                        <div class="title">
                                        </div>
                                        <div class="date"></div>
                                        <div class="subtitle"></div>
                                        <div class="flexdiv">
                                            <div class="button"></div>
                                            <div class="button"></div>
                                            <div class="button"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <ul class="nav nav-tabs">
                            <li class="nav-item" id="listAll">
                                <a class="post-category nav-link active" aria-current="page" href="#"
                                   onclick="getPostList()">전체</a>
                            </li>
                            <li class="nav-item">
                                <a class="post-category nav-link" aria-current="page" href="#"
                                   onclick="listTab('game', this, 1)">게임등록</a>
                            </li>
                            <li class="nav-item">
                                <a class="post-category nav-link" href="#" onclick="listTab('game_rating', this, 1)">게임평가</a>
                            </li>
                            <li class="nav-item">
                                <a class="post-category nav-link" href="#" onclick="listTab('review', this, 1)">커뮤니티</a>
                            </li>
                            <li class="nav-item">
                                <a class="post-category nav-link" href="#"
                                   onclick="listTab('gathering', this, 1)">오프모임</a>
                            </li>
                            <li class="nav-item">
                                <a class="post-category nav-link" onclick="listTab('trade', this, 1)">중고장터</a>
                            </li>
                        </ul>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-9">
                        <div class="adminPage-contents-left">
                            <%--ajax로 받아온 데이터를 출력할 영역--%>
                            <%--                        <%@ include file="loadAllPost.jsp" %>--%>
                            <%--게시판 별로 리스트를 여기에 출력--%>
                            <div class="postListWrapper" id="postListWrapper"></div>
                            <div class="tabbedListWrapper" id="tabbedListWrapper"></div>

                        </div>

                    </div>


                </div>
            </div>


        </main>
        <nav>
            <ul>
                <li><a href="${path}/admin/admin_list.do">관리자 목록</a></li>
                <li><a href="${path}/admin/member_list">전체 회원 목록</a></li>
                <li><a href="${path}/admin/userPostList">전체 글 목록</a></li>
                <li><a href="${path}/admin/confirmList/insert">게임등록 대기목록</a></li>
            </ul>
        </nav>
    </div>
</div>
<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>

<script>
    /*매개변수 개수가 3개인 listTap*/
    function listAdminTap(str, element, curPage) {
        /*jquery로 onclick에 매개변수로 this를 보내면 element를 jquery로 할당*/
        var thisTab = $(element);

        var tabLists = ["member", "admin", "reply", "gathering", "trade", 'reply', 'like'];
        var userid = document.getElementById("userid").value;
        let url= "";
        switch (str){
            case tabLists[0]:
                url = "${path}/admin/getAllMember";
                break;
            case tabLists[1]:
                url = "${path}/admin/getAllReply";
                break;
            case tabLists[2]:
                url = "${path}/admin/getAllAdmin";
                break;
        }
        /*위에 설정한 url에 맞는 ajax 요청 보냄*/
        $.ajax({
            type : "get",
            url : url,
            data : {
                "curPage" : curPage
            },
            success : function(response){
                $("#postListWrapper").remove();

                /*thisTab에 기존 클래스를 지우고 active 클래스를 활성화*/
                removeOtherActive(thisTab);

                var html = jQuery('<div>').html(response);
                var contents = html.find("div#tabbedPost").html();
                /*post가 성공적으로 로드되면, 출력할 div에 출력한다.*/
                $("#tabbedListWrapper").html(contents);

            }
        });

    }

    /*네브 탭에서 active를 옮기는 용도의 함수*/
    function removeOtherActive(element) {
        // 클릭한 탭 이외의 클래스 nav-item nav-link 에서 active를 지운다.
        $('.nav-item .nav-link').removeClass("active");

        // this 에 active 클래스를 더한다.
        $(element).addClass("active");

    }

</script>
</body>
</html>