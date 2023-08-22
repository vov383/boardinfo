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
        <p class="h3">오프 모임</p>

        <div class="tableDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>날짜<i class="fa-regular fa-calendar" style="color: #cc350f;"></i></th>
                    <th>
                        제목<br>
                        참가자 수 / 모집 인원 <i class="fa-solid fa-user"></i><br>
                        댓글<span class="dot"></span><i class="fa-regular fa-comment-dots"></i><span class="dot"></span>
                        조회수<span class="dot"></span><i class="fa-solid fa-eye"></i><span class="dot"></span>
                        좋아요<span class="dot"></span><i class="fa-solid fa-heart"></i><span class="dot"></span>
                    </th>
                    <th>장소<i class="fa-solid fa-location-dot"></i></th>
                    <th>작성일<i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${response.gaList}" var="gaRow">
                    <tr>
                        <c:choose>
                            <c:when test="${gaRow.show eq 'N'}">
                                <td colspan="3">
                                    <div class="delPost">
                                        삭제된 글입니다.
                                    </div>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <i class="fa-regular fa-calendar" style="color: #cc350f;"></i><span
                                        class="dot"></span>${gaRow.gathering_date}
                                </td>
                                <td>
                                    <div class="title">
                                        <a href="${path}/gathering/view/${gaRow.gathering_id}">
                                            <c:choose>
                                                <c:when test="${fn:length(gaRow.title)>=15}">
                                                    ${fn:substring(gaRow.title, 0, 14)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${gaRow.title}<span class="dot"></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                    <i class="fa-solid fa-user"></i><span class="dot"></span>
                                        ${gaRow.attendee_count} / ${gaRow.maxpeople}<br>
                                    <i class="fa-regular fa-comment-dots"></i><span class="dot"></span><span
                                        class="reCount">${gaRow.garCount}</span>
                                    <span class="dot"></span>
                                    <i class="fa-solid fa-eye"></i><span class="dot"></span>
                                    <span class="viewCount">${gaRow.view_count}</span><span class="dot"></span>
                                    <i class="fa-solid fa-heart"></i><span class="dot"></span>
                                    <span class="goodCount">
                                            ${gaRow.galLikeCount}
                                    </span><span class="dot"></span>
                                </td>
                                <td>
                                    <i class="fa-solid fa-location-dot"></i><span class="dot"></span>
                                    <span class="address">${gaRow.address1} / ${gaRow.address2}</span>
                                </td>
                            </c:otherwise>
                        </c:choose>
                        <td>
                            <i class="fa-regular fa-clock"></i><span class="dot"></span>
                            <span class="dateSpan">${gaRow.create_date}</span>
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
                <a href="#" onclick="listTab('gathering', this, 1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('gathering', this, '${response.pager.prevBlock}')">&lt;</a>
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
                        <a href="#" onclick="listTab('gathering', this, '${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${response.pager.curBlock < response.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="listTab('gathering', this,'${response.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curPage < response.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="listTab('gathering', this, ${response.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>

</div>
