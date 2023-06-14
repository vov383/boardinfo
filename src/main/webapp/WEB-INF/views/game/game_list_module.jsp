<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/js/style_game.css">
<link rel="stylesheet" href="${path}/include/css/pagenation.css">

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

            <th>주간랭킹</th><%--주간조회수랭킹--%>
            <th>게임</th>
            <th></th>
            <th>테마</th>
            <th>평점</th>
            <th>난이도</th>
            <th>조회수</th>

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

                <td>
                    <p>${row.gnum}</p>
                    <p>조회수 랭킹으로 변경예정</p>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${row.gamephoto_url != null}">
                            <img src="${path}/resources/uploaded_game${row.gamephoto_url}"  onerror="this.src='../images/game/no-image-icon.png'" width="70px" height="70px">
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${row.bggnum != null}">
                                    <img class="img_photo" src="${row.bgg_thumbnail}" onerror="this.src='../images/game/no-image-icon.png'" width="70px" height="70px" border="1px">
                                </c:when>
                                <c:otherwise>
                                    <img src="../images/game/no-image-icon.png" width="70px" height="70px">
                                </c:otherwise>
                            </c:choose>

                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="${path}/game/view.do?gnum=${row.gnum}">${row.gametitle}<br>(${row.gametitle_eng})</a>
                </td>
                <td>보드라이프의 카테고리항목</td>
                <td>
                    <c:choose>
                        <c:when test="${row.rate == null}">
                            <strong>-.-</strong>
                        </c:when>
                        <c:otherwise>
                            <strong>${row.rate}</strong>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${row.weight == null}">
                            <strong>-.-</strong>
                        </c:when>
                        <c:otherwise>
                            <strong>${row.weight}</strong>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${row.totalviewcount}</td>

            </tr>
        </c:forEach>

        </tbody>

    </table>
</div>


<script>
    function list(page) {
        location.href="${path}/game/gamelist.do?curPage="+page;
    }

</script>