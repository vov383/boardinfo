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
        <c:choose>
            <c:when test="${map.gameKeyword eq 'none'}">
                <div id="contentsHeader">
                    <h2>${map.filter} 목록</h2>
                </div>
                <div id="contentsLocation">
                    <span>홈</span>&gt
                    <span>${map.filter}목록 (${map.count})</span>

                    <a href="${path}/game/write.do" style="float: right">게임등록</a>
                </div>
            </c:when>
            <c:otherwise>
                <div id="contentsHeader">
                    <h2>통합검색</h2>
                </div>

                <div id="contentsLocation">
                    <strong>${map.gameKeyword}</strong>에 대한 검색결과
                </div>
            </c:otherwise>
        </c:choose>

        <div id="contentsMain">
            <div>
                <c:choose>
                    <c:when test="${not empty map.alist or not empty map.dlist or not empty map.plist}">
                        <c:import url="game_list_moduleFilter.jsp" charEncoding="UTF-8" />
                    </c:when>
                    <c:otherwise>
                        검색 결과가 없습니다.
                    </c:otherwise>
                </c:choose>


            </div>
        </div>

    </div>


</main>

<footer>
    <%@include file="../include/footer.jsp" %>
</footer>


</body>

</html>