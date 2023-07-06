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
        <p class="h3">커뮤니티</p>
        <div class="tableDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th></th>
                    <th>
                        카테고리
                        제목<br>
                        댓글<span class="dot"></span><i class="fa-regular fa-comment-dots"></i><span class="dot"></span>
                        조회수<span class="dot"></span><i class="fa-solid fa-eye"></i><span class="dot"></span>
                        좋아요<span class="dot"></span><i class="fa-solid fa-heart"></i><span class="dot"></span>
                    </th>
                    <th>게임</th>
                    <th>작성일<span class="dot"></span><i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${response.rvList}" var="rvRow">
                    <tr>
                        <c:choose>
                            <c:when test="${rvRow.del eq 'Y'}">
                                <td colspan="3">
                                    <span class="category">|${rvRow.category}|</span>
                                    <span class="rvTitle">
                                        삭제된 글입니다.
                                    </span>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td></td>
                                <td>
                                    <div class="category">${rvRow.category}</div>
                                    <div class="rvTitle">
                                        <a href="${path}/review/reviewdetail.do?reviewDetailKey=${rvRow.regNum}">
                                            <c:choose>
                                                <c:when test="${fn:length(rvRow.title) >= 20}">
                                                    ${fn:substring(rvRow.title, 0, 19)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${rvRow.title}
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                    <i class="fa-regular fa-comment-dots"></i><span class="dot"></span><span
                                        class="reCount">${rvRow.recnt}</span><span class="dot"></span>
                                    <i class="fa-solid fa-eye"></i><span class="viewCont">${rvRow.views}</span><span
                                        class="dot"></span>
                                    <i class="fa-solid fa-heart"></i><span class="goodCount">${rvRow.good}</span><span
                                        class="dot"></span>
                                </td>
                                <td>
                                    <c:if test="${rvRow.gametitle ne null}">
                                        ${rvRow.gametitle}
                                    </c:if>
                                </td>
                            </c:otherwise>
                        </c:choose>
                        <td>
                            <i class="fa-regular fa-clock"></i><span class="dot"></span>
                            <span class="dateSpan">${rvRow.createDate}</span>
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
                <a href="#" onclick="listTab('review', this, 1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('review', this, '${response.pager.prevBlock}')">&lt;</a>
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
                        <a href="#" onclick="listTab('review', this, '${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${response.pager.curBlock < response.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="listTab('review', this,'${response.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curPage < response.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="listTab('review', this, ${response.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>

</div>

