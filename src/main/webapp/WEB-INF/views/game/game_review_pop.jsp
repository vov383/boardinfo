<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="../include/js/header.jsp" %>
    <title>게임 리뷰 작성</title>


    <style>

        * {
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 15px;
        }

        html, body{
            margin: 0 0;
            padding: 0 0;
            min-height: 100%;
        }

        div, input, span{
            box-sizing: border-box;
        }


        #bigFrame{
            width: 650px;
            height: 850px;
            border: 1px solid black;
            padding: 60px;
            display: flex;
            flex-direction: column;
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
            width: 60px;
        }

        .halfStar{
            position: absolute;
            width: 30px;
            opacity: 0;
            z-index: 2;
            -webkit-user-drag: none;
        }

        .fullStar{
            position: absolute;
            width: 60px;
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
        }

        #cancelBtn{
            background-color: white;
            border: 1px solid black;
        }

    </style>


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



    </script>


</head>
<div id="bigFrame">
    <div class="labelAndStars">
        <span id="labelR">내 평점 (필수)</span>
        <div>
          <span class="star">
              <img src="../include/half_star.png" data-value="0.5" class="ratingStar halfStar">
              <img src="../include/yellow_star.png" data-value="1" class="ratingStar fullStar" style="opacity: 100">
              <img src="../include/empty_star.png">
          </span>
            <span  class="star">
              <img src="../include/half_star.png" data-value="1.5" class="ratingStar halfStar">
              <img src="../include/yellow_star.png" data-value="2" class="ratingStar fullStar" style="opacity: 100">
              <img src="../include/empty_star.png">
          </span>
            <span  class="star">
              <img src="../include/half_star.png" data-value="2.5" class="ratingStar halfStar">
              <img src="../include/yellow_star.png" data-value="3" class="ratingStar fullStar" style="opacity: 100">
              <img src="../include/empty_star.png">
          </span>
            <span  class="star">
              <img src="../include/half_star.png" data-value="3.5" class="ratingStar halfStar">
              <img src="../include/yellow_star.png" data-value="4" class="ratingStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <span  class="star">
              <img src="../include/half_star.png" data-value="4.5" class="ratingStar halfStar">
              <img src="../include/yellow_star.png" data-value="5" class="ratingStar fullStar">
              <img src="../include/empty_star.png">
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
              <img src="../include/half_star_b.png" data-value="0.5" class="weightStar halfStar">
              <img src="../include/blue_star.png" data-value="1" class="weightStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <span class="star">
              <img src="../include/half_star_b.png" data-value="1.5" class="weightStar halfStar">
              <img src="../include/blue_star.png" data-value="2" class="weightStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <span class="star">
              <img src="../include/half_star_b.png" data-value="2.5" class="weightStar halfStar">
              <img src="../include/blue_star.png" data-value="3" class="weightStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <span class="star">
              <img src="../include/half_star_b.png" data-value="3.5" class="weightStar halfStar">
              <img src="../include/blue_star.png" data-value="4" class="weightStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <span class="star">
              <img src="../include/half_star_b.png" data-value="4.5" class="weightStar halfStar">
              <img src="../include/blue_star.png" data-value="5" class="weightStar fullStar">
              <img src="../include/empty_star.png">
          </span>
            <input type="hidden" name="weight" value="">
        </div>
    </div>
    <div class="columnFlex">
        <span>추천인원 (선택)</span>
        <table id="ratingPeopleTable">
            <tr><th></th><th>베스트</th><th>추천</th><th>비추천</th><th>응답없음</th></tr>
            <tr>
                <td>1</td>
                <td><input name="participate1" value="1" type="radio"></td>
                <td><input name="participate1" value="2" type="radio"></td>
                <td><input name="participate1" value="3" type="radio"></td>
                <td><input name="participate1" type="radio" checked></td>
            </tr>
            <tr>
                <td>2</td>
                <td><input name="participate2" value="1" type="radio"></td>
                <td><input name="participate2" value="2" type="radio"></td>
                <td><input name="participate2" value="3" type="radio"></td>
                <td><input name="participate2" type="radio" checked></td>
            </tr>
            <tr>
                <td>3</td>
                <td><input name="participate3" value="1" type="radio"></td>
                <td><input name="participate3" value="2" type="radio"></td>
                <td><input name="participate3" value="3" type="radio"></td>
                <td><input name="participate3" type="radio" checked></td>
            </tr>
            <tr>
                <td>4</td>
                <td><input name="participate4" value="1" type="radio"></td>
                <td><input name="participate4" value="2" type="radio"></td>
                <td><input name="participate4" value="3" type="radio"></td>
                <td><input name="participate4" type="radio" checked></td>
            </tr>
            <tr>
                <td>5인 이상</td>
                <td><input name="participate5" value="1" type="radio"></td>
                <td><input name="participate5" value="2" type="radio"></td>
                <td><input name="participate5" value="3" type="radio"></td>
                <td><input name="participate5" type="radio" checked></td>
            </tr>
            </tr>
        </table>
    </div>
    <div class="columnFlex">
        <span>코멘트 (선택)</span>
        <textarea name="comment"></textarea>
    </div>
    <div><button type="button" id="submitBtn">작성 완료</button><button type="button" id="cancelBtn">작성 취소</button></div>

</div>
</body>
</html>
