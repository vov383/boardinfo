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

        <style>
            table tr {
                border: none;
                background-color: white;
            }

            table tr td {
                border: none;
                background-color: white;
            }
            tr:nth-child(even) td {
                background-color: white;
            }
            td:first-child {
                border: none;
            }

            .td_btn {
                cursor: pointer;
            }
            .td_btn:hover {
                background-color: #9fcdff;
                color: #0b0b0b;
            }
            .detail_div {
                height: 300px;
                text-align: left;
                padding: 20px;
            }
            .detail_div > span {
                margin-right: 50px;
            }
            .detail_div > p {
                margin: 0;
            }
            .game_detail_title_div{
                margin: 10px 0px;
            }
            .game_detail_title {
                display: inline;
                font-size: 20pt;
                font-weight: bold;
            }
            .game_detail_subtitle {
                display: inline;
                font-size: 16pt;
            }
            .game_detail_filter_div {
                clear: both;
            }
            .game_detail_filter {
                width: 10%;
                float: left;
            }
            .game_detail_filtered_list {
                width: 90%;
                float: right;
            }
            .game_detail_filtered_list a {
                display: inline-block;
            }
/*캐러셀*/
            .slide-container {
                width: 300vw;
                transition: all 1s;
                transform: translateX(-100vw);
            }
            .slide-box {
                width: 100vw;
                float: left;
            }
            .slide-box p {
                width: 100%;
            }

            /*모달*/
            .popup-wrap{
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
                max-width:800px;
            /*팝업의 최대 크기지정*/
                border-radius:10px;
            /*둥글둥글한 디자인을 위해 각을 없앱니다.*/
                overflow:hidden;
            /*각을 없앴을 때 내부 영역이 튀어나오는걸 방지*/
                background-color:#1432B1;
            /*배경색*/
            /*팝업이 허공에 떠있는 듯한 느낌을 주기 위한 그림자 효과.*/
                box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
            }

            .popup-head{
                width:100%;
            /*부모요소를 따라가기 때문에 굳이 가로값을 주지 않아도 되지만 일부 ie에서 인식 못하는 문제가 있음*/
                height:50px;
            /*헤드 영역 높이*/
                display:flex;
            /*로고 이미지나 텍스트를 중앙 정렬하기 위한 flex 및 정렬*/
                align-items:center;
                justify-content:center;
            }

            .head-title {
                color: white;
            }

            .popup-body{
            /*몸통*/
            width:100%;
                background-color:#ffffff;
            /*컨텐츠 영역의 배경색*/
            }
            .body-content{
            /*몸통 내부 컨텐츠 영역*/
                width:100%;
                padding:30px;
            /*좌우에 내용이 붙으면 보기 안좋기 때문에 간격 띄움*/
            }
            .body-titlebox{
            /*컨텐츠 타이틀 영역*/
                text-align:center;
            /*제목 중앙정렬*/
                width:100%;
                height:40px;
                margin-bottom:10px;
            /*내용과 간격 조정*/
            }
            .body-contentbox{
            /*컨텐츠 내용 영역*/
                word-break:break-word;
            /*단어가 짤리지 않음*/
                overflow-y:auto;
            /*내부요소가 지정한 세로 값보다 클 경우 스크롤 생성*/
                min-height:100px;
            /*최소 높이*/
                max-height:200px;
            /*최대 높이*/
            }

            .popup-foot{
            /*다리*/
                width:100%;
                height:50px;
            }
            .pop-btn{
            /*각각의 버튼*/
                display:inline-flex;
            /*한줄로 나열하기 위한 inline속성과 flex속성 혼합*/
                width:50%;
            /*2개 버튼 각각 50% 영역*/
                height:100%;
            /*50px*/
                justify-content:center;
            /*수평정렬*/
                align-items:center;
            /*수직정렬*/
                float:left;
            /*좌측배치*/
                color:#ffffff;
            /*글자색*/
                cursor:pointer;
            /*마우스 포인터 효과*/
            }
            .pop-btn.confirm{
            /*확인버튼*/
                border-right:1px solid #1432B1;
            /*오른쪽 줄*/
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

        <table>

            <colgroup>
                <col width="26%"/>
                <col width="8%"/>
                <col width="14%"/>
                <col width="14%"/>
                <col width="35%"/>
            </colgroup>

            <tr>
                <td rowspan="7" id="td_photo">
                    <c:choose>
                        <c:when test="${map.dto.gamephoto_url != null}">
                            <img class="img_photo" src="${path}/resources/uploaded_game${map.dto.gamephoto_url} " width="250px" height="250px" border="1px">
                            <div>
                                <a href="#">등록된 이미지 보기</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <img class="img_photo" src="${map.bgg_thumbnail}"onerror="this.src='../images/game/no-image-icon.png'"  width="250px" height="250px" border="1px">
                            <div>
                                <p>사진출처 : boardgamegeek</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td colspan="4"><h2 class="game_detail_title">${map.dto.gametitle}</h2><h3 class="game_detail_subtitle">(${map.dto.gametitle_eng})&nbsp;${map.dto.release_year}</h3></td>
            </tr>

            <tr style="height: 40px;">
                <td colspan="2">
                    <span>
                        <img src="../images/Star3.png" width="35px" height="35px" style="vertical-align: middle;">
                        <a href="#"><strong>[rating]</strong> (참여인원)</a>
                    </span>
                </td>
                <td colspan="2">
                    <span>
                        <img src="../images/medal105.png" width="35px" height="35px" style="vertical-align: middle;">
                        <a href="#">이번 주 게임 <strong>[ranking]</strong>위 &nbsp;&nbsp;&nbsp;&gt;</a>
                    </span>
                </td>
            </tr>

            <tr>
                <td>인원</td>
                <td colspan="3"><span>${map.dto.players} <a>(베스트 [인원투표값])</a></span></td>
            </tr>

            <tr>
                <td>난이도</td>
                <td colspan="3"><span><a>[난이도투표평균값]</a> / 5 </span></td>
            </tr>

            <tr>
                <td>연령</td>
                <td colspan="3"><span>${map.dto.ages}세</span></td>
            </tr>

            <tr>
                <td>시간</td>
                <td colspan="3"><span>${map.dto.playtime}</span></td>
            </tr>

            <tr>
                <td></td>
                <td id="modal-open" class="td_btn">평가 작성하기</td>
                <td class="td_btn">컬렉션에 추가</td>
            </tr>

        </table>

        <hr>

        <div class="detail_div">
            <div class="game_detail_title_div">
                <h3 class="game_detail_subtitle">상세정보</h3>
            </div>
            <div class="game_detail_filter_div">
                <div class="game_detail_filter">카테고리</div>
                <div class="game_detail_filtered_list">
                <c:forEach var="category" items="${map.clist}">
                    <a href="${path}/game/search.do?filter=gamecategory&num=${category.cnum}">${category.gamecategory}</a>
                </c:forEach>
                </div>
            </div>

            <div class="game_detail_filter_div">
                <div class="game_detail_filter">아티스트</div>
                <div class="game_detail_filtered_list">
                <c:forEach var="artist" items="${map.alist}">
                    <a href="${path}/game/search.do?filter=artist&num=${artist.anum}">${artist.artist}</a>
                </c:forEach>
                </div>
            </div>

            <div class="game_detail_filter_div">
                <div class="game_detail_filter">디자이너</div>
                <div class="game_detail_filtered_list">
                <c:forEach var="designer" items="${map.dlist}">
                    <a href="${path}/game/search.do?filter=designer&num=${designer.dnum}">${designer.designer}</a>
                </c:forEach>
                </div>
            </div>

            <div class="game_detail_filter_div">
                <div class="game_detail_filter">게임방식</div>
                <div class="game_detail_filtered_list">
                <c:forEach var="mechanic" items="${map.mlist}">
                    <a href="${path}/game/search.do?filter=mechanic&num=${mechanic.mnum}">${mechanic.mechanic}</a>
                </c:forEach>
                </div>
            </div>

            <div  class="game_detail_filter_div">
                <div class="game_detail_filter">퍼블리셔</div>
                <div class="game_detail_filtered_list">
                <c:forEach var="publisher" items="${map.plist}">
                    <a href="${path}/game/search.do?filter=publisher&num=${publisher.pnum}">${publisher.publisher}</a>
                </c:forEach>
                </div>
            </div>
        </div>

        <hr style="clear: both;">

        <div class="detail_div">
            <div class="game_detail_title_div">
                <h3 class="game_detail_subtitle">보드인의 평가</h3>
            </div>

            <div>
                <div class="game_detail_filter">
                    <ul>
                        <li class="slide-1">평점</li>
                        <li class="slide-2">인원</li>
                        <li class="slide-3">난이도</li>
                    </ul>
                </div>

                <div class="game_detail_filtered_list">

                    <div>
                        <div><button class="before">&lt;</button></div>

                        <div style="overflow: hidden">
                            <div class="slide-container">
                                <div class="slide-box">
                                    <div>
                                        <p>평균 평점 [평점]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <p>평점그래프</p>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <p>추천 인원수 [인원]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <p>인원그래프</p>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <p>평균 난이도 [난이도]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <p>난이도그래프</p>
                                </div>
                            </div>
                        </div>
                        <div><button class="next">&gt;</button></div>


                    </div>

                </div>

                <%--댓글 값 받아와서 list출력--%>
                <div style="clear: both;">
                    댓글댓글
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
               <div class="popup-head">
                   <span class="head-title">글 작성</span>
               </div>

               <div class="popup-body">
                   <div class="body-content">
                       <div class="body-titlebox">
                           <h2>평점</h2>
                       </div>
                       <div class="body-contentbox">
                           <p> 글쓰기 </p>
                       </div>
                   </div>
               </div>
               <div class="popup-foot">
                   <span class="pop-btn confirm" id="confirm">확인</span>
                   <span class="pop-btn close" id="close">창 닫기</span>
               </div>
           </div>
       </div>
   </div>

   <footer>
       <%@include file="../include/footer.jsp" %>
   </footer>

   <script>
<%--캐러셀관련--%>
       $('.slide-1').on('click', function() {
           $('.slide-container').css('transform', 'translateX(0vw)');
       });

       $('.slide-2').on('click', function() {
           $('.slide-container').css('transform', 'translateX(-100vw)');
       });

       $('.slide-3').on('click', function() {
           $('.slide-container').css('transform', 'translateX(-200vw)');
       });

       var item = 2;

       $('.next').on('click', function(){
           if (item == 1) {
               $('.slide-container').css('transform', 'translateX(-100vw)');
               item += 1;
           }
           else if (item == 2){
               $('.slide-container').css('transform', 'translateX(-200vw)');
               item += 1;
           }else if (item == 3){
               $('.slide-container').css('transform', 'translateX(0vw)');
               item = 1;
           }
       })

       $('.before').on('click', function(){
           if (item == 3) {
               $('.slide-container').css('transform', 'translateX(-100vw)');
               item -= 1;
           }
           else if (item == 2){
               $('.slide-container').css('transform', 'translateX(0vw)');
               item -= 1;
           }

       })

       /*모달관련*/
       $(function(){
           $("#confirm").click(function(){
               modalClose(); //모달 닫기 함수 호출

               //컨펌 이벤트 처리
           });
           $("#modal-open").click(function(){
               $("#popup").css('display','flex').hide().fadeIn();
               //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
           });
           $("#close").click(function(){
               modalClose(); //모달 닫기 함수 호출
           });
           function modalClose(){
               $("#popup").fadeOut(); //페이드아웃 효과
           }
       });
   </script>

    </body>
    
</html>