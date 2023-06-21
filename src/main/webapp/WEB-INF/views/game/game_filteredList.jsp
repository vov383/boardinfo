<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>BOARDINFO</title>
    <%@ include file="../include/js/header.jsp"%>
</head>

<header>
    <%@include file="../include/top.jsp" %>
</header>

<main>
    <div id="contents">
        <div id="contentsHeader">
            <h2>${map.filter} 별 게임 목록</h2>
        </div>
        <div id="contentsLocation">
            <span>홈</span>&gt
            <span>게임목록</span>&gt
            <span>${map.filter} 별</span>&gt

            <c:choose>
                <c:when test="${map.sort != null and 'week'.equalsIgnoreCase(sort)}">
                    <span>보드인포 랭킹순</span>
                </c:when>
                <c:when test="${map.sort != null and 'newbie'.equalsIgnoreCase(sort)}">
                    <span>신규등록순</span>
                </c:when>
                <c:when test="${map.sort != null and 'rate'.equalsIgnoreCase(sort)}">
                    <span>평점 랭킹순</span>
                </c:when>
                <c:when test="${map.sort != null and 'vcnt'.equalsIgnoreCase(sort)}">
                    <span>조회수 랭킹순</span>
                </c:when>

            </c:choose>

            <a href="${path}/game/write.do" style="float: right">게임등록</a>

        </div>
        <div id="contentsMain">

            <div>
                <span>
                    <h1> ${map.filter}   :   ${map.list[0].nameStr} ( 총 ${map.count} 개의 게임 )</h1>
                </span>
            </div>


            <div class="game_rank_div">
                <ul>
                    <li><a href="${path}/game/partrank/week?filter=${map.filter}&num=${map.num}">주간</a></li>
                    <li><a href="${path}/game/partrank/rate?filter=${map.filter}&num=${map.num}">평점</a></li>
                    <li><a href="${path}/game/partrank/newbie?filter=${map.filter}&num=${map.num}">신규</a></li>
                    <li><a href="${path}/game/partrank/vcnt?filter=${map.filter}&num=${map.num}">조회수</a></li>
                </ul>
            </div>


            <c:import url="game_list_module.jsp" charEncoding="UTF-8">
                <c:param name="map" value="${map}"/>
                <c:param name="sort" value="${sort}"/>
            </c:import>

        </div>

    </div>


</main>

<footer>
    <%@include file="../include/footer.jsp" %>
</footer>


</body>

</html>