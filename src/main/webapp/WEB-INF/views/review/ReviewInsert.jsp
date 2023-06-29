<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>커뮤니티 - 글쓰기</title>
<%@ include file="../include/js/header.jsp" %>

  <style>

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');}

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');}

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');}

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');}

    @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');}

    * {
      font-family: 'Noto Sans KR', sans-serif;
      font-size: 15px;
    }

    html, body{
      margin: 0 0;
      padding: 0 0;
      min-height: 100%;
    }

    div, input, span{
      box-sizing: border-box;
    }

    #header{
      width: 100%;
      margin: 0 auto;
      position: fixed;
      left: 0;
      top: 0;
      background-color: white;
      z-index: 450;
      border-bottom: 1px solid #D9D9D9;      
    }

    #header-upper-box{
      background-color: #FFC61A;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 77px;
    }
    
    #header-upper-box > div{
	 display: flex;
     justify-content: space-between;
     align-items: center;
     height: 77px;
     flex-basis: 1120px;
     max-width: 1120px;
    }

    #header-left{
      display: flex;
      align-items: center;
    }

    #header-right {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 15px;
    }

    form[name="gameSearch"] > div:first-of-type{
      background-color: white;
      position: relative;
      width: 320px;
      height: 34px;
      padding: 2px 10px;
      border: 2px black solid;
      border-radius: 20px;
    }

    form[name="gameSearch"] img{
      width: 20px;
      position: absolute;
      top: 5px;
      right: 12px;
      margin: 0;
      -webkit-user-drag: none;
    }

    #header-right input:first-of-type{
      width: 270px;
      height: 25px;
      padding-left: 20px;
      border: none;
      font-size: 16px;
      background-color: rgba(255, 255, 255, 0.5);
    }

    .sign{
      text-decoration: none;
      font-size: 15px;
      font-weight: bold;
      color: black;
    }

    #signIn{
      margin: 0 30px;
    }

    .nav{
      margin: 0 auto;
      max-width: 1120px;
      display: flex;
    }

    .menu {
      display: flex;
      justify-content: space-between;
      align-items: center;
      height: 45px;
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .menu li {
      display: inline-block;
      flex: 0 0 25%;
      max-width: 25%;
      height: 100%;
      line-height: 45px;
    }

    .toMenu{
      display: flex;
      align-items: center;
      font-size: 16px;
      font-weight: bold;
      text-decoration: none;
      color: black;
      margin-right: 20px;
    }

    .toMenu > img{
      margin-left: -4px;
      -webkit-user-drag: none;
    }

    #contents{
      display: flex;
      flex-direction: column;
      margin: auto;
      max-width: 1120px;
      min-height: 100%;
      padding: 129px 0 0 0;
      font-size: 16px;
    }

    #contentsHeader{
      margin: 0;
      padding-top: 32px;
      padding-bottom: 5px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    #contentsHeader h2{
      font-size: 1.9em;
      margin-top: 0;
      margin-bottom: 5px;
    }

    #contentsLocation{
      margin-bottom: 30px;
    }

    #contentsMain{
      border-top: 2px solid black;
      margin-bottom: 80px;
      flex-grow: 1;
      min-height: 420px;
    }

    #postUpper{
      display: flex;
    }

    #postUpper > div:first-of-type{
      padding: 30px 0;
    }

    #tmpDiv, #map{
      width: 400px;
      height: 280px;
      border: 1px solid black;
      text-align: center;
      line-height: 280px;
    }

    #map{
      overflow: hidden;
      display: none;
    }

    #postUpper > div:nth-of-type(2){
      padding: 30px 0 30px 0;
      flex-grow: 1;
      display: flex;
      justify-content: space-between;
      flex-direction: column;
    }

    .labelAndItem{
      display: flex;
      flex-direction: row;
    }

    .labelAndItem > span:first-of-type{
      width: 90px;
      text-align: right;
      margin-right: 25px;
    }

    .labelAndItem input{
      padding-left: 8px;
    }

    .flex{
      flex-grow: 1;
    }

    #locationSearchBtn{
      cursor: pointer;
      width: 65px;
      margin-left: 5px;
    }

    .labelAndItem input[type="date"]{
      width: 190px;
    }

    .labelAndItem input[type="number"]{
      width:100px;
      margin-right: 5px;
    }


    input[name="question"]{
      width: 100%;
    }

    #hiddenQuestion{
      display: flex;
      flex-direction: column;
      visibility: hidden;
    }

    #postMain{
      padding: 20px 0;
      border-top: 2px dashed #D9D9D9;
      display: flex;
      flex-direction: column;
    }

    #postMain > div:last-of-type{
      text-align: center;
    }

    #description{
      padding: 20px;
      height: 300px;
      resize: none;
    }

    #postMain ul{
      list-style-position: inside;
      margin: 0;
      padding: 20px 10px 30px 10px;
    }

    button[id*="btn-"]{
      cursor: pointer;
      width: 82px;
      height: 34px;
      font-size: 16px;
      font-weight: bold;
      border-radius: 0;
    }

    #btn-attachGame{
      margin-bottom: 10px;
      background-color: #1432B1;
      border: 0;
      color: white;
    }

    #btn-submit{
      background-color: #F9841A;
      margin-right: 10px;
      color: white;
      border: 0;
    }

    #btn-reset{
      border: 1px solid black;
      background-color: white;
    }


    footer{
      font-size: 15px;
      color: #DFDFDF;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 190px;
      background-color: #3D3D43;
      bottom: 0;
      clear: both;
    }
    
    
    footer > div{
      width: 100%;
      max-width: 1120px;
    }
  </style>

  <script type="text/javascript">
    /*리뷰 첫 입력 및 수정*/
  function btnSaveClick() {

    var gnum = "";

    $("div[name='selectedGame']").each(function (index, item) {
      if (index == 0) {
        gnum = $(item).attr("item");
      } else {
        gnum += "," + $(item).attr("item");
      }
    });

    $("#gameGnum").val(gnum);

  document.reviewInsertSave.submit();
  }

    // 리뷰 리스트로 이동
    function btnList(){
      location.href="${path}/review/reviewlist.do?freeFlag=${freeFlag}";
    }
  </script>


  <script>
    $(function(){
    //	gametitle 검색 자동완성 쿼리
    $('input[name="inputGame"]').keyup(function() {
      var input = $(this).val();
      $.ajax({
        type: "POST",
        url: "${path}/game/autoGame.do/"+input,
        success: function(result) {
          var suggestionsDiv = $('#gametitleSuggestions');
          suggestionsDiv.empty(); // 기존 내용 비우기
          if (result.length > 0) {
            suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
            $(result).each(function(index, item) {
              var gametitle = item.gametitle;
              var gamephoto_url = item.gamephoto_url;
              var bgg_thumbnail = item.bgg_thumbnail;
              var bggnum = item.bggnum;
              // console.log("item",item.gnum);
              //var str => #gameSearchDiv 안에 들어갈 태그 입력
              var str = "<div class='searched_top'><div class='imageDiv'>";

              if(gamephoto_url != null) { //db에 입력된 사진 주소값이 없으면
                str += '<img src="${path}/resources/uploaded_game' + gamephoto_url + '"';
                str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
              } else {
                if(bggnum != null){ //보드게임긱 아이디가 존재하면
                  str += '<img class="img_photo" src="' + bgg_thumbnail + '"';
                  str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
                }else {
                  str += '<img src="${path}/images/game/no-image-icon.png">';
                }
              }
              str += "</div><div class='searched cursor_pointer' item='"+item.gnum+"'>" + gametitle + "</div></div>";

              suggestionsDiv.append(str);
            });
          } else {
            suggestionsDiv.hide(); // 값이 없을 경우 숨기기
          }
        },
        error: function() {
          console.log("에러..");
        }
      });
      if(input=="")	$('#gametitleSuggestions').empty();
    });

    var selectedGames = [];
    function updateGameInput() {
      var gameInput = $("#gametitle"); /*var selectedGames = []; 해당 배열의 값이 #gametitle 여기로 넘어감, ',' 기준으로 스트링으로 넘어감*/
      gameInput.val(selectedGames.join(","));
    }
    //게임 검색값 클릭시 배열에 추가
    $('#gametitleSuggestions').on('click', '.searched', function() {
      var selectedGame = $(this).text();
      selectedGames.push(selectedGame);

      $("#selectedGame").append("<div class='selected-value cursor_pointer' name='selectedGame' item='"+$(this).attr("item")+"'>" + selectedGame + "</div>");
      console.log("배열"+selectedGames);
      $('input[name="inputGame"]').val("");
      $("#gametitleSuggestions").empty().hide();
      updategameInput();
      console.log("인풋"+$("#gametitle").val());
    });
    // 선택된 값 클릭 이벤트 처리
    $("#selectedGame").on("click", ".selected-value", function() {
      var value = $(this).text();
      // 선택된 값 배열에서 해당 값을 제거
      selectedGames = selectedGames.filter(function(selected) {
        return selected !== value;
      });
      // 선택된 값 표시가 삭제되도록 처리
      $(this).remove();
      updategameInput();
      console.log("인풋"+$("#gametitle").val());
    });
 });
  </script>



