<%--
  Created by IntelliJ IDEA.
  User: dbtjr
  Date: 2023-07-04
  Time: 오후 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>

<div id="tabbedPost">
    <div id="listContainer">
        <p class="h3">좋아요 목록</p>

        <div class="tableDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>게시판</th>
                    <th>제목</th>
                    <th>작성자 <i class="fa-solid fa-user"></i></th>
                    <th>작성일 <i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${response.likeList}" var="likeRow">
                    <tr>
                        <td>${likeRow.table_name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:length(likeRow.preview)>=15}">
                                    ${fn:substring(likeRow.preview, 0, 14)}...
                                </c:when>
                            </c:choose>
                                ${likeRow.preview}<span class="dot"></span>
                        </td>
                        <td>
                            <i class="fa-solid fa-user"></i>
                                ${likeRow.create_user}
                        </td>
                        <td>
                            <i class="fa-regular fa-clock"></i><span class="dot"></span>
                            <span class="dateSpan">${likeRow.create_date}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%--페이징 처리--%>
    <section class="pagenation">
        <c:if test="${response.pager.curPage > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('reply', this, 1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('reply', this, '${response.pager.prevBlock}')">&lt;</a>
            </div>
        </c:if>
        <c:forEach var="num" begin="${response.pager.blockStart}" end="${response.pager.blockEnd}">
            <c:choose>
                <c:when test="${num == response.pager.curPage}">
                    <!-- 현재 페이지인 경우 onclick 없음 -->
                    <div class="pageItem">
                        <div id="curPage">${num}</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="pageItem">
                        <a href="#" onclick="listTab('reply', this, '${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${response.pager.curBlock < response.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="listTab('reply', this,'${response.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curPage < response.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="listTab('reply', this, ${response.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>
</div>
