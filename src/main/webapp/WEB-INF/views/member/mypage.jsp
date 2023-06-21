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
    <script src="../include/js/jquery-3.6.3.min.js"></script>

</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div class="contentUpper">
        <h2><span class="nickname">${map.dto.nickname}</span>님의 마이 페이지</h2>
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
                                <li class="nav-item">
                                    <a class="nav-link" href="${path}/member/collection">컬렉션</a>
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
                        <li class="nav-item">
                            <a class="post-category nav-link active" aria-current="page" href="#">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" aria-current="page" href="#">게임</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" href="#">리뷰</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link" href="#">모임</a>
                        </li>
                        <li class="nav-item">
                            <a class="post-category nav-link">중고거래</a>
                        </li>
                    </ul>
                </div>
                <%--게시판 별로 리스트를 여기에 출력--%>
                <div class="postListWrapper">
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action active" aria-current="true">
                            The current link item
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">A second link item</a>
                        <a href="#" class="list-group-item list-group-item-action">A third link item</a>
                        <a href="#" class="list-group-item list-group-item-action">A fourth link item</a>
                        <a class="list-group-item list-group-item-action disabled">A disabled link item</a>
                    </div>
                </div>
            </div>
            <div class="myPage-contents-right">
                <%--유저 정보--%>
                <div class="userInfo">
                    <input type="hidden" id="userid" name="userid" value="${map.dto.userid}">
                    <div class="card" style="width: 18rem;">
                        <img src="${path}/resources/uploadedImage/${map.dto.profile}" class="card-img-top" alt="유저 프로필">
                        <div class="card-body">
                            <h5 class="card-title">${map.dto.nickname}(${map.dto.userid})</h5>
                            <p class="card-text">게시글 수</p>
                            <p class="card-text">댓글 수</p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">An item</li>
                            <li class="list-group-item">A second item</li>
                            <li class="list-group-item">A third item</li>
                        </ul>
                        <div class="card-body">
                            <a href="#" class="card-link">Card link</a>
                            <a href="#" class="card-link">Another link</a>
                        </div>
                    </div>
                    <div class="userImg">

                    </div>
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
        /*post-link 클릭하면 postList 가져오는 jquery*/
       $(".post-link").on("click", function(){
           getPostList();
       });
       $(".post-category").on("click", function () {
          getPostCategoryList();
       });
    });
    /*게시판별 리스트 가져오는 함수*/
    const userid = document.getElementById("userid").value;
    const postList = document.getElementsByClassName("postListWrapper");
    function getPostList(){
        $.ajax({
            type: "get",
            url: "${path}/mypage/getPostList.do",
            data: {
                "userid": userid
            },
            success: function (data,status,req) {
                if(data){
                    console.log("data:"+data); //업로드된 파일 이름
                    console.log("status:"+status);//성공,실패 여부
                    console.log("req:"+req.status);//요청코드값
                    let str="";

                    str = `<div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action active" aria-current="true">
                            The current link item
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">A second link item</a>
                        <a href="#" class="list-group-item list-group-item-action">A third link item</a>
                        <a href="#" class="list-group-item list-group-item-action">A fourth link item</a>
                        <a class="list-group-item list-group-item-action disabled">A disabled link item</a>
                    </div>`

                    /*postList를 일단 비우고*/
                    postList.innerHTML("");


                }
            }
            
        });
    }
    /*게시판의 카테고리 별로 가져오는 함수*/
    function getPostCategoryList(){

    }
</script>
</body>
</html>