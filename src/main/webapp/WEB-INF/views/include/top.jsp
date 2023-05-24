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
      <form name="gameSearch" id="gameSearch" method="get" action="${path}/game/searchAll.do">
        <div>
          <input name="gameKeyword" id="gameKeyword" placeholder="보드게임 찾기" autocomplete="off">
          <input type="hidden">
          <img src="${path}/images/search.png" onclick="searchAll()">
          <div id="gameSearchDiv"></div>
        </div>
      </form>
      <a href="#" title="로그인" class="sign" id="signIn">로그인</a>
      <a href="#" title="회원가입" class="sign" id="signUp">회원가입</a>
    </div>
  </div>
  </div>
  
  <div class="nav">
    <ul class="menu">
      <li><a href="${path}/game/gamelist.do" class="toMenu" title="게임정보">게임정보<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="커뮤니티">커뮤니티<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="오프모임">오프모임<img src="${path}/images/dropdown.png" width="34px"></a></li>
      <li><a href="#" class="toMenu" title="중고장터">중고장터<img src="${path}/images/dropdown.png" width="34px"></a></li>
    </ul>
  </div>
</div>

<script>
function searchAll() {
  const keyword = $("#gameKeyword").val();
  if(keyword !== ""){
    document.gameSearch.submit();
  }
}
$(document).ready(function(){
  $("#gameKeyword").keyup(function(){
      if(Event.keyCode === '13'){
        searchAll();
      }else{
        var input = $("#gameKeyword").val();
        $.ajax({
          type: "get",
          url: "${path}/game/autoGame.do/"+input,
          success: function(result) {
            var gameSearchDiv = $('#gameSearchDiv');
            gameSearchDiv.empty(); // 기존 내용 비우기

            if (result.length > 0) {
              gameSearchDiv.css('max-height', '250px').show(); // 값이 있을 경우 높이 설정하고 보이기
              $(result).each(function(index, item) {
                var gametitle = item.gametitle;
                var gametitle_eng = item.gametitle_eng;
                var gnum = item.gnum;
                console.log(gnum);
                console.log(gametitle);
                gameSearchDiv.append("<div class='searched'><a href='${path}/game/view.do?gnum=" + gnum + "'>" + gametitle + "<br>(" + gametitle_eng + ")</div>");
              });
            } else {
              gameSearchDiv.hide(); // 값이 없을 경우 숨기기
            }
          },
          error: function() {
            console.log("에러..");
          }
        });
        if(input=="")	$('#gameSearchDiv').empty();
      }
  });
});




</script>