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

<div id="allPost">
    <div id="grContainer">
        <c:forEach var="card" items="${map.grList}">
            <div class="grlDiv col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${card.gametitle}</h5>
                        <img src="${card.bgg_thumbnail}" class="card-img-top" alt="Board Game Thumbnail">
                        <p class="card-text">
                            Rating: ${card.rating}<br>Difficulty: ${card.weight}<br>
                            Rating Comment: ${card.rating_comment}<br>Likes: ${card.likeCount}
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div id="rvContainer">
        <div class="rvlDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>카테고리</th>
                    <th>제목 [댓글]</th>
                    <th>게임</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${map.rvList}" var="rvRow">
                    <tr>
                        <td>${rvRow.category}</td>
                        <td>${rvRow.title} [${rvRow.recnt}]</td>
                        <td>${rvRow.gametitle}</td>
                        <td>${rvRow.views}</td>
                        <td>${rvRow.good}</td>
                        <td>${rvRow.nickName}</td>
                        <td>${rvRow.createDate}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div id="gaContainer">
        <c:set var="gaRow" value="${map.gaList}"/>
        <div class="galDiv">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>제목 [댓글]</th>
                    <th>참가자 수 / 모집 인원</th>
                    <th>장소</th>
                    <th>조회수</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${map.gaList}" var="gaRow">
                    <tr>
                        <td>${gaRow.title} [${gaRow.reply_count}]</td>
                        <td>${gaRow.attendee_count} / ${gaRow.maxPeople}</td>
                        <td>${gaRow.address1} / ${gaRow.address2}</td>
                        <td>${gaRow.view_count}</td>
                        <td>${gaRow.nickname}</td>
                        <td>${gaRow.post_date}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div id="tbContainer">
        <c:forEach var="trCard" items="${map.tbList}">
            <div class="tblDiv">
                <div class="card w-75">
                    <div class="card-body">
                        <h5 class="card-title">${trCard.title}</h5>
                        <img src="${trCard.tb_thumbnail}" class="card-img-top" alt="Board Game Thumbnail">
                        <p class="card-text">
                            카테고리: ${trCard.category}<br>가격: ${trCard.price}<br>
                            주소: ${trCard.address1}, ${trCard.address2}<br>
                            조회수: ${trCard.view_count}<br>좋아요: ${trCard.good_count}<br>
                            댓글: ${trCard.re_count}
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>