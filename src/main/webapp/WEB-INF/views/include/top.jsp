<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<div id="header">

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
      <a href="#" title="로그인" class="sign" id="signIn">로그인</a>
      <a href="#" title="회원가입" class="sign" id="signUp">회원가입</a>
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