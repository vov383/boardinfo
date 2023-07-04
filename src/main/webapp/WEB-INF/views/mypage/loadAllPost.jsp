<%--
  Created by IntelliJ IDEA.
  User: dbtjr
  Date: 2023-07-03
  Time: 오전 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>

<div id="allPost" class="">
    <div id="grContainer">
        <p class="h3">게임 평가</p>
        <div class="grlDiv">
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
                <c:forEach items="${map.grList}" var="grRow">
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
    <%--<div id="grContainer" class="row">--%>
<%--        <c:forEach var="card" items="${map.grList}">--%>
<%--            <div class="grlDiv col-md-4">--%>
<%--                <div class="card">--%>
<%--                    <div class="card-body">--%>
<%--                        <h5 class="card-title">${card.gametitle}</h5>--%>
<%--                        <img src="${card.bgg_thumbnail}" class="card-img-top" alt="Board Game Thumbnail">--%>
<%--                        <p class="card-text">--%>
<%--                            평점<i class="fa-solid fa-star" style="color: #f0bf0f;"></i>&nbsp; ${card.rating}<br>--%>
<%--                            난이도<i class="fa-solid fa-star" style="color: #3b2cc5;"></i>&nbsp; ${card.weight}<br>--%>
<%--                        <div class="ratingComment">--%>
<%--                            코멘트<i class="fa-regular fa-comment-dots"></i>&nbsp;--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${fn:length(card.rating_comment) >= 50}">--%>
<%--                                    ${fn:substring(card.rating_comment, 0, 49)}...<br>--%>
<%--                                </c:when>--%>
<%--                                <c:otherwise>--%>
<%--                                    ${card.rating_comment}<br>--%>
<%--                                </c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </div>--%>
<%--                        좋아요<i class="fa-solid fa-heart"></i>&nbsp;<span class="goodCount">${card.likeCount}</span> <br>--%>
<%--                        <i class="fa-regular fa-clock"></i>&nbsp;<span class="dateSpan">${card.create_date}</span>--%>
<%--                        </p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
    <div id="rvContainer">
        <p class="h3">커뮤니티</p>
        <div class="rvlDiv">
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
                <c:forEach items="${map.rvList}" var="rvRow">
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

    <div id="gaContainer">
        <p class="h3">오프 모임</p>
        <c:set var="gaRow" value="${map.gaList}"/>
        <div class="galDiv">
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
                    <th></th>
                    <th>작성일<i class="fa-regular fa-clock"></i></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${map.gaList}" var="gaRow">
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
                            ${gaRow.attendee_count} / ${gaRow.maxpeople}<br>
                            <i class="fa-regular fa-comment-dots"></i>&nbsp;<span
                                    class="reCount">${gaRow.garCount}</span><span class="dot"></span>
                                <i class="fa-regular fa-comment-dots"></i>&nbsp;<span
                                    class="reCount">${gaRow.view_count}</span><span class="dot"></span>
                                <i class="fa-regular fa-comment-dots"></i>&nbsp;<span
                                    class="reCount">${gaRow.galLikeCount}</span><span class="dot"></span>
                        </td>
                        <td>
                            <i class="fa-solid fa-location-dot"></i>&nbsp;
                            <span class="address">${gaRow.address1} / ${gaRow.address2}</span>
                        </td>

                        <td>
                            <i class="fa-solid fa-eye"></i>&nbsp;
                            <span class="viewCount">${gaRow.view_count}</span>
                        </td>
                        <td>
                            <i class="fa-solid fa-user"></i>&nbsp;
                                ${gaRow.nickname}
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
    <div id="trContainer">
        <p class="h3">중고 장터</p>
        <div class="tblDiv">
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
                <c:forEach items="${map.tbList}" var="trRow">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${trRow.tb_thumbnail ne null}">
                                    <img src="${path}/resources/upload${trRow.tb_thumbnail}" class="" style="width: 40px;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${path}/images/no-image-svgrepo-com.svg" class=""
                                         style="width: 40px; opacity: 20%;">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="category">${trRow.category}</span>
                            <span class="dot"></span>
                            <c:choose>
                                <c:when test="${fn:length(trRow.title) >= 15}">
                                    ${fn:substring(trRow.title, 0, 14)}...
                                </c:when>
                                <c:otherwise>
                                    ${trRow.title}
                                    <span class="dot"></span>
                                </c:otherwise>
                            </c:choose>
                            <br>
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
                        <td>
                            <i class="fa-regular fa-clock"></i>&nbsp;
                            <span class="dateSpan">${trRow.create_date}</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

<%--    <div id="tbContainer" class="row">--%>
<%--        <c:forEach var="trCard" items="${map.tbList}">--%>
<%--            <div class="tblDiv col-md-4">--%>
<%--                <div class="card">--%>
<%--                    <div class="card-body">--%>
<%--                        <h5 class="card-title">--%>
<%--                            <c:set var="titleLength" value="${fn:length(trCard.title)}" />--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${titleLength >= 15}">--%>
<%--                                ${fn:substring(trCard.title, 0, 19)}...--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                ${trCard.title}--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>
<%--                            <i class="fa-regular fa-comment-dots"></i>&nbsp;--%>
<%--                            <span class="reCount">${trCard.re_count}</span>--%>

<%--                        </h5>--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${trCard.tb_thumbnail ne null}">--%>
<%--                                <img src="${path}/resources/upload${trCard.tb_thumbnail}" class="card-img-top">--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                <img src="${path}/images/no-image-svgrepo-com.svg" class="card-img-top"--%>
<%--                                     style="opacity: 20%;">--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>

<%--                        <p class="card-text">--%>
<%--                            <span class="category">${trCard.category}</span> <br>--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${row.category eq '나눔'}">--%>
<%--                                    <span class="price">무료나눔</span><br>--%>
<%--                                </c:when>--%>
<%--                                <c:otherwise>--%>
<%--                                    가격 <span class="price">--%>
<%--                                    ${row.price}&nbsp;원</span> <br>--%>
<%--                                </c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                            <i class="fa-solid fa-location-dot"></i>&nbsp;--%>
<%--                            <span class="address">--%>
<%--                                    ${trCard.address1}, ${trCard.address2}--%>
<%--                            </span><br>--%>
<%--                            <i class="fa-solid fa-eye"></i>&nbsp;--%>
<%--                            <span class="viewCount">${trCard.view_count}</span> <br>--%>

<%--                            <i class="fa-solid fa-heart"></i>&nbsp;--%>
<%--                            <span class="goodCount">${trCard.good_count}</span> <br>--%>

<%--                            <br>--%>
<%--                            <i class="fa-solid fa-user"></i>&nbsp;--%>
<%--                            <span class="nickname">${trCard.nickname}</span> <br>--%>
<%--                            <i class="fa-regular fa-clock"></i>&nbsp;--%>
<%--                            <span class="dateSpan">${trCard.create_date}</span>--%>

<%--                        </p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
</div>