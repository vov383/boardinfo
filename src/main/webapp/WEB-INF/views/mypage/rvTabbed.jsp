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
                        댓글&nbsp;<i class="fa-regular fa-comment-dots"></i>&nbsp;
                        조회수&nbsp;<i class="fa-solid fa-eye"></i>&nbsp;
                        좋아요&nbsp;<i class="fa-solid fa-heart"></i>&nbsp;
                    </th>
                    <th>게임</th>
                    <th>작성일<span class="dot"></span><i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${rvList}" var="rvRow">
                    <tr>
                        <td></td>
                        <td>
                            <span class="category">${rvRow.category}</span>
                            <c:choose>
                                <c:when test="${fn:length(rvRow.title) >= 20}">
                                    ${fn:substring(rvRow.title, 0, 19)}...
                                </c:when>
                                <c:otherwise>
                                    ${rvRow.title}
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <i class="fa-regular fa-comment-dots"></i><span class="dot"></span><span class="reCount">${rvRow.recnt}</span><span class="dot"></span>
                            <i class="fa-solid fa-eye"></i><span class="viewCont">${rvRow.views}</span><span class="dot"></span>
                            <i class="fa-solid fa-heart"></i><span class="goodCount">${rvRow.good}</span><span class="dot"></span>
                        </td>
                        <td>
                            <c:if test="${rvRow.gametitle ne null}">
                                ${rvRow.gametitle}
                            </c:if>
                        </td>
                        <td>
                            <i class="fa-regular fa-clock"></i>&nbsp;
                            <span class="dateSpan">${rvRow.createDate}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

