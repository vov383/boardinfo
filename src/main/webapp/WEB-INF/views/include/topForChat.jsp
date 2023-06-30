<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<style>

    .memberArea{
        display: flex;
        justify-content: center;

        text-align: center;
        width: 100%;
        min-width: 120px;
        cursor: pointer;
        position: relative;
    }


    .nav{
        margin: 0 auto;
        max-width: 1120px;
    }

    .menu {
        margin: 0;
        max-width: 600px;
        height: 45px;

        display: flex;
        justify-content: space-between;
        align-items: center;
        list-style: none;
        padding: 0;
    }

      .menu li {
          display: flex;
          justify-content: center;
          flex: 0 0 25%;
          max-width: 25%;
          height: 100%;
          line-height: 45px;
          position: relative;
      }

      .menu li:hover{
          cursor: pointer;
      }

    .menu li a, .memberArea a{
        display: block;
        color: black;
        text-decoration: none;
    }

    .memberArea a:hover{
        text-decoration: none;
    }

    .toMenu{
          position: relative;
          font-size: 16px;
          font-weight: bold;
          text-decoration: none;
          color: black;
      }

      .toMenu > img{
          top: 35%;
          left: 100%;
          position: absolute;
          margin-left: 4px;
          -webkit-user-drag: none;
      }

        .memberArea img{
            top: 20%;
        }


    .dropdown-content{
          position: absolute;
          display: none;
          top: 100%;
          width: 100%;
          background-color: white;
          box-shadow: 4px 6px 5px 1px rgba(0, 0, 0, 0.1);
          z-index: 1;
      }


      .dropdown-content a{
          width: 100%;
          text-align: center;
      }

      .dropdown-content a:hover{
          background-color: #e9e9e9
      }


    .memberArea .dropdown-content{
        top: calc(100% + 5px);
        width: 100%;
        right: 0;
        min-width: 90px;
        max-width: 90px;
        flex-direction: column;
    }

    .memberArea .dropdown-content a{
        min-width: 90px;
        width: 100%;
        padding: 10px 0;
    }

    .noticeList{
        position: absolute;
        z-index: 100;
        display: none;
        flex-direction: column;

        margin-top: 20px;
        width: 385px;
        min-height: 100px;
        right: -40px;
        background-color: white;
        box-shadow: 10px 10px 20px 0 rgba(0,0,0,.1);
        border-radius: 10px;
    }

    .noticeList::after{
        content: "";
        position: absolute;
        bottom: 100%;
        right: 44px;
        border-width: 8px;
        border-style: solid;
        border-color: transparent transparent #EDECEC transparent;
    }


    .noticeList > div:first-child{
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        width: 100%;
        background-color: #EDECEC;
        padding: 10px 14px;
    }

    .toast-chat{
        margin-top: 8px;
        right: -88px;
        display: flex;
        flex-direction: column;
        position: absolute;
    }

    .alarmMessages{
        padding: 5px;
        background-color: white;
        width: 220px;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        text-overflow: ellipsis;
        overflow: hidden;
        box-shadow: 2px 5px 5px 1px rgba(0,0,0,.1);
        border-bottom: 1px solid #d9d9d9;
        border-radius: 6px;
    }

    .alarmMessages:hover{
        cursor: pointer;
    }


    .alarmMessages::after{
        content: "";
        position: absolute;
        bottom: 100%;
        left: 50%;
        border-width: 8px;
        border-style: solid;
        border-color: transparent transparent white transparent;
    }


</style>


