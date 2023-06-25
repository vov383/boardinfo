<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.springframework.http.HttpRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>BOARDINFO</title>
        <%@ include file="../include/js/header.jsp" %>
        <link rel="stylesheet" href="${path}/include/js/style_game.css">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

        <style>
            #contentsMain{
                border-top: 2px solid black;
            }

            #gameInfoUpper{
                display: flex;
                padding: 20px 20px 35px 20px;
            }

            #upperLeftSide{
                padding-right: 45px;
            }

            .img_photo{
                width: 260px;
                height: 260px;
                border: 1px solid black;
            }

            #upperRightSide{
                display: flex;
                flex-direction: column;
                flex-grow: 1;
                align-items: flex-start;
            }

            #titleArea{
                display: flex;
                align-items: center;
            }

            #titleArea h2{
                font-size: 24px;
                margin: 0 2px 0 0;
                padding: 0;
            }

            #titleArea h3{
                font-size: 20px;
                margin: 0 10px 0 0;
                padding: 0;
            }

            #titleArea span:first-of-type{
                font-size: 20px;
                margin-right: 15px;
            }

            #titleArea span:nth-of-type(2){
                font-size: 16px;
            }

            #upperRightSide > div:first-of-type{
                display: flex;
                flex-direction: column;
                height: 260px;
                justify-content: space-between;

                text-align: left;
            }

            #upperRightSide > div > div:nth-of-type(2){
                padding: 20px 0;
            }

            #upperRightSide > div> div:nth-of-type(2) span{
                font-size: 17px;
            }

            .goTo{
                padding-left: 15px;
                color: #929292;
                text-decoration: none;
            }

            a[class='goTo']:first-of-type{
                margin-right: 20px;
            }

            .labelAndContent{
                display: flex;
            }

            .labelAndContent span{
                font-size: 17px;
            }

            .labelAndContent > span:first-of-type{
                width: 100px;
            }

            .labelAndContent > span:nth-of-type(2){
                width: 210px;
            }

            .byUser{
                color: #F9841A;
            }

            #ratingArea{
                padding-top: 15px;
                display: flex;
                flex-direction: row;
                align-items: center;
                width: 100%;
            }

            #ratingArea > span{
                font-size: 17px;
                width: 100px;
                text-align: left;
            }


            .f_star, .h_star{
                opacity: 0;
                position: absolute;
                z-index: 1;
            }

            .f_star, .e_star{
                width: 56px;
                -webkit-user-drag: none;
            }

            .h_star{
                -webkit-user-drag: none;
                width: 28px;
            }

            .b_star{
                position: relative;
            }

            #myStars{
                margin-right: 50px;
                cursor: pointer;
            }


            .detailDiv{
                padding: 30px 20px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                border-top: 1px solid #D9D9D9;
            }

            .smallTitle{
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .detailInfoLabelAndItem{
                display: flex;
                flex-direction: row;
                margin-bottom: 10px;
                padding-left: 5px;
                text-align: left;
            }

            .detailInfoLabelAndItem > span:first-of-type{
                min-width: 100px;
                flex-grow: 0;
            }


            div[class='detailInfoLabelAndItem']:last-of-type{
                margin-bottom: 0;
            }

            .detailInfoLabelAndItem > a{
                color: black;
            }

            #graphBigArea{
                display: flex;
                width: 100%;
            }

            #graphBigArea ul{
                width: 170px;
                padding: 15px 0;
                margin: 0;
                list-style: none;
                text-align: left;
                display: flex;
                flex-direction: column;
                justify-content: space-evenly;
            }

            #graphBigArea li{
                font-weight: bold;
                font-size: 17px;
                padding: 10px 0 10px 5px;
                cursor: pointer;
            }

            #graphBigArea li:hover{
                background-color: rgba(0,0,0,.1);
            }

            #graphBigArea > div:last-of-type{
                flex-grow: 1;
            }

            #graphRightArea{
                display: flex;
            }

            #graphMainArea{
                overflow: hidden;
            }

            .before_div, .next_div {
                cursor: pointer;
                width: 80px;
                display: flex;
                align-items: flex-end;
                justify-content: center;
            }

            .hover_span{
                cursor: pointer;
            }

            .before:hover, .next:hover, .hover_span:hover {
                background-color: rgba(0,0,0,.1);
            }

            .before, .next {
                padding: 65px 25px;
                width: 30px;
                height: 60px;
            }

            .slide-container {
                width: 300%;
                transition: all 1s;
                transform: translateX(0%);
            }

            .chartDiv{
                width: 100%;
                height: 200px;
            }

            .slide-box {
                width: calc(100%/3);
                float: left;
            }

            .slide-box > div:first-of-type{
                height: 78px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .slide-box p {
                text-align: left;
                margin: 0;
                font-size: 20px;
            }

            .slide-box p span{
                font-size: 20px;
            }

            .slide-box p strong{
                font-size: 32px;
            }

            #topReviewList{
                margin-top: 12px;
                width: 100%;
                display: flex;
                flex-direction: column;
            }

            #topReviewList > span:first-of-type{
                text-align: right;
            }

            .topReview{
                width: 100%;
                text-align: left;
                display: flex;
                align-items: center;
                margin-top: 12px;
            }

            .topReview > span:first-of-type{
                padding-right: 20px;
            }

            .topReview > div:last-of-type{
                padding: 20px 20px 16px 20px;
                border: 1px solid #D9D9D9;
                flex-grow: 1;
            }

            .reviewStar{
                position: relative;
            }

            .reviewStar > span{
                position: absolute;
                left: 32px;
                top: 34px;
                z-index: 1;
                font-size: 18px;
                font-weight: bold;
            }

            .reviewStar img{
                -webkit-user-drag: none;
            }

            .topReview > div:last-of-type > div{
                margin-bottom: 5px;
            }

            .topReview > div:last-of-type > div:first-of-type{
                font-weight: bold;
                margin-bottom: 5px;
            }

            .topReview > div:last-of-type > div:last-of-type{
                margin-bottom: 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .reviewDetail > span{
                font-size: 14px;
                padding: 0 10px;
                border-right: 1px solid black;
            }

            .reviewDetail > span:first-of-type{
                padding-left: 0;
            }

            .reviewDetail > span:last-of-type{
                border-right: none;
            }

            .likeItDiv {
                display: flex;
                align-content: center;
                padding: 4px 20px;
                border: 1px solid black;
                border-radius: 30px;
                cursor: pointer;
            }

            .likeItDiv > img{
                -webkit-user-drag: none;
                margin-right: 5px;
            }


            /*모달*/
            .popup-wrap{
                z-index: 1000;
                background-color:rgba(0,0,0,.3);
            /*배경색과 투명도로 살짝 어둡지만 투명한 배경*/
            /*허공에 붕 떠있는 느낌을 주고 싶으면 안넣어도 무방*/
                justify-content:center;
            /*수평 중앙정렬*/
                align-items:center;
            /*수직 중앙정렬*/
                position:fixed;
            /*포지션 픽스, 화면이 스크롤되더라도 고정되기 위함*/
                top:0;
                left:0;
                right:0;
                bottom:0;
            /*모든 방향에 0을 주면 화면에 꽉차게 됩니다.*/
                display:none;
            /*이벤트가 발생할 때 띄우기 위해 숨김*/
            /*처음부터 보이게 하는 상황이라면 display:flex;*/
                padding:15px;
            /*//반응형의 경우 padding이 없으면 박스가 화면에 붙어서 안이뻐짐*/
            }

            .popup{
                width:100%;
            /*반응형 이기 때문에 가로값은 100%*/
                max-width: 670px;
            /*팝업의 최대 크기지정*/
                border-radius:10px;
            /*둥글둥글한 디자인을 위해 각을 없앱니다.*/
                overflow:hidden;
            /*각을 없앴을 때 내부 영역이 튀어나오는걸 방지*/
            /*팝업이 허공에 떠있는 듯한 느낌을 주기 위한 그림자 효과.*/
                box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
            }

            .popup-body{
            /*몸통*/
                width:100%;
                background-color:#ffffff;
            /*컨텐츠 영역의 배경색*/
            }

            /*모달 내용 관련*/
            #bigFrame{
                width: 550px;
                padding: 50px;
                display: flex;
                flex-direction: column;

                /*컨텐츠 내용 영역*/
                word-break:break-word;
                /*단어가 짤리지 않음*/
                overflow-y:auto;
                /*내부요소가 지정한 세로 값보다 클 경우 스크롤 생성*/
                min-height:100px;
                max-height:80vh;
            }

            .labelAndStars{
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }

            #labelR{
                width: 155px;
            }

            #labelW{
                width: 135px;
            }

            .ratingStar, .weightStar{
                cursor: pointer;
            }

            .star{
                position: relative;
            }

            .star img:nth-child(3){
                width: 50px;
            }

            .halfStar{
                position: absolute;
                width: 25px;
                opacity: 0;
                z-index: 2;
                -webkit-user-drag: none;
            }

            .fullStar{
                position: absolute;
                width: 50px;
                opacity: 0;
                z-index: 1;
                -webkit-user-drag: none;
            }

            #hollow{
                opacity: 100%;
                width: 20px;
                height: 100%;
            }


            #myRating, #myWeight{
                margin-left: 25px;
                font-size: 22px;
                font-weight: bold;
            }


            .columnFlex{
                display: flex;
                flex-direction: column;
                margin-bottom: 30px;
            }

            .columnFlex > span{
                margin-bottom: 10px;
            }

            #ratingPeopleTable{
                border-collapse: collapse;
            }


            #ratingPeopleTable th, #ratingPeopleTable td{
                height: 26px;
            }

            #ratingPeopleTable td:first-of-type{
                padding-left: 20px;
            }

            #ratingPeopleTable td:not(#ratingPeopleTable td:first-of-type){
                text-align: center;
            }

            #ratingPeopleTable tr:nth-child(2n){
                background-color: #F7F7F8;
            }

            .columnFlex textarea{
                resize: none;
                height: 180px;
                padding: 10px;
            }

            #bigFrame > div:last-of-type{
                text-align: center;
            }

            #bigFrame > div:last-of-type > button{
                width: 140px;
                height: 45px;
                font-size: 18px;
            }

            #submitBtn{
                background-color: #1432B1;
                color: white;
                border: none;
                margin-right: 20px;
                cursor: pointer;
            }

            #deleteBtn{
                background-color: white;
                border: 1px solid black;
                cursor: pointer;
                margin-right: 20px;
            }

            #cancelBtn{
                background-color: white;
                border: 1px solid black;
                cursor: pointer;
            }

        </style>
   </head>

   <body>

   <header>
       <%@include file="../include/top.jsp" %>
   </header>

   <main>
       <div id="contents">
           <div id="contentsHeader">
               <h2>게임정보</h2>
           </div>
           <div id="contentsLocation">
               홈&gt 게임정보&gt 게임정보
           </div>
           <div id="contentsMain">


	<div align="center">

           <div id="gameInfoUpper">

               <div id="upperLeftSide">
                   <c:choose>
                       <c:when test="${map.dto.gamephoto_url != null}">
                           <div>
                               <img class="img_photo" src="${path}/resources/uploaded_game${map.dto.gamephoto_url}">
                           </div>
                           <div>이미지 보기</div>
                       </c:when>
                       <c:otherwise>
                           <c:choose>
                            <c:when test="${map.dto.bgg_thumbnail != null}">
                               <div>
                                   <img class="img_photo" src="${map.dto.bgg_thumbnail}"onerror="this.src='../images/game/no-image-icon.png'">
                               </div>
                               <div>이미지 출처: boardgamegeek</div>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <img class="img_photo" src="../images/game/no-image-icon.png">
                                </div>
                            </c:otherwise>
                           </c:choose>
                       </c:otherwise>
                   </c:choose>
               </div>

           	<div id="upperRightSide">

                <div>
                    <div id="titleArea"><h2>${map.dto.gametitle}</h2><span>(${map.dto.gametitle_eng})</span>
                        <span>
                            <c:if test="${map.dto.release_year > 0}">
                            ${map.dto.release_year}
                            </c:if>
                        </span></div>
                    <div>
                        <span>
                            <img src="${path}/images/game/yellow_star.png" width="45px" height="40px" style="vertical-align: middle;">
                            <c:choose>
                                <c:when test="${statisticMap!=null}">
                                    <strong>
                                    <fmt:formatNumber value="${statisticMap.AVGRATING}" pattern="0.0"/>
                                    </strong> (${statisticMap.TOT}명)
                                </c:when>
                                <c:otherwise>- (0명)</c:otherwise></c:choose><a href="#" class="goTo">&gt</a>
                        </span>
                        <span>
                            <img src="../images/medal105.png" width="45px" height="45px" style="vertical-align: middle;">
                            이번 주 게임 <strong>${map.dto.game_rank}</strong>위<a href="#" class="goTo">&gt</a>
                        </span>
                    </div>

                    <div class="labelAndContent"><span>인원</span>
                        <span>
                            ${map.dto.players}
                            <c:if test="${statisticMap.recommendPlayers!=null && statisticMap.recommendPlayers!=''}">
                                <span class="byUser">(${statisticMap.recommendPlayers})</span>
                            </c:if>
                        </span>
                    </div>
                    <div class="labelAndContent"><span>난이도</span>
                        <span>
                           <c:choose>
                           <c:when test="${statisticMap!=null}">
                           <span class="byUser"><fmt:formatNumber value="${statisticMap.AVGWEIGHT}" pattern="0.0"/></span>
                           </c:when>
                           <c:otherwise>
                           -
                           </c:otherwise>
                           </c:choose>
                            / 5 </span>
                    </div>
                    <div class="labelAndContent"><span>연령</span><span>${map.dto.ages}세</span></div>
                    <div class="labelAndContent"><span>시간</span><span>${map.dto.playtime}</span></div>
                </div>

                <div id="ratingArea">
                    <span>내 평가</span>
                    <div id="myStars">
                        <span class="b_star">
                            <img src="${path}/images/game/half_star.png" class="h_star my_star" data-value="0.5">
                            <img src="${path}/images/game/yellow_star.png" class="f_star my_star" data-value="1">
                            <img src="${path}/images/game/empty_star.png" class="e_star">
                        </span>

                        <span class="b_star">
                            <img src="${path}/images/game/half_star.png" class="h_star my_star" data-value="1.5">
                            <img src="${path}/images/game/yellow_star.png" class="f_star my_star" data-value="2">
                            <img src="${path}/images/game/empty_star.png" class="e_star">
                        </span>

                        <span class="b_star">
                            <img src="${path}/images/game/half_star.png" class="h_star my_star" data-value="2.5">
                            <img src="${path}/images/game/yellow_star.png" class="f_star my_star" data-value="3">
                            <img src="${path}/images/game/empty_star.png" class="e_star">
                        </span>

                        <span class="b_star">
                            <img src="${path}/images/game/half_star.png" class="h_star my_star" data-value="3.5">
                            <img src="${path}/images/game/yellow_star.png" class="f_star my_star" data-value="4">
                            <img src="${path}/images/game/empty_star.png" class="e_star">
                        </span>

                        <span class="b_star">
                            <img src="${path}/images/game/half_star.png" class="h_star my_star" data-value="4.5">
                            <img src="${path}/images/game/yellow_star.png" class="f_star my_star" data-value="5">
                            <img src="${path}/images/game/empty_star.png" class="e_star">
                        </span>
                    </div>
                    <span class="hover_span">컬렉션 추가</span>

                    <span class="hover_span" id="btnGameUpdate">게임정보수정</span>
                    <form name="updateViewForm" method="post" action="${path}/game/updateView.do">
                        <input type="hidden" name="gnum" value="${map.dto.gnum}">
                    </form>


                </div>

           		</div>
           	</div>
           		

        <div class="detailDiv">
            <span class="smallTitle">상세정보</span>
            <div class="detailInfoLabelAndItem">
                <span>카테고리</span>
                <div>
                <c:forEach var="category" items="${map.clist}">
                    <a class="infoItems" href="${path}/game/partrank/week?filter=gamecategory&num=${category.cnum}">${category.gamecategory}</a>
                </c:forEach>
                </div>
            </div>

            <div class="detailInfoLabelAndItem">
                <span>아티스트</span>
                <div>
                    <c:forEach var="artist" items="${map.alist}">
                        <a class="infoItems" href="${path}/game/partrank/week?filter=artist&num=${artist.anum}">${artist.artist}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="detailInfoLabelAndItem">
                <span>디자이너</span>
                <div>
                    <c:forEach var="designer" items="${map.dlist}">
                        <a class="infoItems" href="${path}/game/partrank/week?filter=designer&num=${designer.dnum}">${designer.designer}</a>
                    </c:forEach>
                </div>
            </div>


            <div class="detailInfoLabelAndItem">
                <span>게임방식</span>
                <div>
                    <c:forEach var="mechanic" items="${map.mlist}">
                        <a class="infoItems" href="${path}/game/partrank/week?filter=mechanic&num=${mechanic.mnum}">${mechanic.mechanic}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="detailInfoLabelAndItem">
                <span>퍼블리셔</span>
                <div>
                    <c:forEach var="publisher" items="${map.plist}">
                        <a class="infoItems" href="${path}/game/partrank/week?filter=publisher&num=${publisher.pnum}">${publisher.publisher}</a>
                    </c:forEach>
                </div>
            </div>


            <c:import url="game_ExReList_module.jsp" charEncoding="UTF-8">
                <c:param name="gnum" value="${map.dto.gnum}"/>
            </c:import>



        </div>

        <hr style="clear: both;">


        </div>


        <div class="detailDiv">
            <span class="smallTitle">보드인의 평가</span>
            <div id="graphBigArea">
                <ul>
                    <li class="slide-1">평점</li>
                    <li class="slide-2">인원</li>
                    <li class="slide-3">난이도</li>
                </ul>

                    <div id="graphRightArea">
                        <div class="before_div">
                            <img src="../images/chevron-compact-left.svg" class="before" />
                        </div>
                        <div id="graphMainArea">
                            <div class="slide-container">
                                <div class="slide-box">
                                    <div>
                                        <c:choose>
                                            <c:when test="${statisticMap!=null}">
                                                <p>평균 평점 <strong><fmt:formatNumber value="${statisticMap.AVGRATING}" pattern="0.0"/></strong></p>
                                                <p>전체 평가 수 ${statisticMap.TOT}</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p>평균 평점 <strong>0.0</strong></p>
                                                <p>전체 평가 수 0</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="chartDiv" id="ratingChartDiv">평점그래프</div>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <p>추천 인원수</p>
                                        <p>
                                            <c:choose>
                                                <c:when test="${statisticMap.recommendPlayers!=null && statisticMap.recommendPlayers!=''}">
                                                    <strong>${statisticMap.recommendPlayers}</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <strong>-</strong>
                                                </c:otherwise>
                                            </c:choose>

                                        </p>
                                    </div>
                                    <div class="chartDiv" id="playerChartDiv">인원그래프</div>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <c:choose>
                                            <c:when test="${statisticMap!=null}">
                                                <p>평균 난이도 <strong><fmt:formatNumber value="${statisticMap.AVGWEIGHT}" pattern="0.0"/></strong></p>
                                                <p>전체 평가 수 <span id="weightPeopleCount"></span></p>
                                            </c:when>
                                            <c:otherwise>
                                                <p>평균 난이도 <strong>0.0</strong></p>
                                                <p>전체 평가 수 0</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="chartDiv" id="weightChartDiv">난이도그래프</div>
                                </div>
                            </div>
                        </div>
                        <div class="next_div">
                            <img src="../images/chevron-compact-right.svg" class="next" />
                        </div>
                </div>
            </div>

            <div id="topReviewList">
                <span>더보기</span>
            </div>



        </div>

    </div>

   </div>



           </div>
       </div>
   </main>

   <%--modal--%>
   <div class="container">
       <div class="popup-wrap" id="popup">
           <div class="popup">


               <div class="popup-body">

                           <!--여기부터 모달내용-->
                           <form name="ratingForm" id="bigFrame">
                               <input type="hidden" name="type">
                               <input type="hidden" name="gnum" value="${map.dto.gnum}">
                               <div class="labelAndStars">
                                   <span id="labelR">내 평점 (필수)</span>
                                   <div>
                                      <span class="star">
                                          <img src="${path}/images/game/half_star.png" data-value="0.5" class="ratingStar halfStar">
                                          <img src="${path}/images/game/yellow_star.png" data-value="1" class="ratingStar fullStar" style="opacity: 100">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span  class="star">
                                          <img src="${path}/images/game/half_star.png" data-value="1.5" class="ratingStar halfStar">
                                          <img src="${path}/images/game/yellow_star.png" data-value="2" class="ratingStar fullStar" style="opacity: 100">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span  class="star">
                                          <img src="${path}/images/game/half_star.png" data-value="2.5" class="ratingStar halfStar">
                                          <img src="${path}/images/game/yellow_star.png" data-value="3" class="ratingStar fullStar" style="opacity: 100">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span  class="star">
                                          <img src="${path}/images/game/half_star.png" data-value="3.5" class="ratingStar halfStar">
                                          <img src="${path}/images/game/yellow_star.png" data-value="4" class="ratingStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span  class="star">
                                          <img src="${path}/images/game/half_star.png" data-value="4.5" class="ratingStar halfStar">
                                          <img src="${path}/images/game/yellow_star.png" data-value="5" class="ratingStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <input type="hidden" name="rating" value="3">
                                   </div>
                                   <span id="myRating"></span>
                               </div>
                               <div class="labelAndStars">
                                   <span id="labelW">난이도 (선택)</span>
                                   <span class="weightStar" id="hollow" data-value="0">
                                      &nbsp
                                  </span>
                                   <div>
                                      <span class="star">
                                          <img src="${path}/images/game/half_star_b.png" data-value="0.5" class="weightStar halfStar">
                                          <img src="${path}/images/game/blue_star.png" data-value="1" class="weightStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span class="star">
                                          <img src="${path}/images/game/half_star_b.png" data-value="1.5" class="weightStar halfStar">
                                          <img src="${path}/images/game/blue_star.png" data-value="2" class="weightStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span class="star">
                                          <img src="${path}/images/game/half_star_b.png" data-value="2.5" class="weightStar halfStar">
                                          <img src="${path}/images/game/blue_star.png" data-value="3" class="weightStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span class="star">
                                          <img src="${path}/images/game/half_star_b.png" data-value="3.5" class="weightStar halfStar">
                                          <img src="${path}/images/game/blue_star.png" data-value="4" class="weightStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <span class="star">
                                          <img src="${path}/images/game/half_star_b.png" data-value="4.5" class="weightStar halfStar">
                                          <img src="${path}/images/game/blue_star.png" data-value="5" class="weightStar fullStar">
                                          <img src="${path}/images/game/empty_star.png">
                                      </span>
                                       <input type="hidden" name="weight" value="">
                                   </div>
                                   <span id="myWeight"></span>
                               </div>
                               <div class="columnFlex">
                                   <span>추천인원 (선택)</span>
                                   <table id="ratingPeopleTable">
                                       <tr><th></th><th>베스트</th><th>추천</th><th>비추천</th><th>모름(응답없음)</th></tr>
                                       <tr>
                                           <td>1</td>
                                           <td><input name="participant1" value="1" type="radio"></td>
                                           <td><input name="participant1" value="2" type="radio"></td>
                                           <td><input name="participant1" value="3" type="radio"></td>
                                           <td><input name="participant1" value="" type="radio" checked></td>
                                       </tr>
                                       <tr>
                                           <td>2</td>
                                           <td><input name="participant2" value="1" type="radio"></td>
                                           <td><input name="participant2" value="2" type="radio"></td>
                                           <td><input name="participant2" value="3" type="radio"></td>
                                           <td><input name="participant2" value="" type="radio" checked></td>
                                       </tr>
                                       <tr>
                                           <td>3</td>
                                           <td><input name="participant3" value="1" type="radio"></td>
                                           <td><input name="participant3" value="2" type="radio"></td>
                                           <td><input name="participant3" value="3" type="radio"></td>
                                           <td><input name="participant3" value="" type="radio" checked></td>
                                       </tr>
                                       <tr>
                                           <td>4</td>
                                           <td><input name="participant4" value="1" type="radio"></td>
                                           <td><input name="participant4" value="2" type="radio"></td>
                                           <td><input name="participant4" value="3" type="radio"></td>
                                           <td><input name="participant4" value="" type="radio" checked></td>
                                       </tr>
                                       <tr>
                                           <td>5인 이상</td>
                                           <td><input name="participant5" value="1" type="radio"></td>
                                           <td><input name="participant5" value="2" type="radio"></td>
                                           <td><input name="participant5" value="3" type="radio"></td>
                                           <td><input name="participant5" value="" type="radio" checked></td>
                                       </tr>
                                       </tr>
                                   </table>
                               </div>
                               <div class="columnFlex">
                                   <span>코멘트 (선택)</span>
                                   <textarea name="rating_comment"></textarea>
                               </div>

                               <div>
                               <c:choose>
                                   <c:when test="${statisticMap.userRating != null && statisticMap.userRating != ''}">
                                       <button type="button" id="submitBtn" onclick="submitRating()">수정</button>
                                       <button type="button" id="deleteBtn" onclick="deleteRating()">삭제</button>
                                       <button type="button" id="cancelBtn" onclick="cancelRating()">취소</button>
                                   </c:when>
                                   <c:otherwise>
                                       <button type="button" id="submitBtn" onclick="submitRating()">작성 완료</button>
                                       <button type="button" id="cancelBtn" onclick="cancelRating()">작성 취소</button>
                                   </c:otherwise>
                               </c:choose>
                               </div>
                           </form>
                           <%--여기까지 모달 내용--%>

                       </div>
               </div>



           </div>
       </div>
   </div>

   <footer>
       <%@include file="../include/footer.jsp" %>
   </footer>

   <script>

       //별점 차트 생성하기
       // 일단 구글 차트 라이브러리 로딩
       //라이브러리 로딩이 완료되면 drawChart() 함수 호출 [용법 주의]
       google.charts.load('current', {packages: ['corechart']});
       google.charts.setOnLoadCallback(drawChart);


       $(function() {


           /*게임리뷰 좋아요 상위 3개 불러오기*/
           $.ajax({
               type: "get",
               url : "${path}/gameRating/getTopRatings.do",
               data : {
                   "gnum": "${map.dto.gnum}"
               },
               success: function(result){

                   list = result.list;

                   for(let i=0; i<list.length; i++){
                       let rating_comment = "";
                       if(list[i].rating_comment != null)
                           rating_comment = "<div>" + list[i].rating_comment + "</div>";

                       let rating = list[i].rating + "";
                       if(rating.indexOf('.') == -1){
                        rating += '.0';
                       }


                       let weightSpan = "";
                       let weight = list[i].weight + "";
                       if(weight != '') {
                           if(weight.indexOf('.') == -1){
                               weight += '.0';
                           }
                           weightSpan = "<span>난이도 " + weight + "</span>";
                       }

                       let bestSpan = "";
                       let goodSpan = "";
                       let badSpan = "";

                       let bestPeople = [];
                       let goodPeople = [];
                       let badPeople = [];

                       let nums = [list[i].participant1, list[i].participant2, list[i].participant3,
                           list[i].participant4, list[i].participant5];

                       for(let i=0; i<4; i++){
                           if(nums[i] == 1) bestPeople.push(i+1);
                           else if(nums[i] == 2) goodPeople.push(i+1);
                           else if(nums[i] == 3) badPeople.push(i+1);
                       }

                       if(nums[4] == 1) bestPeople.push("5↑");
                       else if(nums[4] == 2) goodPeople.push("5↑");
                       else if(nums[4] == 3) badPeople.push("5↑");


                       if(bestPeople.length > 0)
                           bestSpan = "<span>베스트인원 " + bestPeople.join(", ") + "</span>";

                       if(goodPeople.length > 0)
                           goodSpan = "<span>추천인원 " + goodPeople.join(", ") + "</span>";

                       if(badPeople.length > 0)
                           badSpan = "<span>비추천인원 " + badPeople.join(", ") + "</span>";


                       let likeItDiv;

                       if(list[i].myLike > 0)
                           likeItDiv = "<div data-like='y' class='likeItDiv' onclick='likeIt(\"" + list[i].userid + "\")'>"
                               +"<img src='${path}/images/game/pink_heart.png' width='20px'> <span class='likeCount'>" + list[i].likeCount + "</span></div>";

                       else
                           likeItDiv = "<div data-like='n' class='likeItDiv' onclick='likeIt(\"" + list[i].userid + "\")'>"
                               +"<img src='${path}/images/game/empty_heart.png' width='20px'> <span class='likeCount'>" + list[i].likeCount + "</span></div>";


                       let topReview = "<div class='topReview' data-writer='" + list[i].userid + "'> <span class='reviewStar'><span>" + rating + "</span>"
                            +"<img src='${path}/images/game/yellow_star.png' width='90px' height='85px' style='vertical-align: middle'></span>"
                            +"<div><div>"+ list[i].userid + "&nbsp;&nbsp;&nbsp;&nbsp;" + list[i].create_date + "</div>"
                            + rating_comment
                            +"<div><div class='reviewDetail'>" + weightSpan + bestSpan + goodSpan + badSpan + "</div>"
                            +likeItDiv + "</div></div></div>";

                       $("#topReviewList").append(topReview);
                   }

                   $(".likeItDiv").mouseover(function(){
                       if($(this).data("like") == 'n'){
                           $(this).find("img").prop("src", "${path}/images/game/pink_heart.png");
                       }
                   });

                   $(".likeItDiv").mouseout(function(){
                       if($(this).data("like") == 'n'){
                           $(this).find("img").prop("src", "${path}/images/game/empty_heart.png");
                       }
                   });

               }
           });



           let msg = sessionStorage.getItem("msg");
           if(msg){
            alert(msg);
            sessionStorage.removeItem("msg");
           }

           let userRating = "${statisticMap.userRating}"
           if(userRating != null && userRating != '') {
               let my_star = $(".my_star");

               $.each(my_star, function () {
                   if ($(this).data('value') <= userRating) {
                       $(this).css('opacity', 100);
                   }
               });
           }


           $("#btnGameUpdate").click(function(){
               if("${sessionScope.userid}" == ""){
                   if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                       location.href= "${path}/member/member_login.do";
                       return;
                   }
               }else{
                   document.updateViewForm.submit();
               }

           });
       });


       <%--캐러셀관련--%>

       $('.slide-1').on('click', function() {
           $('.slide-container').css('transform', 'translateX(0%)');
       });

       $('.slide-2').on('click', function() {
           $('.slide-container').css('transform', 'translateX(-33.333%');
       });

       $('.slide-3').on('click', function() {
           $('.slide-container').css('transform', 'translateX(-66.666%');
       });

       var item = 1;

       $('.next_div').on('click', function(){
           if (item == 1) {
               $('.slide-container').css('transform', 'translateX(-33.333%');
               item += 1;
           }
           else if (item == 2){
               $('.slide-container').css('transform', 'translateX(-66.666%');
               item += 1;
           }else if (item == 3){
               $('.slide-container').css('transform', 'translateX(0%)');
               item = 1;
           }
       })

       $('.before_div').on('click', function(){
           if (item == 3) {
               $('.slide-container').css('transform', 'translateX(-33.333%');
               item -= 1;
           }
           else if (item == 2){
               $('.slide-container').css('transform', 'translateX(0%)');
               item -= 1;
           }

       })

       /*모달관련*/
       $(function(){
           $("#confirm").click(function(){
               modalClose(); //모달 닫기 함수 호출

               //컨펌 이벤트 처리
           });
           $("#myStars").click(function(){
               //로그인한 회원인지 확인
               if("${sessionScope.userid}" == ""){
                   if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                       location.href= "${path}/member/member_login.do";
                       return;
                   }
               }

               else{

                   //데이터 채워주기
                   $.ajax({
                       type: "get",
                       url : "${path}/gameRating/getUserRating.do",
                       data : {
                           "gnum": "${map.dto.gnum}"
                       },
                       success: function(result){
                           if(result.rating!=null){
                               let rating = result.rating;
                               let weight = result.weight;
                               let p1 = result.participant1;
                               let p2 = result.participant2;
                               let p3 = result.participant3;
                               let p4 = result.participant4;
                               let p5 = result.participant5;
                               let rating_comment = result.rating_comment;

                               $("input[name='rating']").val(rating);
                               $("#myRating").text(rating);
                               let ratingStar = $(".ratingStar");
                               $.each(ratingStar, function () {
                                   if ($(this).data('value') <= rating) {
                                       $(this).css('opacity', 100);
                                   }
                                   else{
                                       $(this).css('opacity', 0);
                                   }
                               });

                               $("input[name='weight']").val(weight);
                               $("#myWeight").text(weight);
                               let weightStar = $(".weightStar");
                               $.each(weightStar, function () {
                                   if ($(this).data('value') <= weight) {
                                       $(this).css('opacity', 100);
                                   }
                                   else{
                                       $(this).css('opacity', 0);
                                   }
                               });

                               if(p1!=null && p1!=''){
                                   $("input[name='participant1']").prop("checked", false);
                                   $("input[name='participant1'][value='" + p1 + "']").prop("checked", true);
                               }

                               if(p2!=null && p2!=''){
                                   $("input[name='participant2']").prop("checked", false);
                                   $("input[name='participant2'][value='" + p2 + "']").prop("checked", true);
                               }

                               if(p3!=null && p3!=''){
                                   $("input[name='participant3']").prop("checked", false);
                                   $("input[name='participant3'][value='" + p3 + "']").prop("checked", true);
                               }

                               if(p4!=null && p4!=''){
                                   $("input[name='participant4']").prop("checked", false);
                                   $("input[name='participant4'][value='" + p4 + "']").prop("checked", true);
                               }

                               if(p5!=null && p5!=''){
                                   $("input[name='participant5']").prop("checked", false);
                                   $("input[name='participant5'][value='" + p5 + "']").prop("checked", true);
                               }

                               $("textarea[name='rating_comment']").val(rating_comment);
                               $("input[name='type']").val("update");
                           }


                           //처음 입력하는 경우 -- 초기화
                           else{
                               $("input[name='rating']").val(3);
                               $("#myRating").text(3);
                               let ratingStar = $(".ratingStar");
                               $.each(ratingStar, function () {
                                   if ($(this).data('value') <= 3) {
                                       $(this).css('opacity', 100);
                                   }
                                   else{
                                       $(this).css('opacity', 0);
                                   }
                               });

                               $("input[name='weight']").val("");
                               let weightStar = $(".weightStar");
                               weightStar.css('opacity', 0);

                               $("input[name='participant1'][value='']").prop("checked", true);
                               $("input[name='participant2'][value='']").prop("checked", true);
                               $("input[name='participant3'][value='']").prop("checked", true);
                               $("input[name='participant4'][value='']").prop("checked", true);
                               $("input[name='participant5'][value='']").prop("checked", true);
                               $("textarea[name='rating_comment']").val("");

                           }

                           //모달창 스크롤 맨 위로 올려줘야 함 추가할것
                           document.body.style.overflowY = "hidden";
                           $("#popup").css('display','flex').hide().fadeIn();
                           //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과

                       },
                       error: function(e){
                           if(e.status==999){
                               if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                                   location.href= "${path}/member/member_login.do";
                                   return;
                               }
                           }
                           else{
                               alert("요청한 작업 처리 중 에러가 발생했습니다.");
                           }
                       }
                   });

               }

           });
           $("#close").click(function(){
               //정말 닫을건지 확인하기
               modalClose(); //모달 닫기 함수 호출
           });
       });

        function modalClose(){
            $("#popup").fadeOut(); //페이드아웃 효과
            document.body.style.overflowY = "auto";
        }


        //구글차트 생성
        function drawChart(){

            let jsonData1 =
                $.ajax({
                    url : "${path}/gameRating/getRatingJsonData.do",
                    data : {
                        "gnum": "${map.dto.gnum}"
                    },
                    dataType : "json",
                    async: false}).responseText;


            let jsonData2;
            let weightTot;

            $.ajax({
                    url : "${path}/gameRating/getWeightJsonData.do",
                    data : {
                        "gnum": "${map.dto.gnum}"
                    },
                    dataType : "json",
                    async: false,
                    success: function(result){
                        jsonData2 = JSON.stringify(result.data);
                        weightTot = result.tot.count;
                    }
            });


            let jsonData3 = $.ajax({
                url : "${path}/gameRating/getPlayerJsonData.do",
                data : {
                    "gnum": "${map.dto.gnum}"
                },
                dataType : "json",
                async: false,
            }).responseText;


            var data1 = new google.visualization.DataTable(jsonData1);
            var data2 = new google.visualization.DataTable(jsonData2);
            var data3 = new google.visualization.DataTable(jsonData3);
            var chart1 = new google.visualization.ColumnChart(
                document.getElementById("ratingChartDiv"));
            var chart2 = new google.visualization.ColumnChart(
                document.getElementById("weightChartDiv"));
            var chart3 = new google.visualization.ColumnChart(
                document.getElementById("playerChartDiv"));


            var opt = {
                width: 780, height: 200,
                vAxis: {
                    gridlines: {
                        count: 0
                    },
                    textPosition: 'none'
                },
                series: {
                    0: {color: '#1432B1'}
                }
            };

            var opt2 = {
                width: 780, height: 200,
                vAxis: {
                    gridlines: {
                        count: 0
                    },
                    textPosition: 'none'
                },
                series: {
                    0: { color: '#FFC61A' },
                    1: { color: '#FFE699' },
                    2: { color: '#D9D9D9' }
                }
            };


            $("#weightPeopleCount").text(weightTot);
            chart1.draw(data1, opt);
            chart2.draw(data2, opt);
            chart3.draw(data3, opt2);

        }


       function likeIt(userid){
           let review = $("div[data-writer=" + userid + "]");
           let likeItDiv = review.find("div[class='likeItDiv']");
           let type = likeItDiv.data("like");
           likeCount = Number(review.find("span[class='likeCount']").text());

           if("${sessionScope.userid}"==null || "${sessionScope.userid}"==''){
               if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                   location.href= "${path}/member/member_login.do";
               }
               return;
           }

           if(type == 'n'){
               $.ajax({
                   type: "get",
                   url : "${path}/gameRating/likeIt.do",
                   data : {
                       "gnum": "${map.dto.gnum}",
                       "writer_id": userid
                   },
                   success: function(result){
                       if(result > 0){
                           review.find("span[class='likeCount']").text(likeCount+1);
                           likeItDiv.data("like", "y");
                           likeItDiv.find("img").prop("src", "${path}/images/game/pink_heart.png");
                       }
                       else alert("요청한 작업 처리 중 에러가 발생하였습니다.");
                   }
               });
           }

           else if(type == 'y'){
               $.ajax({
                   type: "get",
                   url : "${path}/gameRating/unLikeIt.do",
                   data : {
                       "gnum": "${map.dto.gnum}",
                       "writer_id": userid
                   },
                   success: function(result){
                       if(result > 0){
                           review.find("span[class='likeCount']").text(likeCount-1);
                           likeItDiv.data("like", "n");
                           likeItDiv.find("img").prop("src", "${path}/images/game/empty_heart.png");
                       }
                       else alert("요청한 작업 처리 중 에러가 발생하였습니다.");
                   }
               });
           }


       }

   </script>



