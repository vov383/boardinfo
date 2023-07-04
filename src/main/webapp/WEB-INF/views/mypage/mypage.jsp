<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-20
    Time : 오후 7:09
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--부트스트랩--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <%@ include file="../include/js/header.jsp" %>
    <style>
        .card-body {
            height: 40vh; /* 개별적인 카드body에 일괄적으로 높이 적용 */
        }
        .card-img-top {
            /*object-fit은 이미지 크기가 줄면 바깥부터 잘려서 표현됨*/
            /*object-fit: cover;*/
            height: 200px; /* 썸네일 이미지에 일괄적인 높이 적용 */
            width: 80%; /* 섬네일 이미지 컨테이너의 너비 100% 적용 */
        }
    </style>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div id="contentsHeader">
        <h2>마이 페이지</h2>
    </div>
    <div id="contentsLocation">
        홈&gt 마이페이지
    </div>
    <main class="container text-center">
        <%--마이페이지 컨텐츠--%>
        <div class="myPage-contents-wrapper">
            <%--마이페이지 내부 navbar--%>
            <div class="myPage-contents-top">
                <%--부트스트랩 navbar--%>
                <nav class="navbar navbar-expand-md bg-light">
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                                aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"><i class="fa-regular fa-square-minus"></i></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNavDropdown">
                            <ul class="navbar-nav">

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                       aria-expanded="false">
                                        내 작성글
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="post-link nav-link" href="#">게임</a></li>
                                        <li><a class="post-link nav-link" href="#">리뷰</a></li>
                                        <li><a class="post-link nav-link" href="#">모임</a></li>
                                        <li><a class="post-link nav-link" href="#">중고거래</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">내 댓글</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">내가 좋아요 누른 항목</a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <%--마이페이지의 컨텐츠--%>
        <div class="myPage-contents-wrapper">
            <div class="myPage-contents">
                <div class="myPage-subtitle">
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
                            <a class="post-category nav-link active" aria-current="page" href="#" onclick="getPostList()">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" aria-current="page" href="#" onclick="listTap('game', this)">게임등록</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" href="#" onclick="listTap('game_rating', this)">게임평가</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" href="#" onclick="listTap('review', this)">커뮤니티</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" href="#" onclick="listTap('gathering', this)">오프모임</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" onclick="listTap('trade', this)">중고장터</a>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="myPage-contents-left">
                <%--ajax로 받아온 데이터를 출력할 영역--%>
<%--                <%@ include file="loadAllPost.jsp" %>--%>
                <%--게시판 별로 리스트를 여기에 출력--%>
                <div class="postListWrapper" id="postListWrapper"></div>
                <div class="tabbedListWrapper" id="tabbedListWrapper"></div>
            </div>

            <div class="myPage-contents-right">
                <%--유저 정보 부트스트랩 카드--%>
                <div class="userInfo">
                    <input type="hidden" id="userid" name="userid" value="${map.myDto.userid}">
                    <div class="card" style="width: 18rem;">
                        <img src="${path}/resources/uploaded_image/${map.myDto.profile}" class="card-img-top"
                             alt="유저 프로필">
                        <div class="card-body">
                            <h5 class="card-title">${map.myDto.nickname}(${map.myDto.userid})</h5>
                            <p class="card-text">가입 일자 <span>${map.myDto.join_date}</span>일</p>
                        </div>
                        <%--작성 글 정보 부트스트랩 리스트 그룹으로 표현--%>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <p class="card-text" id="">작성한 글<span id="totCount">${map.myDto.totCount}</span>개</p>
                            </li>
                            <li class="list-group-item">
                                <p class="card-text">작성 댓글
                                    <input type="hidden" name="gCount">
                                    <span id="totReCount">${map.myDto.reTotCount}</span>개</p>
                            </li>
                            <li class="list-group-item">
                                <p class="card-text">좋아요 누른 글<span id="totLikeCount">${map.myDto.likeTotCount}</span>개</p>
                            </li>
                        </ul>
                        <div class="card-body">
                        </div>
                    </div>
                    <div class="userImg"></div>
                    <div class="userNickname"></div>
                    <div class="user-post-count"></div>
                    <div class="user-reply-count"></div>
                    <div class="user-info-btn">
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary" type="button">내 정보 보기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </main>
</div>
<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
<script>
    $(function () {

        /*모든 게시판의 리스트 get 요청하고 출력*/
        getPostList();

        // /*post-link 클릭하면 postList 가져오는 jquery*/
        // $(".post-link").on("click", function () {
        // getPostList();
        // });
        // $(".post-category").on("click", function () {
        // getPostCategoryList();
        // });

    });

    /*ajax를 통해 controller에서 받아온 결과를 loadAllPost.jsp에 뿌려주고  jstl로 받음
    * loadAllPost.jsp의 <div id=listAjax></div> 영역을 현재 페이지의 <div id=tab></div>에 전달*/
    function getPostList() {
        var userid = $("#userid").val();
        const postList = document.getElementsByClassName("postListWrapper");

        $.ajax({
            type: "get",
            url: "${path}/mypage/getPostList.do",
            data: {
                "userid": userid
            },
            /*data는 map에 들어있는 grList, rvList, gaList, tbList*/
            success: function (data) {

                // 클릭한 탭 이외의 클래스 nav-item nav-link 에서 active를 지운다.
                $('.nav-item .nav-link').removeClass("active");

                // #listAll 에 active 클래스를 더한다.
                $("#listAll").addClass("active");

                var html = jQuery('<div>').html(data);
                var contents = html.find("div#allPost").html();
                /*post가 성공적으로 로드되면, 출력할 div에 출력한다.*/
                $("#tabbedListWrapper").html(contents);
            },
            error: function(jqXHR, textStatus, errorThrown){
                alert("Error Ajax load");
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            }
        });/*ajax 끝*/
    }/*getPostList() 끝*/

    /*게시판의 카테고리 별로 가져오는 함수*/
    function listTap(str, element) {
        /*jquery로 onclick에 매개변수로 this를 보내면 element를 jquery로 할당*/
        var thisTab = $(element);

        var tabLists = ["game", "giMore", "game_rating", "grMore",  "review", "rvMore", "gathering", "gaMore", "trade", "trMore", "loardAll"];
        var userid = document.getElementById("userid").value;
        let url= "";
        switch (str){
            case tabLists[0]:
                url = "${path}/mypage/getGiList";
                break;
            case tabLists[1]:
                url = "${path}/mypage/getGiMore";
                break;
            case tabLists[2]:
                url = "${path}/mypage/getGrList";
                break;
            case tabLists[3]:
                url = "${path}/mypage/getGrMore";
                break;
            case tabLists[4]:
                url = "${path}/mypage/getRvList";
                break;
            case tabLists[5]:
                url = "${path}/mypage/getRvMore";
                break;
            case tabLists[6]:
                url = "${path}/mypage/getGaList";
                break;
            case tabLists[7]:
                url = "${path}/mypage/getGaMore";
                break;
            case tabLists[8]:
                url = "${path}/mypage/getTrList";
                break;
            case tabLists[9]:
                url = "${path}/mypage/getTrMore";
                break;
            case tabLists[10]:
                url = "${path}/mypage/getPostList.do";
                break;
        }
        /*위에 설정한 url에 맞는 ajax 요청 보냄*/
        $.ajax({
            type : "get",
            url : url,
            data : {
                "userid" : userid,
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