<div id="header">

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="${pageContext.request.contextPath}"/>


    <div id="header-upper-box">
        <div>
            <div id="header-left">
                <a href="${path}/" title="보드인포"><img src="${path}/images/logo.png" width="170px"></a>
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
                        <a title="채팅" href="${path}/chat/room.do">
                            <div id="chatArea">
                                <span id="unreadChat">
                                </span><img src="${path}/images/chat.png" id="chatImg" alt="채팅">
                                <div class="toast-chat"></div>
                            </div>
                            <div id="noticeArea">
                                <a title="알림" href="#">
                                    <span id="unreadNotice"></span>
                                    <img src="${path}/images/notice.png" id="noticeImg" alt="알림">
                                </a>
                                <div class="noticeList">
                                    <div>알림</div>
                                </div>
                            </div>
                        </a>
                        <!-- admin login 상태 -->

                        <div class="memberArea">
                            <div class="toMenu">
                                관리자 ${sessionScope.nickname}님
                                <img src="${path}/images/dropdown.png" width="16px">
                            </div>
                            <div class="dropdown-content">
                                <a href="#">내활동</a>
                                <a href="${path}/admin/admin_view.do?admin_id=${sessionScope.admin_id}">관리자 정보</a>
                                <a href="${path}/admin/admin_dashboard">관리자 페이지</a>
                                <a id="adminLogoutBtn" class="sign">관리자 로그아웃</a>
                            </div>
                        </div>

                    </c:when>
                    <c:otherwise>
                            <div id="chatArea">
                                <a title="채팅" href="${path}/chat/room.do">
                                    <span id="unreadChat"></span>
                                    <img src="${path}/images/chat.png" id="chatImg" alt="채팅">
                                </a>
                                <div class="toast-chat"></div>
                            </div>
                        <div id="noticeArea">
                            <a title="알림" href="#">
                                <span id="unreadNotice"></span>
                                <img src="${path}/images/notice.png" id="noticeImg" alt="알림">
                            </a>
                            <div class="noticeList">
                                <div>알림</div>
                            </div>
                        </div>
                        <!-- userid로 로그인한 상태 -->
                   <div class="memberArea">
                        <div class="toMenu">
                            ${sessionScope.nickname} 님
                            <img src="${path}/images/dropdown.png" width="16px">
                        </div>
                        <div class="dropdown-content">
                         <a href="${path}/mypage/goMypage/${sessionScope.userid}">마이페이지</a>
                         <a href="${path}/member/member_view.do?userid=${sessionScope.userid}">회원정보</a>
                         <a href="${path}/member/logout.do" class="sign">로그아웃</a>
                        </div>
                   </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="nav">
        <ul class="menu">
            <li>
                <div class="toMenu" onclick="location.href='${path}/game/gamerank/week'">
                        게임정보
                    <img src="${path}/images/dropdown.png" width="16px">
                </div>
                <div class="dropdown-content">
                    <a href="${path}/game/gamerank/week">베스트게임</a>
                    <a href="${path}/game/gamerank/newbie">최신게임</a>
                    <a href="${path}/game/categoryList">카테고리</a>
                    <a href="/game/themeList/-">테마</a>
                    <c:choose>
                        <c:when test="${sessionScope.admin_id != null && !sessionScope.admin_id.equals('')}">
                            <a href="#" onclick="goInsert()">게임등록</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" onclick="goInsert()">게임등록신청</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </li>
            <li>
                <div class="toMenu" onclick="location.href='${path}/review/reviewlist.do?freeFlag=A'">
                    커뮤니티
                    <img src="${path}/images/dropdown.png" width="16px">
                </div>
                <div class="dropdown-content">
                    <a href="${path}/review/reviewlist.do?freeFlag=A">전체</a>
                    <a href="${path}/review/reviewlist.do?freeFlag=H">인기글</a>
                    <a href="${path}/review/reviewlist.do?freeFlag=N">게임포럼</a>
                    <a href="${path}/review/reviewlist.do?freeFlag=Y">자유게시판</a>
                </div>
            </li>
            <li>
                <div class="toMenu">
                    <a href="${path}/gathering/list.do" class="toMenu" title="오프모임">
                    오프모임
                    </a>
                </div>
            </li>
            <li>
                <div class="toMenu">
                    <a href="${path}/tboard/list.do" class="toMenu" title="중고장터">
                        중고장터
                    </a>
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
    $(document).ready(function(){

        var timeOutId;

        $(".menu").on("mouseleave", function(){
            var $dropdowns = $(this).find(".dropdown-content").is(":visible");
            timeOutId = setTimeout(function() {
                $dropdowns.slideUp(300, function() {
                    $dropdowns.css("display", "none");
                });
            }, 100);
        });

        $(".menu li, .memberArea").on("mouseleave", function() {
            var $dropdown = $(this).find(".dropdown-content");
            timeOutId = setTimeout(function() {
                $dropdown.slideUp(300, function() {
                    $dropdown.css("display", "none");
                });
            }, 100);
        });


        $(".menu li, .memberArea").on("mouseenter", function(){
            var $dropdown = $(this).find(".dropdown-content");
            if($dropdown.is(":visible")){
                clearTimeout(timeOutId);
            }
            else{
                $(this).find(".dropdown-content").slideDown(200, function() {
                    $(this).css("display", "block");
                });
            }
        });



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


    function goInsert() {
        if("${sessionScope.userid}" == "" && "${sessionScope.admin_id}" == ""){
            if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                location.href= "${path}/member/member_login.do";
                return;
            }
        }else{
            location.href= "${path}/game/write.do";
        }
    }


</script>
