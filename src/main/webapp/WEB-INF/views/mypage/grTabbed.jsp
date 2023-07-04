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
                        평점<i class="fa-solid fa-star" style="color: #f0bf0f;"></i>&nbsp;
                        난이도<i class="fa-solid fa-star" style="color: #3b2cc5;"></i>&nbsp;
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
                <c:forEach items="${grList}" var="grRow">
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
                                    ${grRow.gametitle}&nbsp;
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <i class="fa-solid fa-star" style="color: #f0bf0f;"></i>&nbsp; ${grRow.rating}&nbsp;
                            <i class="fa-solid fa-star" style="color: #3b2cc5;"></i>&nbsp; ${grRow.weight}&nbsp;
                        </td>
                        <td>
                            <i class="fa-regular fa-comment-dots"></i>&nbsp;
                            <c:choose>
                                <c:when test="${fn:length(grRow.rating_comment) >= 40}">
                                    ${fn:substring(grRow.rating_comment, 0, 49)}...
                                </c:when>
                                <c:otherwise>
                                    ${grRow.rating_comment}
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <i class="fa-solid fa-heart"></i>&nbsp;
                            <span class="goodCount">${grRow.likeCount}</span>
                        </td>
                        <td>
                            <i class="fa-regular fa-clock"></i>&nbsp;
                            <span class="dateSpan">${grRow.create_date}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    </div>
</div>