<%-- 모달의 내용관련  --%>
   <script>

       let rValue = "";
       let wValue = "";

       $(function(){

           $(".ratingStar").mouseover(function(){

               rValue = $("input[name='rating']").val();

               let stars = $(".ratingStar");
               let rStar = $(this).data('value');

               $.each(stars, function(){

                   if($(this).data('value') > rStar){
                       $(this).css('opacity', 0);
                   }
                   else{
                       $(this).css('opacity', 100);
                   }
               });
           });


           $(".weightStar").mouseover(function(){

               wValue = $("input[name='weight']").val();

               let stars = $(".weightStar");
               let wStar = $(this).data('value');

               $.each(stars, function(){
                   if($(this).data('value') > wStar){
                       $(this).css('opacity', 0);
                   }
                   else{
                       $(this).css('opacity', 100);
                   }
               });
           });


           $(".ratingStar").click(function() {
               let stars = $(".ratingStar");
               let rStar = $(this).data('value');

               $.each(stars, function () {
                   if ($(this).data('value') > rStar) {
                       $(this).css('opacity', 0);
                   } else {
                       $(this).css('opacity', 100);
                   }

               });

               $("input[name='rating']").val(rStar);
               rValue = rStar;
               $("#myRating").text(rStar);

           });

           $(".weightStar").click(function() {
               let stars = $(".weightStar");
               let wStar = $(this).data('value');

               $.each(stars, function () {
                   if ($(this).data('value') > wStar) {
                       $(this).css('opacity', 0);
                   } else {
                       $(this).css('opacity', 100);
                   }

               });

               if(wStar == 0) wStar = "";
               $("input[name='weight']").val(wStar);
               wValue = wStar;
               $("#myWeight").text(wStar);

           });



           $(".ratingStar").mouseout(function() {
               let stars = $(".ratingStar");

               $.each(stars, function () {
                   if ($(this).data('value') > rValue) {
                       $(this).css('opacity', 0);
                   } else {
                       $(this).css('opacity', 100);
                   }
               });
           });


           $(".weightStar").mouseout(function() {
               let stars = $(".weightStar");

               $.each(stars, function () {
                   if ($(this).data('value') > wValue) {
                       $(this).css('opacity', 0);
                   } else {
                       $(this).css('opacity', 100);
                   }
               });
           });



       });


       function deleteRating(){

           if(confirm("평가를 삭제하시겠습니까?")){
               location.href="${path}/gameRating/delete.do?gnum=" + "${map.dto.gnum}";
           }


       }


       function submitRating(){

           star = $("input[name='rating']").val();
           star = star.trim();
           $("input[name='rating]").val(star);
           if(star == null || star == '' || isNaN(star) || star < 0.5){
               alert("평가를 제출하려면 반드시 별점을 입력해야 합니다. 다시 시도해주세요.");
               return;
           }

           else{

               //평가 제출
               let ratingForm = $("form[name='ratingForm']");

               let url = "${path}/gameRating/add.do";
               if($("input[name='type']").val() == 'update'){
                   url = "${path}/gameRating/update.do";
               }

               $.ajax({
                   type : "post",
                   url : url,
                   data : ratingForm.serialize(),
                   success: function(response){
                       if(response == 'success'){
                    	   
                    	   //성공했으면 닫아주고 새로고침
                    	   alert('성공적으로 평가가 반영되었습니다.');
                    	   modalClose();
                    	   location.reload();
                    	   
                       }
                       else alert("요청한 작업 처리 중 에러가 발생했습니다.");
                   },
                   error: function(){
                       alert("요청한 작업 처리 중 에러가 발생했습니다.");
                   }
               });

           }
       }

       function cancelRating(){
           modalClose();
       }


   </script>

    </body>
    
</html>