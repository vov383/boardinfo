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
        
        
        #gameInfoUpper{
        	display: flex;
        	padding: 20px;
        }
        
        
        #gameInfoUpper > div:first-child{
        	padding-right: 45px;
        }
        
        
        #upperRightSide{
        	display: flex;
        	flex-direction: column;
        	background-color: pink;
        	flex-grow: 1;
        	align-items: flex-start;
        }
        
        #titleArea{
        	display: flex;
        	align-items: center;
        	margin-bottom: 10px;
        	
        }
        
        #titleArea h2{
        	font-size: 24px;
        	margin: 0;
        	padding: 0;
        	margin-right: 2px;
        }
        
        
        #titleArea h3{
        	font-size: 20px;
        	margin: 0;
        	padding: 0;
        	margin-right: 10px;
        }
        
        #titleArea span{
        	font-size: 16px;
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
            
            .detail_div a{
            	color: black;
            	cursor: pointer;
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
                width: 300%;
                transition: all 1s;
                transform: translateX(0%);
            }
            .slide-box {
                width: calc(100%/3);
                float: left;
            }
            .slide-box p {
                margin: 0;
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
                background-color:#1432B1;
            /*배경색*/
            /*팝업이 허공에 떠있는 듯한 느낌을 주기 위한 그림자 효과.*/
                box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
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
            }

            ul {
                list-style: none;
                padding: 0;
            }
            ul li {
                cursor: pointer;
            }
            ul li:hover {
                background-color: rgba(0,0,0,.1);
            }

            .before_div, .next_div {
                cursor: pointer;
            }
            .before_div:hover, .next_div:hover {
                background-color: rgba(0,0,0,.1);
            }

            .next{
                float: right;
            }
            .before, .next {
                margin: 60px 0;
                width: 20px;
                height: 60px;
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
                max-height:60vw;
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
                width: 40px;
            }

            .halfStar{
                position: absolute;
                width: 20px;
                opacity: 0;
                z-index: 2;
                -webkit-user-drag: none;
            }

            .fullStar{
                position: absolute;
                width: 40px;
                opacity: 0;
                z-index: 1;
                -webkit-user-drag: none;
            }

            #hollow{
                opacity: 100%;
                width: 20px;
                height: 100%;
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
                height: 30px;
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
                margin-right: 30px;
                cursor: pointer;
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
            <c:choose>
              <c:when test="${map.dto.gamephoto_url != null}">
               <div>
                 <img class="img_photo" src="${path}/resources/uploaded_game${map.dto.gamephoto_url} " width="250px" height="250px" border="1px">
                 <a href="#">등록된 이미지 보기</a>
               </div>
              </c:when>
             <c:otherwise>
			<div>
              <img class="img_photo" src="${map.bgg_thumbnail}"onerror="this.src='../images/game/no-image-icon.png'"  width="250px" height="250px" border="1px">
               <p>사진출처 : boardgamegeek</p>
            </div>
             </c:otherwise>
            </c:choose>           	

           	<div id="upperRightSide">
           		<div id="titleArea"><h2>${map.dto.gametitle}</h2><h3>(${map.dto.gametitle_eng})</h3><span>${map.dto.release_year}</span></div>
           		<div>
           			<span>
                        <img src="../images/Star3.png" width="40px" style="vertical-align: middle;">
                        <c:choose>
                        	<c:when test="${map.statisticMap!=null}">
		                        <a href="#"><strong>
		                        <fmt:formatNumber value="${map.statisticMap.AVGRATING}" pattern=".0"/>
		                        </strong> (${map.statisticMap.TOT}명)</a>
                        	</c:when>
                        	<c:otherwise>
                        	- (0명)
                        	</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <img src="../images/medal105.png" width="35px" height="35px" style="vertical-align: middle;">
                        <a href="#">이번 주 게임 <strong>[ranking]</strong>위 &nbsp;&nbsp;&nbsp;&gt;</a>
                    </span>
           		</div>
           		
           		<div><span>인원</span><span>${map.dto.players} <a>(베스트 [인원투표값])</a></span></div>
           		<div><span>난이도</span>
	           		<span>
	 	               <c:choose>
	 	               <c:when test="${map.statisticMap!=null}">
	 	               <a><fmt:formatNumber value="${map.statisticMap.AVGWEIGHT}" pattern=".0"/></a>
	 	               </c:when>
	 	               <c:otherwise>
	 	               -
	 	               </c:otherwise>
	 	               </c:choose>
	 	               
	 	                / 5 </span>
           		</div>
           		<div><span>연령</span><span>${map.dto.ages}세</span></div>
           		<div><span>시간</span><span>${map.dto.playtime}</span></div>
           		<div><span id="modal-open">내 평가</span><span>/???/</span><span>컬렉션 추가</span></div>
           		</div>
           	</div>
           		

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
                        <div class="before_div" style="width: 5%; float: left;">
                            <img src="../images/chevron-compact-left.svg" class="before" />
                        </div>

                        <div style="overflow: hidden; width: 90%; float: left;">
                            <div class="slide-container">
                                <div class="slide-box">
                                    <div>
                                        <p>평균 평점 [평점]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <div style="border: 1px solid; height: 100px; width: 100%;">평점그래프</div>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <p>추천 인원수 [인원]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <div style="border: 1px solid; height: 100px; width: 100%;">인원그래프</div>
                                </div>
                                <div class="slide-box">
                                    <div>
                                        <p>평균 난이도 [난이도]</p>
                                        <p>전체 평가 수 [평가인원 수]</p>
                                    </div>
                                    <div style="border: 1px solid; height: 100px; width: 100%;">난이도그래프</div>
                                </div>
                            </div>
                        </div>

                        <div class="next_div" style="width: 5%; float: right;">
                            <img src="../images/chevron-compact-right.svg" class="next" />
                        </div>


                    </div>

                </div>

                <hr style="clear: both;">

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


               <div class="popup-body">

                           <!--여기부터 모달내용-->
                           <form name="ratingForm" id="bigFrame">
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
                               <div><button type="button" id="submitBtn" onclick="submitRating()">작성 완료</button>
                                   <button type="button" id="cancelBtn" onclick="cancelRating()">작성 취소</button>
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
           $("#modal-open").click(function(){

               //로그인한 회원인지 확인
               if("${sessionScope.userid}" == ""){
                   if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                       location.href= "${path}/member/member_login.do";
                       return;
                   }
               }

               else{
                   $("#popup").css('display','flex').hide().fadeIn();
                   //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
               }

           });
           $("#close").click(function(){
               modalClose(); //모달 닫기 함수 호출
           });
       });

        function modalClose(){
            $("#popup").fadeOut(); //페이드아웃 효과
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

               $("input[name='weight']").val(wStar);
               wValue = wStar;

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

               $.ajax({
                   type : "post",
                   url : "${path}/gameRating/add.do",
                   data : ratingForm.serialize(),
                   success: function(response){
                       if(response == 'success'){
                    	   
                    	   //성공했으면 닫아주고 새로고침
                    	   alert('성공적으로 평가가 반영되었습니다.');
                    	   modalClose();
                    	   location.reload();
                    	   
                    	   
                       }
                       else alert("에러가 발생했습니다.");
                   },
                   error: function(){
                       alert("에러가 발생했습니다.");
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