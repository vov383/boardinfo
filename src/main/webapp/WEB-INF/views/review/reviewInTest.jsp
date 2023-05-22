<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Review In Test</title>
        <%@ include file="../include/js/header.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript">

            // $(document).ready(function() {
            //     //새 게임 등록 버튼클릭
            //     $("#btnSave").click(function () {
            //         //null값확인, 자료형확인필요함 -> 정규식응용
            //         alert("asdsadasd");
            //         document.testform.submit();
            //     });
            // });

            function btnSaveClick() {
                alert("asdsadasd");
                        document.testform.submit();
            }
        </script>
   </head>

   <body>

   <h3> Review In Test  11111 </h3>

   <form name="testform" method="post" action="${path}/review/reviewInTestInsertPage.do">

       <p>ID : <input type="text" name="test1"></p>

       <button type="button" id="btnsave" onclick="btnSaveClick()">값 보내기</button>

   </form>


   <%--<form method="POST">

       <form method="get" action="RadioServletEx">
           <label for="categoryName">카테고리</label>
           <input type="radio" id="gameId" name="gameName" value="game" checked="checked">게임
           <input type="radio" id="gatheringId" name="gatheringName" value="gathering">모임
       </form>

           <p>게임 : <input type="text" name="gameId" /></p>
           <p>제목 : <input type="text" name="title" /></p>
           <p>재미도 : <input type="text" name="funScore" /></p>
           <p>리뷰 점수 : <input type="text" name="reviewScore" /></p>
           <p>난이도 : <input type="text" name="gameScore" /></p>
           <p>내용 : <input type="text" name="reviewDetail" /></p>
           <p>좋아요 : <radio type="text" name="good" /></p>
           <p><input type="submit" value="저장" />

   </form>--%>


   </body>
    
</html>