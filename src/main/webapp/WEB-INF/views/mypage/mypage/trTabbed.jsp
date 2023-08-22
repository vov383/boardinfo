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
        <p class="h3">중고 장터</p>
        <div class="tableDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>썸네일</th>
                    <th>
                        카테고리, 제목<br>
                        댓글</i><span class="dot"></span>
                        <i class="fa-regular fa-comment-dots"></i>
                        <span class="dot"></span>
                        , 조회수<span class="dot"></span>
                        <i class="fa-solid fa-eye"></i>
                        <span class="dot"></span>
                        , 좋아요<span class="dot"></span><i class="fa-solid fa-heart"></i>
                    </th>
                    <th>가격</th>
                    <th>
                        장소<span class="dot"></span>
                        <i class="fa-solid fa-location-dot"></i>
                        <span class="dot"></span>
                    </th>
                    <th>작성일<span class="dot"></span><i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${response.trList}" var="trRow">
                    <tr>
                        <c:choose>
                            <c:when test="${trRow.del eq 'Y'}">
                                <td colspan="4">
                                    삭제된 글입니다.
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <c:choose>
                                        <c:when test="${trRow.tb_thumbnail ne null}">
                                            <img src="${path}/resources/upload${trRow.tb_thumbnail}" class=""
                                                 style="width: 40px;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${path}/images/no-image-svgrepo-com.svg" class=""
                                                 style="width: 40px; opacity: 20%;">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="category">${trRow.category}</div>
                                    <div class="title">
                                        <a href="${path}/tboard/view/${trRow.tb_num}">
                                            <c:choose>
                                                <c:when test="${fn:length(trRow.title) >= 15}">
                                                    ${fn:substring(trRow.title, 0, 14)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${trRow.title}
                                                    <span class="dot"></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                    <i class="fa-regular fa-comment-dots"></i><span class="dot"></span>
                                    <span class="reCount">${trRow.re_count}</span><span class="dot"></span>

                                    <i class="fa-solid fa-eye"></i><span class="dot"></span>
                                    <span class="viewCount">${trRow.view_count}</span><span class="dot"></span>

                                    <i class="fa-solid fa-heart"></i><span class="dot"></span>
                                    <span class="goodCount">${trRow.good_count}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${trRow.category eq '나눔'}">
                                            <span class="price">무료나눔</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="price">${trRow.price} 원</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <i class="fa-solid fa-location-dot"></i><span class="dot"></span>
                                    <span class="address">${trRow.address1} ${trRow.address2}</span>
                                </td>
                            </c:otherwise>
                        </c:choose>

                        <td>
                            <i class="fa-regular fa-clock"></i><span class="dot"></span>
                            <span class="dateSpan">${trRow.create_date}</span>
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
                <a href="#" onclick="listTab('trade', this, 1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="listTab('trade', this, '${response.pager.prevBlock}')">&lt;</a>
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
                        <a href="#" onclick="listTab('trade', this, '${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${response.pager.curBlock < response.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="listTab('trade', this,'${response.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${response.pager.curPage < response.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="listTab('trade', this, ${response.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>

</div>
