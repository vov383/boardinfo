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
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div class="contentUpper">
        <h2>마이 페이지</h2>
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
                <div class="postListWrapper" id="postListWrapper">
                    <div class="grlDiv"></div>
                    <div class="rvlDiv"></div>
                    <div class="galDiv"></div>
                    <div class="tblDiv" id="tblDiv"></div>
                    <%--여기에 tr을 append--%>
                    <table class="table">
                    </table>
                </div>
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
                            <a href="#" class="card-link">Card link</a>
                            <a href="#" class="card-link">Another link</a>
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
        <%--/*게시글 수 , 댓글 수 */--%>
        <%--let gCount = '${map.myDto.gCount}';--%>
        <%--let grCount = '${map.myDto.grCount}';--%>
        <%--let rvCount = '${map.myDto.grCount}';--%>
        <%--let gaCount = '${map.myDto.grCount}';--%>
        <%--let tbCount = '${map.myDto.grCount}';--%>

        <%--/*총 게시물 수*/--%>
        <%--var totPost = gCount + grCount + rvCount + gaCount + tbCount;--%>

        /*모든 게시판의 리스트 get 요청하고 출력*/
        // getPostList();
        /*post-link 클릭하면 postList 가져오는 jquery*/
        // $(".post-link").on("click", function () {
        // getPostList();
        // });
        // $(".post-category").on("click", function () {
        // getPostCategoryList();
        // });

        /*모든 게시판의 리스트 가져오는 함수*/
        debugger
        getPostList();
        const userid = document.getElementById("userid").value;
        const postList = document.getElementsByClassName("postListWrapper");
    });


    function getPostList() {

        $.ajax({
            type: "get",
            url: "${path}/mypage/getPostList.do",
            data: {
                "userid": userid
            },
            /*data는 map에 들어있는 grList, rvList, gaList, tbList*/
            success: function (data, status, req) {

                if (data) {
                    console.log("data:" + data); //업로드된 파일 이름
                    console.log("status:" + status);//성공,실패 여부
                    console.log("req:" + req.status);//요청코드값

                    /*keyName으로 List를 담을 변수 생성 and 값 할당*/
                    createKeyVar(data);
                    debugger

                    var grList = window.grList;
                    var rvList = window.grList;
                    var gaList = window.grList;
                    var tbList = window.grList;
                }
                /*json은 .length로 값을 가져올 수 없다. Object.keys()는 객체를 파라메터로 받아 key가 되는 값을 뽑아주고 이를 배열에 담아서 리턴*/
                // if (grList != null && Object.keys(grList).length > 0) {
                //     /*게임 레이팅 테이블의 row를 출력할 함수*/
                //     createGameRatingList(data.grList);
                // }
                // if (Object.keys(rvList).length > 0) {
                //     createReviewList(data.rvList);
                // }
                // if (Object.keys(gaList).length > 0) {
                //     createGatheringList(data.gaList);
                // }
                // if (Object.keys(tbList).length > 0) {
                //     createTradeList()
                // }
            },
            error: function () {
                alert("ajax 실패");
            }
        });/*ajax 끝*/
    }/*getPostList() 끝*/

    /*게시판의 카테고리 별로 가져오는 함수*/
    function getPostCategoryList() {

    }

    /*game rating row 만드는 함수*/
    function createGameRatingList(dataList) {
        const grlDiv = document.querySelector('.grlDiv');

        for (const card of dataList) {
            const cardComponent = (card) => {
                return (
                    '<div class="card w-75">' +
                    '<div class="card-body">' +
                    '<h5 class="card-title">' + card.GAMETITLE + '</h5>' +
                    '<img src="' + card.BGG_THUMBNAIL + '" class="card-img-top" alt="Board Game Thumbnail">' +
                    '<p class="card-text">Rating: ' + card.rating + '<br>Weight: ' + card.weight + '<br>Rating Comment: ' + card.rating_comment + '<br>Like Count: ' + card.likeCount + '</p>' +
                    '<a href="#" class="btn btn-primary">Learn More</a>' +
                    '</div>' +
                    '</div>'
                );
            };

            const renderedCard = cardComponent(card);

            grlDiv.innerHTML += renderedCard;
        }
    }

    function createGrList() {
        var grRow = document.createElement('div');
        /* grRow에 id 부여 */
        grRow.id = "gr[i]";
        grRow.classList.add('grRow');
        grRow.dataset.userid = data.userid;

        /*gameRating에 게임 썸네일*/
        var bgg_thumbnail = document.createElement('img');
        bgg_thumbnail.classList.add('bgg_thumbnail');
        /*이미지 src 추가*/
        bgg_thumbnail.src = data.bgg_thumbnail;

        /* grRowTop -> title과 gameRating 별점*/
        var grRowTop = document.createElement('grRowTop');
        grRowTop.classList.add("grRowTop");

        var gametitle = document.createElement('div');
        gametitle.classList.add('gametitle');
        gametitle.textContent = data.gametitle;
        grRowTop.appendChild(gametitle);

        /* grRowMain작성일자, 작성자, 별점, 댓글 내용 */
        var grRowMain = document.createElement('div');
        /* 작성자 */
        var userid = document.createElement('div');
        userid.textContent = data.userid;
        /*별점*/
        var reviewStar = document.createElement('span');
        reviewStar.classList.add('reviewStar');
        var ratingSpan = document.createElement('span');
        ratingSpan.dataset.rating = data.rating;
        /*innerHTML로 js변수 넣기*/
        ratingSpan.innerHTML = '<i class="fa-regular fa-star">' + data.rating + '</i>';
        reviewStar.appendChild(ratingSpan);
        /*코멘트*/
        var rating_comment = document.createElement('div');
        rating_comment.textContent = data.rating_comment;
        /* element변수명.textContent를 쓰면 js변수 넣을 수 있음 */

        var grRowMainDiv = document.createElement('div');
        grRowMainDiv.classList.add('grRowMainDiv');

        /* 추천인원 */
        let bestSpan = document.createElement('span');
        let recommendSpan = document.createElement('span');
        let unrecommendSpan = document.createElement('span');

        /* 참가자 1~5명(이상)까지 반복*/
        var pArray = [1, 2, 3, 4, 5];
        for (var j = 1; j <= pArray.length; j++) {
            var participant = pArray[j];
            let str = "";
            /*1은 베스트, 2는 추천, 3은 비추천 4는 null임*/
            switch (participant) {
                case 1:
                    str = '베스트 ' + [j] + '인 이상 | ';
                    bestSpan.textContent = str;
                    break;
                case 2:
                    str = '추천 ' + [j] + '인 | ';
                    recommendSpan.textContent = str;
                    break;
                case 3:
                    str = '비추천 ' + [j] + '인';
                    unrecommendSpan.textContent = str;
                    break;
            }/*switch case 끝*/

        }/*for j 반복문 끝*/
        /* 베스트, 추천, 비추천 append*/
        grRowMainDiv.appendChild(bestSpan);
        grRowMainDiv.appendChild(recommendSpan);
        grRowMainDiv.appendChild(unrecommendSpan);

        /*gameRating 좋아요*/
        var likeItDiv = document.createElement('div');
        likeItDiv.classList.add('likeItDiv');

        var likeIcon = document.createElement('span');
        likeIcon.innerHTML = '<i class="fa-regular fa-heart"></i>';

        var likeCountSpan = document.createElement('span');
        likeCountSpan.classList.add('likeCount');
        likeCountSpan.textContent = data.likeCount;
        likeItDiv.appendChild(likeIcon);
        likeItDiv.appendChild(likeCountSpan);

        /*날짜*/
        var create_date = document.createElement('span');
        create_date.classList.add('create_date');
        create_date.textContent = data.create_date;

        /*dom 한 html element를 grRowMain에 append*/
        grRowMain.appendChild(bgg_thumbnail);
        grRowMain.appendChild(grRowTop);
        grRowMain.appendChild(reviewStar);
        grRowMain.appendChild(rating_comment);
        grRowMain.appendChild(grRowMainDiv);
        grRowMain.appendChild(likeItDiv);
        grRowMain.appendChild(create_date);
        grRowMain.appendChild(userid);
        /*grRowMain을 grRow에 append*/
        grRow.appendChild(grRowMain);

        /*grRow를 listGroup에 append*/
        let listGroupItem = document.createElement('a');
        listGroupItem.classList.add("list-group-item");
        listGroupItem.href = "#";
        listGroupItem.appendChild(grRow);
        listGroup.appendChild(listGroupItem);
    }

    // grlDiv.appendChild(listGroup);
    // }

    /* userid 로 리뷰 게시판 목록 get */
    function createReviewList(dataList) {
        const rvlDiv = document.querySelector('.rvlDiv');

        for (var i = 0; i < dataList.length; i++) {
            let listGroup = document.createElement('div');
            let listGroupItem = document.createElement('a');
            listGroup.className = 'list-group';
            listGroup.id = "rv_" + i;
            listGroupItem.classList.add('list-group-item');
            listGroupItem.href = "#";
            var data = dataList[i];

            /*rvList에서 row역할을 하는 div 생성*/
            var rvRow = document.createElement('div');
            rvRow.classList.add('rvRow');
            rvRow.dataset.userid = data.userid;
            /* 카테고리 */
            var cbadge = document.createElement('span');
            cbadge.classList.add('cbadge');
            cbadge.dataset.category = data.category;
            cbadge.textContent = data.category;

            /* row의 메인 -> 제목, 댓글 수 , 조회수, 좋아요 수 */
            var rvRowMain = document.createElement('div');
            rvRowMain.classList.add('rvRowMain');
            /* 제목 */
            var title = document.createElement('a');
            title.classList.add('title');
            title.dataset.title = data.title;
            title.textContent = data.title;
            /* 댓글 수 */
            var re_count = document.createElement('span');
            re_count.classList.add("re_count");
            re_count.innerHTML = '<i class="fa-regular fa-comment-dots"></i>';
            re_count.dataset.recnt = data.recnt;
            /* 조회수 */
            var views = document.createElement('span');
            views.classList.add('views');
            views.dataset.views = data.views;
            views.innerHTML = '<i class="fa-solid fa-eye"></i>' + data.views;
            /* 좋아요 수 */
            var good = document.createElement('span');
            good.classList.add('good');
            good.dataset.good = data.good;
            good.innerHTML = '<i class="fa-solid fa-heart" style="color: #c11045;"></i>' + data.good;

            rvRowMain.appendChild(title);
            rvRowMain.appendChild(re_count);
            rvRowMain.appendChild(views);
            rvRowMain.appendChild(good);

            /* 작성일자 */
            var create_date = document.createElement('span')
            create_date.dataset.create_date = data.create_date;
            create_date.textContent = data.create_date;

            /* 카테고리와 rvRowMain과 create_date를 rvRow에 append*/
            rvRow.appendChild(cbadge);
            rvRow.appendChild(rvRowMain);
            rvRow.appendChild(create_date);

            /*rvRow를 rvlDiv > listGroup에 append*/
            listGroupItem.appendChild(rvRow);
            listGroup.appendChild(listGroupItem);
            rvlDiv.appendChild(listGroup);
        }
    }

    /* userid로 모임 리스트(gaList) 생성 */
    function createGatheringList(dataList) {
        const galDiv = document.querySelector('.galDiv');

        for (var i = 0; i < dataList.length; i++) {
            let listGroup = document.createElement('div');
            listGroup.className = 'list-group';
            listGroup.id = "ga_" + i;
            var data = dataList[i];

            /*gaList에서 row역할을 하는 div 생성*/
            var gaRow = document.createElement('div');
            gaRow.classList.add('gaRow');
            gaRow.dataset.userid = data.userid;

            /* 상태 */
            var status = document.createElement('span');
            status.classList.add('status');
            status.dataset.status = data.status;
            status.textContent = data.status;

            /* row의 메인 -> 제목, 댓글 수, 조회수 */
            var gaRowMain = document.createElement('div');
            gaRowMain.classList.add('gaRowMain');
            /* 제목 */
            var title = document.createElement('a');
            title.classList.add('title');
            title.dataset.title = data.title;
            title.textContent = data.title;
            /* 댓글 수 */
            var re_count = document.createElement('span');
            re_count.classList.add("re_count");
            re_count.innerHTML = '<i class="fa-regular fa-comment-dots"></i>';
            re_count.dataset.recnt = data.recnt;
            /* 조회수 */
            var view_count = document.createElement('span');
            view_count.classList.add('view_count');
            view_count.dataset.view_count = data.view_count;
            view_count.innerHTML = '<i class="fa-solid fa-eye"></i>' + data.view_count;

            gaRowMain.appendChild(title);
            gaRowMain.appendChild(re_count);
            gaRowMain.appendChild(view_count);

            /* gaRowSub -> 모임날짜, 주소1, 2, 참가인원, 작성일자 */
            var gaRowSub = document.createElement('div');
            /*모임 날짜*/
            var gathering_date = document.createElement('div');
            athering_date.classList.add('gathering_date');
            gathering_date.dataset.gathering_date = data.gathering_date;
            /* 주소 1 */
            var address1 = document.createElement('div');
            address1.classList.add('address1');
            address1.dataset.address1 = data.address1;
            /* 주소 2 */
            var address2 = document.createElement('div');
            address2.classList.add('address2');
            address2.dataset.address2 = data.address2;
            /* 참가인원 */
            var attendee_count = document.createElement('div');
            attendee_count.classList.add('attendee_count');
            attendee_count.dataset.attendee_count = data.attendee_count;
            /* 작성일자 */
            var create_date = document.createElement('span');
            create_date.dataset.create_date = data.create_date;
            create_date.textContent = data.create_date;

            gaRowSub.appendChild(gathering_date);
            gaRowSub.appendChild(address1);
            gaRowSub.appendChild(address2);

            /* status와 gaRowMain과 create_date를 gaRow에 append*/
            gaRow.appendChild(status);
            gaRow.appendChild(gaRowMain);
            gaRow.appendChild(gaRowSub);

            /*gaRow를 rvlDiv > listGroup에 append*/
            let listGroupItem = document.createElement('a');
            listGroupItem.classList.add("list-group-item");
            listGroupItem.href = "#";
            listGroupItem.appendChild(gaRow);
            listGroup.appendChild(listGroupItem);
            galDiv.appendChild(listGroup);
        }
    }

    /*중고거래 목록 생성 함수*/

    /*컬럼 요소 생성 모듈*/
    function createColumnElement(text) {
        var column = document.createElement('div');
        column.textContent = text;
        return column;
    }

    /*썸네일 이미지 생성 묘듈*/
    function createThumbnailElement(src) {
        var thumbnail = document.createElement('img');
        thumbnail.src = "${path}/resources/uploaded_image" + src;
        thumbnail.width = '150px';
        thumbnail.classList.add('thumbnail');
        return thumbnail;
    }

    /*row 요소 생성 모듈*/
    function createRowElement(divName) {
        var row = document.createElement('div');
        /*개별 row에 클래스명 부여*/
        row.classList.add(divName + '_row');
        return row;
    }

    /*컬럼을 row에 넣는 모듈*/
    function appendColumnsToRow(row, item) {
        item.forEach(item => {
            var column = createColumnElement(item.text);
            row.appendChild(column);
        });
    }

    /*dataList는 ㅁㅁList 4종류 중 하나*/
    /* json타입의 dataList를 parameter로 받아서 dom으로 리스트를 만들어주는 함수 */
    function createList(dataList) {
        let divName = dataList.keyName.substring(0, 2);
        /*dataList가 들어갈 div에 클래스명 부여*/
        const listDiv = document.createElement('div');
        listDiv.classList.add("." + divName + "lDiv");

        /*item은 개별 컬럼*/
        dataList.forEach(function (item, index) {
            /*개별 row에 클래스명 부여 '.oo_row'*/
            var row = createRowElement(divName);

            var thead = document.createElement('thead');
            var headerRow = document.createElement('tr');
            /*키 배열*/
            var obj = item[key];

            /*키 배열로 반복*/
            obj.forEach(function (itemKey, index) {
                /*value가 null인 키는 스킵*/
                if (Object.values(itemKey).includes(null)) {
                    return;
                }
                var thead = document.createElement('')

            });

            var listItem = document.createElement('div');
            listItem.classList.add('list-group-item');
            ;


            /* 테이블에서 가져온 컬럼명으로 변수 선언 */

            var columnsData = [
                {text: item.category},
                {text: item.title},
                {text: item.price},
                {text: item.address1},
                {text: item.address2},
                {text: item.re_count},
                {text: item.like_count},
                {text: item.view_count},
                {text: item.create_date}
            ];

            var thumbnail = createThumbnailElement(item.first_img);
            row.appendChild(thumbnail);

            appendColumnsToRow(row, item);

            row.appendChild(row);
            console.log(row);

            listDiv.appendChild(row);
        });//반복문 end

    }

    function createKeyVar(data) {
        /*변수명을 동적으로 할당하기 위해 model로 받은 data의 키값을 iterate*/
        Object.keys(data).forEach(function (key) {
            /* 변수명을 생성*/
            var variableName = key;

            /*동적으로 생성된 변수에 키값에 해당하는 value를 할당*/
            window[variableName] = data[key];
        });

        debugger
    }

    function printJsonData(jsonData, targetDivId) {

        // Find the target <div> to insert the container
        var targetDiv = document.getElementById(targetDivId);

        // Create a container <div>
        var containerDiv = document.createElement("div");

        // Loop through the data object
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                // Create a <div> for each key-value pair
                var div = document.createElement("div");

                // Set class name based on the key name
                div.className = key;

                // Insert the value into the <div>
                div.innerHTML = data[key];

                // Append the <div> to the container
                containerDiv.appendChild(div);
            }
        }

        // Append the container <div> to the target <div>
        targetDiv.appendChild(containerDiv);

    }


</script>
</body>
</html>