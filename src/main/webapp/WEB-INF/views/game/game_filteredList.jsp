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
    <link rel="stylesheet" href="${path}/include/css/style_search.css">
    <style>
        .totalSearchUl ul li{
            width: calc((100%/4) - 2px);
        }
        .hover_span{
            cursor: pointer;
        }

        .hover_span:hover {
            background-color: rgba(0,0,0,.1);
        }
    </style>
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
                    <span>주간 랭킹</span>
                </c:when>
                <c:when test="${map.sort != null and 'month'.equalsIgnoreCase(sort)}">
                    <span>월간 랭킹</span>
                </c:when>
                <c:when test="${map.sort != null and 'newbie'.equalsIgnoreCase(sort)}">
                    <span>신규등록</span>
                </c:when>
                <c:when test="${map.sort != null and 'vcnt'.equalsIgnoreCase(sort)}">
                    <span>조회수 랭킹</span>
                </c:when>

            </c:choose>

            <span class="hover_span" onclick="goInsert()" style="float: right">게임등록</span>

        </div>
        <div id="contentsMain">

            <div>
                <span>
                    <h1> ${map.filter}   :   ${map.list[0].nameStr} ( 총 ${map.count} 개의 게임 )</h1>
                </span>
            </div>


            <div class="totalSearchUl">
                <ul>
                    <li<c:if test="${sort eq 'week'}"> class="selected" </c:if>>
                        <a href="${path}/game/partrank/week?filter=${map.filter}&num=${map.num}">주간</a>
                    </li>
                    <li<c:if test="${sort eq 'month'}"> class="selected" </c:if>>
                        <a href="${path}/game/partrank/month?filter=${map.filter}&num=${map.num}">월간</a>
                    </li>
                    <li<c:if test="${sort eq 'newbie'}"> class="selected" </c:if>>
                        <a href="${path}/game/partrank/newbie?filter=${map.filter}&num=${map.num}">신규</a>
                    </li>
                    <li<c:if test="${sort eq 'vcnt'}"> class="selected" </c:if>>
                        <a href="${path}/game/partrank/vcnt?filter=${map.filter}&num=${map.num}">조회수</a>
                    </li>
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

<script>
    function goInsert() {
        if("${sessionScope.userid}" == ""){
            if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                location.href= "${path}/member/member_login.do";
                return;
            }
        }else{
            location.href= "${path}/game/write.do";
        }
    }
</script>

</body>

</html>