<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/style_table.css">

<div class="service_list_song">
    <h3>${param.filter}</h3>
    <table border="1" style="width:100%">

        <colgroup>
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">

        </colgroup>



        <tbody>

<c:choose>

    <c:when test="${param.filter != null && '아티스트'.equalsIgnoreCase(param.filter)}">

        <c:choose>
            <c:when test="${gameMap.alist == null}">
                <tr>
                    <td colspan="4" style="margin: auto"><h2>검색어에 해당하는 결과가 없습니다.</h2></td>
                </tr>
            </c:when>

            <c:otherwise>

                <c:set var="i" value="0" />
                <c:set var="j" value="4" />

                <c:forEach var="row" items="${gameMap.alist}">

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

            </c:otherwise>
        </c:choose>

    </c:when>

    <c:when test="${param.filter != null && '디자이너'.equalsIgnoreCase(param.filter)}">
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${gameMap.dlist}">

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

    <c:when test="${param.filter != null && '퍼블리셔'.equalsIgnoreCase(param.filter)}">
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${gameMap.plist}">

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
<div>
    <a href="#" style="display: inline-block; float: right;">전체 ${param.filter} 보기</a>
</div>
