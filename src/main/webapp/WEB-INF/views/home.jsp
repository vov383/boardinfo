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
<%--        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans">--%>
<%--        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">--%>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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

            #carouselDiv {
                height: 561px;
            }

        </style>
   </head>

   <body>

    <header>
        <%@include file="include/top.jsp" %>
    </header>

    <main>
        <br><br><br><br><br><br>
        <div id="carouselDiv"></div>

	<div align="center">
		<h1><a href="${path}/sample/sample.do" style="color: black;">SAMPLE CLICK</a></h1>
        <br>

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
<%--
        <h1><a href="${path}/review/reviewInsert.do" style="color: black;">Review Insert</a></h1>
        <h1><a href="${path}/review/reviewBlobInsert.do" style="color: black;">Review Blob Test</a></h1>
--%>

    </div>
  <div>
  	<!-- 실제로 서비스되는 디렉토리(배포 디렉토리) 값 가져오기 -->
		<%= application.getRealPath("/resources/ckimg/") %>

		<%= application.getRealPath("/resources/uploaded_image/") %>
  </div>


 
    </main>

    <footer>
       <%@include file="include/footer.jsp" %>
    </footer>

   <script>
       $(function(){
          $.ajax({
              type: "POST",
              url: "${path}/game/gameListMain.do/",
              success:function(result){
                $("#carouselDiv").html(result);
              }
          });
       });
   </script>


    </body>
    
</html>