<%-- 체크 에디터 라이브러리 --%>
  <script src="${path}/ckeditor/ckeditor.js"></script>

</head>

<body>
<%@include file="../include/top.jsp" %>

<%--검색 폼--%>
<form name="gameTitleSearch" method="post" action="${path}/review/reviewlist.do">
  <input type="hidden" name="searchTitle" id="searchTitleHidden">
</form>

<div id="contents">
  <div id="contentsHeader">
    <h2>글쓰기</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 커뮤니티 &gt 글쓰기
  </div>

  <div id="contentsMain">



    <%--리뷰 수정 페이지--%>
    <form name="reviewInsertSave" method="get" action="${path}/review/reviewinsertsave.do">
      <input type="hidden" name="freeFlag" value="${freeFlag}">
      <input type="hidden" name="gameGnum" id="gameGnum">
      <button type="button" onclick="btnList()">목록</button>
      <button type="button" id="btnsave" onclick="btnSaveClick()">저장</button>

      <c:forEach items="${list}" var="vo">
        <input type="hidden" name="regNum" value="${vo.regNum}">

          <p>카테고리 : <%--<input type="text" name="category" value="${vo.category}">--%>
            <select id="category" name="category" size="1">
              <c:if test='${"Y" eq freeFlag}'>
              <option value="자유게시판" <c:if test='${"자유게시판" eq vo.category}'>selected</c:if>>자유게시판</option>
              </c:if>
              <c:if test='${"N" eq freeFlag}'>
                <option value="게임후기" <c:if test='${"게임후기" eq vo.category}'>selected</c:if>>게임후기</option>
                <option value="노하우" <c:if test='${"노하우" eq vo.category}'>selected</c:if>>노하우</option>
                <option value="질문" <c:if test='${"질문" eq vo.category}'>selected</c:if>>질문</option>
              </c:if>
            </select>
          </p>



      <p>제목 : <input type="text" name="title" value="${vo.title}"></p>

        <%--게임 검색--%>
        <div align="left" <%--style="border: 1px solid goldenrod;"--%>>
          <div id="selectedGame">
            <c:forEach items="${gameList}" var="gl" varStatus="status">
              <div class="selected-value cursor_pointer" name="selectedGame" item="${gl.gnum}">${gl.gametitle}</div>
            </c:forEach>
          </div>
          <input type="hidden" name="gametitle" id="gametitle">
          <p>게임 : <input name="inputGame" class="input_game" autocomplete="off" placeholder="게임명을 검색 하세요."></p>
          <div id="gametitleSuggestions" style="width: 300px;	background-color: white; overflow-y: auto;"></div>
        </div>



