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
        <c:forEach items="${response.giList}" var="giRow">
          <tr>
            <td>
              <%--confirmed 컬럼의 값에 따라 다르게 표현 'checking', 'deny', 'allow'--%>
              <c:choose>
                <c:when test="${giRow.confirmed eq 'checking'}">
                  <div class="confirmed">
                    승인대기 <br>
                  </div>
                </c:when>
                <c:when test="${giRow.confirmed eq 'deny'}">
                  <div class="confirmed">
                    승인거부
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="confirmed">
                    승인완료
                  </div>
                </c:otherwise>
              </c:choose>
              <%--del 컬럼의 값에 따라 다르게 표현--%>
              <c:choose>
                <c:when test="${giRow.del eq 'y'}">
                  <div class="giDel">
                    비공개 <br>
                  </div>
                </c:when>
                <c:when test="${giRow.del eq 'n'}">
                  <div class="giDel">
                    공개 <br>
                  </div>
                </c:when>
              </c:choose>
            </td>

            <%--상태 컬럼 이후의 데이터는 del eq 'n' 이면 리스트에 보여주고 'y'이면 비공개 항목입니다로 출력--%>
            <c:choose>
              <c:when test="${giRow.del eq 'n'}">
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
                  <a href="${path}/game/view.do?gnum=${giRow.gnum}">
                  <c:choose>
                    <c:when test="${fn:length(giRow.gametitle) >= 15}">
<%--                      <a href="${path}/game/view.do?gnum=${giRow.gnum}"></a>--%>
                        ${fn:substring(giRow.gametitle, 0, 14)}...

                    </c:when>
                    <c:otherwise>
                      ${giRow.gametitle}&nbsp;
                    </c:otherwise>
                  </c:choose>
                  </a>
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

              </c:when>
              <c:otherwise>
                <td>
                  비공개 상태 게시물입니다.<br>
                  관리자의 승인 이후 조회하실 수 있습니다.
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                  <c:if test="${giRow.update_date ne null}">
                    c
                  </c:if>
                </td>
              </c:otherwise>
            </c:choose>
          </tr>
          <input type="hidden" name="gnum" value="${giRow.gnum}">
          <input type="hidden" name="create_user" value="${giRow.create_user}">
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <%--페이징 처리--%>
  <section class="pagenation">
    <c:if test="${response.pager.curPage > 1}">
      <div class="pageItem">
        <a href="#" onclick="listTab('game', this, 1)">&lt;&lt;</a>
      </div>
    </c:if>
    <c:if test="${response.pager.curBlock > 1}">
      <div class="pageItem">
        <a href="#" onclick="listTab('game', this, '${response.pager.prevBlock}')">&lt;</a>
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
            <a href="#" onclick="listTab('game', this, '${num}')">${num}</a>
          </div>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${response.pager.curBlock < response.pager.totBlock}">
      <div class="pageItem">
        <a href="#" onclick="listTab('game', this,'${response.pager.nextBlock}')">&gt;</a>
      </div>
    </c:if>
    <c:if test="${response.pager.curPage < response.pager.totPage}">
      <div class="pageItem">
        <a href="#" onclick="listTab('game', this, ${response.pager.totPage})">&gt;&gt;</a>
      </div>
    </c:if>
  </section>

</div>
