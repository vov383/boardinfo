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
    <link rel="stylesheet" href="${path}/include/js/style_game.css">

</head>

<header>
    <%@include file="../include/top.jsp" %>
</header>

<main>
    <div id="contents">
        <div id="contentsHeader">
            <h2>게임목록</h2>
        </div>
        <div id="contentsLocation">
            <span>홈</span>&gt
            <span>게임목록</span>&gt
            <span>${map.filter} 별</span>


            <a href="${path}/game/write.do" style="float: right">게임등록</a>
        </div>
        <div id="contentsMain">
            <div>
                <span>
                    <h1>
                        ${map.filter}
                    :
                        <c:choose>
                            <c:when test="${map.filter=='artist'}">${map.list[0].artist}</c:when>
                            <c:when test="${map.filter=='gamecategory'}">${map.list[0].gamecategory}</c:when>
                            <c:when test="${map.filter=='designer'}">${map.list[0].designer}</c:when>
                            <c:when test="${map.filter=='mechanic'}">${map.list[0].mechanic}</c:when>
                            <c:when test="${map.filter=='publisher'}">${map.list[0].publisher}</c:when>
                        </c:choose>
                    </h1>
                </span>
            </div>

            <div class="tableDiv">
                <table>

                    <colgroup>
                        <col width="9%"/>
                        <col width="15%"/>
                        <col width="35%"/>
                        <col width="9%"/>
                        <col width="9%"/>
                        <col width="9%"/>
                        <col width="9%"/>
                    </colgroup>

                    <thead>

                    <tr>

                        <th>Number</th><!-- 리뷰와 연동되면 Rank -->
                        <th>photo</th>
                        <th>title</th>
                        <th>release year</th>
                        <th>review</th>
                        <th>shop</th>
                        <th>viewcount</th>

                    </tr>

                    </thead>

                    <tbody>

                    <c:forEach var="row" items="${map.list}">

                        <tr>

                            <td>${row.gnum}</td><!-- 리뷰와 연동되면 순위 ${row.g_rank} -->
                            <td>
                                <c:choose>
                                    <c:when test="${row.gamephoto_url != null}">
                                        <img src="${path}/resources/uploaded_game${row.gamephoto_url}">
                                    </c:when>
                                    <c:otherwise>
                                        빈 이미지 추가요망
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${path}/game/view.do?gnum=${row.gnum}">${row.gametitle}<br>(${row.gametitle_eng})</a>
                            </td>
                            <td>${row.release_year}</td>
                            <td>리뷰목록</td><!-- 리뷰와 연동되면 그쪽으로 link -->
                            <td>판매물품</td><!-- 거래와 연동되면 그쪽으로 link -->
                            <td>${row.viewcount}</td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>

        </div>

    </div>

</main>

<footer>
    <%@include file="../include/footer.jsp" %>
</footer>



</body>

</html>