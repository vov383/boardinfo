<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<div id="header">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
  <div id="header-upper-box">
  <div>
    <div id="header-left">
      <a href="#" title="보드인포"><img src="${path}/images/boardinfo_logo.png" width="170px"></a>
    </div>
    <div id="header-right">
      <form name="gameSearch" id="gameSearch" method="get">
        <div>
          <input type="text" name="gameKeyword" placeholder="보드게임 찾기">
          <img src="${path}/images/search.png">
        </div>
      </form>
      <c:choose>
  	 <c:when test="${sessionScope.userid == null}">
    <!-- 로그인하지 않은 상태 -->
      <a href="${path}/member/member_login.do" title="로그인" class="sign" id="signIn">로그인</a>
      <a href="${path}/member/member_join.do" title="회원가입" class="sign" id="signUp">회원가입</a>
      </c:when>
   <c:otherwise>
    <!-- 로그인한 상태 -->
    ${sessionScope.name}님이 로그인중입니다.
    <a href="${path}/member/view.do?userid=${sessionScope.userid}">회원정보</a> |
    <a href="${path}/member/logout.do">로그아웃</a> 
   </c:otherwise>
  </c:choose>
    </div>
  </div>
  </div>
  
  <div class="nav">
    <ul class="menu">
      <li><a href="#" class="toMenu" title="게임정보">게임정보<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="커뮤니티">커뮤니티<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="오프모임">오프모임<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="중고장터">중고장터<img src="${path}/images/dropdown.png" width="34px"></a></li>
    </ul>
  </div>
</div>