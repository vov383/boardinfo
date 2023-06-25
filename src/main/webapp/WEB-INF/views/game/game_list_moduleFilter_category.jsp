<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/style_table.css">
<link rel="stylesheet" href="${path}/include/css/pagenation.css">

<div class="service_list_song">
    <table border="1" style="width:100%">

        <colgroup>
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">

        </colgroup>

        <tfoot>

        <tr>

            <td colspan="4" align="center">

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

                <c:set var="i" value="0" />
                <c:set var="j" value="4" />

                <c:forEach var="row" items="${map.list}">

                    <c:if test="${i%j==0}">
                        <tr>
                    </c:if>

                    <td class="filterTd"><div class="wrap">
                        <div class="wrap t_center">
                            <div class="ellipsis rank01">
                                <a href="${path}/game/partrank/week?filter=gamecategory&num=${row.cnum}">
                                        ${row.gamecategory}(${row.count})
                                </a>
                            </div>
                            <br>
                            <div class="ellipsis rank02">
                                <a href="${path}/game/partrank/week?filter=gamecategory&num=${row.cnum}">
                                    한글컬럼 인풋후 사용
                                </a>
                            </div>
                        </div>
                    </div></td>

                    <c:if test="${i%j==j-1}">
                        </tr>
                    </c:if>

                    <c:set var="i" value="${i+1}" />

                </c:forEach>


        </tbody>
    </table>

</div>


<script>
    function list(page) {
          location.href="${path}/search/totalSearchMore/${map.filter}/${map.gameKeyword}?curPage="+page;
    }

</script>