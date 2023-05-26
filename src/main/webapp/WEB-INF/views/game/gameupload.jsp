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

    <%--파일을 업로드할 영역--%>
	<div class="fileDrop" style="width: 100% height: 200px"></div>

    <%--파일을 출력할 영역--%>
   <div class="uploadedList"></div>

           </div>
       </div>
   </main>

   <footer>
       <%@include file="../include/footer.jsp" %>
   </footer>

    </body>
    
</html>