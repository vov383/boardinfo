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

<c:choose>

    <c:when test="${map.filter != null && '아티스트'.equalsIgnoreCase(map.filter)}">

                <c:set var="i" value="0" />
                <c:set var="j" value="4" />

                <c:forEach var="row" items="${map.alist}">

                    <c:if test="${i%j==0}">
                        <tr>
                    </c:if>

                    <td class="filterTd"><div class="wrap">
                        <div class="wrap t_center">
                            <div class="ellipsis rank03">
                                <a href="${path}/game/partrank/index?filter=artist&num=${row.anum}">${row.artist}</a>
                            </div>
                        </div>
                    </div></td>

                    <c:if test="${i%j==j-1}">
                        </tr>
                    </c:if>

                    <c:set var="i" value="${i+1}" />

                </c:forEach>


    </c:when>

    <c:when test="${map.filter != null && '디자이너'.equalsIgnoreCase(map.filter)}">
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.dlist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

                <td class="filterTd"><div class="wrap">
                    <div class="wrap t_center">
                        <div class="ellipsis rank03">
                            <a href="${path}/game/partrank/index?filter=designer&num=${row.dnum}">${row.designer}</a>
                        </div>
                    </div>
                </div></td>

            <c:if test="${i%j==j-1}">
                </tr>
            </c:if>

            <c:set var="i" value="${i+1}" />

        </c:forEach>
    </c:when>

    <c:when test="${map.filter != null && '퍼블리셔'.equalsIgnoreCase(map.filter)}">
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.plist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

                <td class="filterTd"><div class="wrap">
                    <div class="wrap t_center">
                        <div class="ellipsis rank03">
                            <a href="${path}/game/partrank/index?filter=publisher&num=${row.pnum}">${row.publisher}</a>
                        </div>
                    </div>
                </div></td>

            <c:if test="${i%j==j-1}">
                </tr>
            </c:if>

            <c:set var="i" value="${i+1}" />

        </c:forEach>
    </c:when>

</c:choose>

        </tbody>
    </table>

</div>

<c:if test="${map.gameKeyword != null && map.gameKeyword != ''}">
    <div>
        <a href="${path}/search/totalSearchMore/${map.filter}" style="display: inline-block; float: right;">더보기</a>
    </div>
</c:if>



<script>
    function list(page) {
          location.href="${path}/search/totalSearchMore/${map.filter}/${map.gameKeyword}?curPage="+page;
    }

</script>