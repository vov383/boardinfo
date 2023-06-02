<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>BOARDINFO</title>
        <%@ include file="include/js/header.jsp" %>


        <style>
            /*모달 내용 관련*/
            #bigFrame{
                width: 550px;
                padding: 60px;
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
        <%@include file="include/top.jsp" %>
    </header>

    <main>

        <br><br><br><br><br>

	<div align="center">
		<h1><a href="${path}/sample/sample.do" style="color: black;">SAMPLE CLICK</a></h1>
        <br>
        <h1><a href="${path}/game/gamelist.do" style="color: black;">game list</a></h1>
        <br>
        <h1><a href="${path}/tboard/list.do" style="color: black;">중고거래 게시판</a></h1>
        <h1><a href="${path}/member/member_list.do" style="color: black;">인터셉터 확인</a></h1>
        <br>
        <h1><a href="${path}/chat/goChat.do" style="color: black;">sjTest</a></h1>
        <h1><a href="${path}/gathering/list.do" style="color: black;">모임리스트</a></h1>
        <h1><a href="${path}/gathering/add.do" style="color: black;">모임만들기</a></h1>
        <h1><a href="${path}/mongo/insert.do" style="color: black;">테스트insert</a></h1>
        
        <br>
        <h1><a href="${path}/review/reviewlist.do" style="color: black;">Review List</a></h1>
        <h1><a href="${path}/review/reviewInsert.do" style="color: black;">Review Insert</a></h1>
        <h1><a href="${path}/review/reviewBlobInsert.do" style="color: black;">Review Blob Test</a></h1>

    </div>
  <div>
  	<!-- 실제로 서비스되는 디렉토리(배포 디렉토리) 값 가져오기 -->
		<%= application.getRealPath("/resources/ckimg/") %>

		<%= application.getRealPath("/resources/uploaded_image/") %>
  </div>



        <form name="ratingForm" id="bigFrame">
            <input type="hidden" name="gnum" value="1">
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
                    let queryString = $("form[name='ratingForm']").serialize();


                    $.ajax({
                        type: "get",
                        url : "${path}/gameRating/add.do",
                        data : queryString,
                        success: function(response){
                            if(response == 'success'){
                                //성공했으면 폼 비워주고 닫아주기
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


 
    </main>

    <footer>
       <%@include file="include/footer.jsp" %>
    </footer>


    </body>
    
</html>