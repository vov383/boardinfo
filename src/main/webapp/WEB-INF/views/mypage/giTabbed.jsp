<%--
  Created by IntelliJ IDEA.
  User: dbtjr
  Date: 2023-07-04
  Time: 오전 10:53
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
    <p class="h3">게임 등록 신청</p>
    <div class="tableDiv">
      <table class="table table-striped">
        <thead>
        <tr>
          <th>상태</th>
          <th>썸네일</th>
          <th>게임 이름<br>게임 이름(영문)</th>
          <th>발매 연도<span class="dot"></span>
            <i class="fa-regular fa-calendar" style="color: #cc350f;"></i></th>
          <th>테마</th>
          <th>
            작성일<span class="dot"></span><i class="fa-regular fa-clock"></i>
          </th>
        </tr>
        </thead>


        <tbody>
        <c:forEach items="${map.giList}" var="giRow">
          <tr>
            <td>
                ${giRow.confirmed}<br>
                ${giRow.del}
            </td>
            <td>
              <c:choose>
                <c:when test="${giRow.bgg_thumbnail eq null }">
                  <c:if test="${giRow.gamephoto_url ne null} ">
                    <img src="${path}/resources/uploaded_image${giRow.gamephoto_url}" style="width:40px">
                  </c:if>
                  <img src="${path}/images/game/no-image-icon.png" style="width:40px">
                </c:when>
                <c:otherwise>
                  &nbsp;<img src="${giRow.bgg_thumbnail}" style="width:40px">
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${fn:length(giRow.gametitle) >= 15}">
                  ${fn:substring(giRow.gametitle, 0, 14)}...
                </c:when>
                <c:otherwise>
                  ${giRow.gametitle}&nbsp;
                </c:otherwise>
              </c:choose>
              <br>
              <c:choose>
                <c:when test="${fn:length(giRow.gametitle_eng) >= 15}">
                  ${fn:substring(giRow.gametitle_eng, 0, 14)}...
                </c:when>
                <c:otherwise>
                  ${giRow.gametitle_eng}
                </c:otherwise>
              </c:choose>
            </td>

            <td>
                ${giRow.release_year}&nbsp;
              <i class="fa-regular fa-calendar" style="color: #cc350f;"></i>
            </td>
            <td>${giRow.theme}</td>
            <td>
              <span class="dot"></span><i class="fa-regular fa-clock"></i><span class="dot"></span>
                ${giRow.create_date}
            </td>
          </tr>
          <input type="hidden" name="gnum" value="${giRow.gnum}">
          <input type="hidden" id="create_user" name="create_user" value="${giRow.create_user}">
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