<%--      <p>게임ID(임시) : <input type="text" name="gnum" value="${vo.gnum}"></p>--%>
      <%--<p>모임ID(임시) : <input type="text" name="gatheringId" value="${vo.gatheringId}"></p>--%>

      <p>작성자 : <input type="text" name="createUser" value="${vo.nickName}"  readonly/></p>

      <%-- 체크 에디터 적용 테스트 --%>
      <p>리뷰작성<textarea name = "reviewDetail" id="reviewDetailID" rows = "5" cols = "80">${vo.reviewDetail}</textarea></p>
        <script>
          //id가 description인 태그에 ckeditor를 적용시킴
          //이미지 업로드 안됨
          CKEDITOR.replace("reviewDetailID",{
            //이미지 업로드 기능을 추가하기위한 코드
            filebrowserUploadUrl : "${path}/imageUpload.do"
          });
        </script>


        <%--리뷰 첫 입력 페이지--%>
      </c:forEach>
      <c:if test="${fn:length(list) == 0}">
        <p>카테고리 : <%--<input type="text" name="category">--%>
        <select id="category" name="category" size="1">
          <option value="">선택하세요.</option>
          <c:if test='${"Y" eq freeFlag}'>
            <option value="자유게시판">자유게시판</option>
          </c:if>
          <c:if test='${"N" eq freeFlag}'>
            <option value="게임후기">게임후기</option>
            <option value="노하우">노하우</option>
            <option value="질문">질문</option>
          </c:if>
        </select>
        </p>
        <p>제목 : <input type="text" name="title"></p>

        <%--게임 검색--%>
        <div align="left" <%--style="border: 1px solid goldenrod;"--%>>
          <div id="selectedGame"></div>
          <input type="hidden" name="gametitle" id="gametitle">
          <p>게임 : <input name="inputGame" class="input_game" autocomplete="off" placeholder="게임명을 검색 하세요."></p>
          <div id="gametitleSuggestions" style="width: 300px;	background-color: white; overflow-y: auto;"></div>
        </div>


       <%--로그인 아이디 불러오기--%>
        <c:forEach items="${list}" var="vo">
        <p><input type="text" name="createUser" value="${vo.nickName}"></p>
        </c:forEach>

        <%-- 체크 에디터 적용 테스트 --%>
        <p>리뷰작성<textarea name = "reviewDetail" id="reviewDetailID2" rows = "5" cols = "80"></textarea></p>
        <script>
          //id가 description인 태그에 ckeditor를 적용시킴
          //이미지 업로드 안됨
          CKEDITOR.replace("reviewDetailID2",{
            //이미지 업로드 기능을 추가하기위한 코드
            filebrowserUploadUrl : "${path}/imageUpload.do"
          });
        </script>

      </c:if>
    </form>


  </div>


</div>
<%--!!!F;O;O;T;E;R 첨부해주세요--%>
<%@include file="../include/footer.jsp" %>
</body>
</html>