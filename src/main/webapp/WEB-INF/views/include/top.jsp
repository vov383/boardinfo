<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<div id="header">

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="${pageContext.request.contextPath}"/>

    <div id="header-upper-box">
        <div>
            <div id="header-left">
                <a href="${path}/" title="보드인포"><img src="${path}/images/boardinfo_logo.png" width="170px"></a>
            </div>
            <div id="header-right">
                <form name="gameSearch" id="gameSearch" method="get" action="${path}/search/searchAll.do">
                    <div>
                        <input name="gameKeyword" id="gameKeyword" placeholder="보드게임 찾기" autocomplete="off">
                        <input type="hidden">
                        <img id="searchimg" src="${path}/images/search.png" onclick="searchAll()">
                        <div id="gameSearchDiv"></div>
                    </div>
                </form>
                <c:choose>
                    <c:when test="${sessionScope.userid == null && sessionScope.admin_id == null}">
                        <!-- 로그인하지 않은 상태 -->
                        <a href="${path}/member/member_login.do" title="로그인" class="sign" id="signIn">로그인</a>
                        <a href="${path}/member/member_join.do" title="회원가입" class="sign" id="signUp">회원가입</a>
                    </c:when>
                    <c:when test="${sessionScope.admin_id != null && !sessionScope.admin_id.equals('')}">
                        <!-- admin login 상태 -->
                        <div class="dropdown">
                            <div class="dropbtn"><a title="회원" class="sign" id="signIn">관리자 ${sessionScope.nickname}
                                님<img src="${path}/images/dropdown.png" width="16px"></a></div>
                            <div class="dropdown-content">
                                <a href="#">내활동</a>
                                <a href="${path}/admin/admin_view.do?admin_id=${sessionScope.admin_id}">관리자 정보</a>
                                <a href="${path}/admin/admin_dashboard">관리자 페이지</a>
                            </div>
                        </div>
                        <a id="adminLogoutBtn" class="sign">관리자 로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <!-- userid로 로그인한 상태 -->
                        <div class="dropdown">
                            <div class="dropbtn"><a title="회원" class="sign" id="signIn">${sessionScope.nickname} 님<img src="${path}/images/dropdown.png" width="16px"></a>

                            </div>
                            <div class="dropdown-content">
                                <a href="${path}/mypage/goMypage/${sessionScope.userid}">마이페이지</a>
                                <a href="${path}/member/member_view.do?userid=${sessionScope.userid}">회원정보</a>
                            </div>
                        </div>
                        <a href="${path}/member/logout.do" class="sign">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="nav">
        <ul class="menu">

            <li>
                <div class="dropdown">
                    <a href="${path}/game/gamerank/index" class="toMenu" title="게임정보">
                        게임정보<img src="${path}/images/dropdown.png" width="16px">
                    </a>

                    <div class="dropdown-content">
                        <a href="${path}/game/gamerank/week">게임순위</a>
                        <a href="#">카테고리</a>
                        <a href="#">디자이너</a>
                        <a href="#">출판사</a>
                    </div>
                </div>
            </li>
            <li>
                <div class="dropdown">
                    <a href="#" class="toMenu" title="게임포럼">게임포럼<img src="${path}/images/dropdown.png" width="16px"></a>
                    <div class="dropdown-content">
                        <a href="${path}/review/reviewlist.do?freeFlag=N">게임포럼</a>
                        <a href="${path}/review/reviewlist.do?freeFlag=Y">자유게시판</a>

                    </div>
                </div>
            </li>
            <li>
                <div class="dropdown">
                    <a href="${paht}/review/reviewlist.do" class="toMenu" title="자유게시판">자유게시판</a>
                </div>
            </li>
            <li>
                <div class="dropdown">
                    <a href="#" class="toMenu" title="오프모임">오프모임<img src="${path}/images/dropdown.png" width="16px"></a>
                    <div class="dropdown-content">
                        <a href="${path}/gathering/list.do">모임 목록</a>
                        <a href="${path}/gathering/add.do">모임 모집 글 작성</a>
                    </div>
                </div>
            </li>
            <li>
                <div class="dropdown">
                    <a href="${path}/tboard/list.do" class="toMenu" title="중고장터">중고장터
                        <img src="${path}/images/dropdown.png" width="16px"></a>
                    <div class="dropdown-content">
                        <a href="${paht}/tboard/list.do">전체</a>
                        <a href="${paht}/tboard/list.do?select_category=s">판매</a>
                        <a href="${paht}/tboard/list.do?select_category=b">구매</a>
                        <a href="${paht}/tboard/list.do?select_category=n">나눔</a>
                        <a href="${paht}/tboard/list.do?select_category=f">완료</a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<script>
    function searchAll() {
        var keyword = $("#gameKeyword").val();
        if (keyword !== "") {
            document.gameSearch.submit();
        }
    }

    //검색기능
    $(document).ready(function () {

        //검색창 키입력후
        $("#gameKeyword").keyup(function(event) {
            if (event.which === 13) { // 엔터 입력시
                event.preventDefault();
                searchAll();  //검색하러감
            } else {
                setTimeout(function () {  //딜레이
                //자동완성
                    var input = $("#gameKeyword").val();

                    if (input == "")
                        $('#gameSearchDiv').empty()
                    else {
                    $.ajax({
                        type: "get",
                        url: "${path}/game/autoGame.do/" + input,
                        success: function (result) {
                            var gameSearchDiv = $('#gameSearchDiv');
                            gameSearchDiv.empty(); // 기존 내용 비우기

                            if (result.length > 0) {  //결과값이 존재하면
                                gameSearchDiv.css('max-height', '300px').show(); // 값이 있을 경우 높이 설정하고 보이기
                                $(result).each(function (index, item) {
                                    var gametitle = item.gametitle;
                                    var gnum = item.gnum;
                                    var gamephoto_url = item.gamephoto_url;
                                    var bgg_thumbnail = item.bgg_thumbnail;
                                    var bggnum = item.bggnum;

                                    //var str => #gameSearchDiv 안에 들어갈 태그 입력
                                    var str = "<div class='searched_top'><div class='imageDiv'>";

                                    if (gamephoto_url != null) { //db에 입력된 사진 주소값이 없으면
                                        str += '<img src="${path}/resources/uploaded_game' + gamephoto_url + '"';
                                        str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
                                    } else {
                                        if (bggnum != null) { //보드게임긱 아이디가 존재하면
                                            str += '<img class="img_photo" src="' + bgg_thumbnail + '"';
                                            str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
                                        } else {
                                            str += '<img src="${path}/images/game/no-image-icon.png">';
                                        }
                                    }
                                    str += "</div><div class='titleDiv'><a href='${path}/game/view.do?gnum=" + gnum + "'>" + gametitle + "</a></div></div>";

                                    gameSearchDiv.append(str);
                                });
                            } else {
                                gameSearchDiv.hide(); // 값이 없을 경우 숨기기
                            }
                        },
                        error: function () {
                            console.log("에러..");
                        }
                    });
                    }
                }, 1000) //settimeout 콜백함수로 1초 딜레이 후 검색창 작동

               ;



            }

        });

        /*관리자 로그아웃 버튼*/
        $("#adminLogoutBtn").on("click", function () {
            if(confirm("로그아웃 하시겠습니까?")){
                location.href="${path}/admin/logout.do";
            }
        });
    });

    // javascript로 만든 드롭다운
    document.addEventListener('click', function (event) {
        /*가장 가까운 dropdown클래스를 변수에 이벤트 할당*/
        var dropdown = event.target.closest('.dropdown');
        if (dropdown) {
            /*dropdown이 true면 classList.toggle() show클래스가 없으면 추가 & 있으면 제거*/
            dropdown.querySelector('.dropdown-content').classList.toggle('show');
        } else {
            /*dropdown이 false면*/
            var dropdowns = document.getElementsByClassName('dropdown-content');
            for (var i = 0; i < dropdowns.length; i++) {
                var dropdownContent = dropdowns[i];
                /*show클래스를 갖고 있으면 제거*/
                if (dropdownContent.classList.contains('show')) {
                    dropdownContent.classList.remove('show');
                }
            }//for문 end
        } //if else문 end
    });

</script>
<style>


    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #eaeaea;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .dropdown:hover button {
        background-color: #eaeaea;
    }

</style>