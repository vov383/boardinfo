<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>BOARDINFO</title>
    <%@ include file="js/header.jsp" %>
</head>

<body>

<header>
    <%@include file="top.jsp" %>
</header>

<main>
    <div id="contents">
        <div id="contentsHeader">
            <h2>통합검색</h2>
        </div>

        <div id="contentsLocation">
            ${gameKeyword}에 대한 검색결과
        </div>
        <div id="contentsMain">
            <h4>게임명</h4>
            <c:set var="map" value="${gameMap}" />
            <c:import url="../game/game_list_moduleNP.jsp" charEncoding="UTF-8" />
        </div>



    </div>
</main>

<footer>
    <%@include file="footer.jsp" %>
</footer>

</body>

</html>