giMore.jsp<%--
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
        <p class="h3">게임 평가</p>
        <div class="tableDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>썸네일</th>
                    <th>게임 제목<br>
                        평점<i class="fa-solid fa-star" style="color: #f0bf0f;"></i><span class="dot"></span>
                        난이도<i class="fa-solid fa-star" style="color: #3b2cc5;"></i><span class="dot"></span>
                    </th>
                    <th>
                        게임 평가 코멘트<i class="fa-regular fa-comment-dots"></i><br>
                        좋아요<span class="dot"></span><i class="fa-solid fa-heart"></i>
                    </th>
                    <th>
                        작성일<span class="dot"></span><i class="fa-regular fa-clock"></i>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${response.grList}" var="grRow">
                    <tr>
                        <td>
                            <img src="${grRow.bgg_thumbnail}" style="width:40px">
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:length(grRow.gametitle) >= 15}">
                                    ${fn:substring(grRow.gametitle, 0, 14)}...
                                </c:when>
                                <c:otherwise>
                                    ${grRow.gametitle}<span class="dot"></span>
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <i class="fa-solid fa-star" style="color: #f0bf0f;"></i><span class="dot"></span> ${grRow.rating}<span class="dot"></span>
                            <i class="fa-solid fa-star" style="color: #3b2cc5;"></i><span class="dot"></span> ${grRow.weight}<span class="dot"></span>
                        </td>
                        <td>
                            <i class="fa-regular fa-comment-dots"></i><span class="dot"></span>
                            <c:choose>
                                <c:when test="${fn:length(grRow.rating_comment) >= 40}">
                                    ${fn:substring(grRow.rating_comment, 0, 49)}...
                                </c:when>
                                <c:otherwise>
                                    ${grRow.rating_comment}
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <i class="fa-solid fa-heart"></i><span class="dot"></span>
                            <span class="goodCount">${grRow.likeCount}</span>
                        </td>
                        <td>
                            <i class="fa-regular fa-clock"></i><span class="dot"></span>
                            <span class="dateSpan">${grRow.create_date}</span>
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
                <a href="#" onclick="listTab('game_rating', this, 1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('game_rating', this, '${response.pager.prevBlock}')">&lt;</a>
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
                        <a href="#" onclick="listTab('game_rating', this, '${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${response.pager.curBlock < response.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="listTab('game_rating', this,'${response.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curPage < response.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="listTab('game_rating', this, ${response.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>
</div>
