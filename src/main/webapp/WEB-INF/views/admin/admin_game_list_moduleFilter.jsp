<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/style_table.css">
<h3>${param.filter}</h3>
<div class="service_list_song">
    <table border="1" style="width:100%">

        <colgroup>
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">
            <col style="width: 25%">

        </colgroup>

        <tbody>

<c:choose>

    <c:when test="${param.filter eq 'artist'}">

                <c:set var="i" value="0" />
                <c:set var="j" value="4" />

                <c:forEach var="row" items="${map.alist}">

                    <c:if test="${i%j==0}">
                        <tr>
                    </c:if>

                    <td class="filterTd"><div class="wrap">
                        <div class="wrap t_center">
                            <div class="ellipsis rank03">
                                <p>${row.artist}</p>
                                <button type="button" onclick="deleteitem('${param.filter}',${row.anum})">삭제</button>
                            </div>
                        </div>
                    </div></td>

                    <c:if test="${i%j==j-1}">
                        </tr>
                    </c:if>

                    <c:set var="i" value="${i+1}" />

                </c:forEach>

    </c:when>

    <c:when test="${param.filter eq 'gamecategory'}">

        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.clist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

            <td class="filterTd"><div class="wrap">
                <div class="wrap t_center">
                    <div class="ellipsis rank03">
                        <p>${row.gamecategory}</p>
                        <button type="button" onclick="deleteitem('${param.filter}',${row.cnum})">삭제</button>
                    </div>
                </div>
            </div></td>

            <c:if test="${i%j==j-1}">
                </tr>
            </c:if>

            <c:set var="i" value="${i+1}" />

        </c:forEach>

    </c:when>

    <c:when test="${param.filter eq 'designer'}">

        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.dlist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

            <td class="filterTd"><div class="wrap">
                <div class="wrap t_center">
                    <div class="ellipsis rank03">
                        <p>${row.designer}</p>
                        <button type="button" onclick="deleteitem('${param.filter}',${row.dnum})">삭제</button>
                    </div>
                </div>
            </div></td>

            <c:if test="${i%j==j-1}">
                </tr>
            </c:if>

            <c:set var="i" value="${i+1}" />

        </c:forEach>

    </c:when>

    <c:when test="${param.filter eq 'mechanic'}">

        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.mlist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

            <td class="filterTd"><div class="wrap">
                <div class="wrap t_center">
                    <div class="ellipsis rank03">
                        <p>${row.mechanic}</p>
                        <button type="button" onclick="deleteitem('${param.filter}',${row.mnum})">삭제</button>
                    </div>
                </div>
            </div></td>

            <c:if test="${i%j==j-1}">
                </tr>
            </c:if>

            <c:set var="i" value="${i+1}" />

        </c:forEach>

    </c:when>

    <c:when test="${param.filter eq 'publisher'}">

        <c:set var="i" value="0" />
        <c:set var="j" value="4" />

        <c:forEach var="row" items="${map.plist}">

            <c:if test="${i%j==0}">
                <tr>
            </c:if>

            <td class="filterTd"><div class="wrap">
                <div class="wrap t_center">
                    <div class="ellipsis rank03">
                        <p>${row.publisher}</p>
                        <button type="button" onclick="deleteitem('${param.filter}',${row.mnum})">삭제</button>
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



<script>

    function deleteitem(filter, num){
        location.href="${path}/admin/deleteitem/"+filter+"/"+num;
    }

</script>