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

    <style>
        #paginationArea{
            display: flex;
            margin: 20px auto 0 auto;
        }

        .pageItem{
            width: 35px;
            height: 35px;
            border-radius: 10px;
            line-height: 35px;
            text-align: center;
            margin: 0 3px;
            font-size: 1.2em;
        }

        .pageItem:hover{
            cursor: pointer;
        }

        .pageItem:not(#curPage):hover{
            background-color: #D9D9D9;
        }

        #curPage{
            border: 2px solid #1432B1;
            color: #1432B1;
            line-height: 31px;
        }
    </style>

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

                        ( 총 ${map.count} 개의 게임 )
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

                    <tfoot>

                    <tr>

                        <td colspan="7" align="center">

                            <div id="paginationArea">
                                <c:if test="${map.pager.curPage > 1}">
                                    <div class="pageItem" onclick="list(1)">&lt&lt</div>
                                </c:if>
                                <c:if test="${map.pager.curPage > 1}">
                                    <div class="pageItem" onclick="list(${map.pager.prevPage})">&lt</div>
                                </c:if>
                                <c:forEach var="num" begin="${map.pager.blockStart}" end="${map.pager.blockEnd}">
                                    <c:choose>
                                        <c:when test="${num == map.pager.curPage}">
                                            <div id="curPage" class="pageItem" onclick="list(${num})">${num}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="pageItem" onclick="list(${num})">${num}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${map.pager.curPage < map.pager.totPage}">
                                    <div class="pageItem" onclick="list(${map.pager.nextPage})">&gt</div>
                                </c:if>
                                <c:if test="${map.pager.curPage < map.pager.totPage}">
                                    <div class="pageItem" onclick="list(${map.pager.totPage})">&gt&gt</div>
                                </c:if>
                            </div>

                        </td>

                    </tr>

                    </tfoot>

                    <tbody>

                    <c:forEach var="row" items="${map.list}">

                        <tr>

                            <td>${row.gnum}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${row.gamephoto_url != null}">
                                        <img alt="저장된 이미지파일이 없음" src="${path}/resources/uploaded_game${row.gamephoto_url}">
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${row.bggnum != null}">
                                                <img class="img_photo" src="${row.bgg_thumbnail}" width="100px" height="100px" border="1px">
                                            </c:when>
                                            <c:otherwise>
                                                이미지를 등록해주세요
                                            </c:otherwise>
                                        </c:choose>

                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${path}/game/view.do?gnum=${row.gnum}">${row.gametitle}<br>(${row.gametitle_eng})</a>
                            </td>
                            <td>${row.release_year}</td>
                            <td>리뷰목록</td><!-- 리뷰와 연동되면 그쪽으로 link -->
                            <td>판매물품</td><!-- 거래와 연동되면 그쪽으로 link -->
                            <td>${row.totalviewcount}</td>

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

<script>
    function list(page) {
        location.href="${path}/game/search.do?filter=${map.filter}&num=${map.num}&curPage="+page;
    }
</script>


</body>

</html>