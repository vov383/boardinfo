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
                        댓글&nbsp;<i class="fa-regular fa-comment-dots"></i>&nbsp;
                        조회수&nbsp;<i class="fa-solid fa-eye"></i>&nbsp;
                        좋아요&nbsp;<i class="fa-solid fa-heart"></i>&nbsp;
                    </th>
                    <th>장소<i class="fa-solid fa-location-dot"></i></th>
                    <th>작성일<i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${gaList}" var="gaRow">
                    <tr>
                        <td>
                            <i class="fa-regular fa-calendar" style="color: #cc350f;"></i>&nbsp;${gaRow.gathering_date}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:length(gaRow.title)>=15}">
                                    ${fn:substring(gaRow.title, 0, 14)}...
                                </c:when>
                            </c:choose>
                                ${gaRow.title}&nbsp;
                            <br>
                            <i class="fa-solid fa-user"></i>&nbsp;&nbsp;
                                ${gaRow.attendee_count} / ${gaRow.maxpeople}<br>
                            <i class="fa-regular fa-comment-dots"></i>&nbsp;<span
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
                            <i class="fa-solid fa-location-dot"></i>&nbsp;
                            <span class="address">${gaRow.address1} / ${gaRow.address2}</span>
                        </td>
                        <td>
                            <i class="fa-regular fa-clock"></i>&nbsp;
                            <span class="dateSpan">${gaRow.create_date}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
