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

    #contentsMain{
      border-top: 2px solid black;
    }

    .titleArea{
      margin-top: 20px;
      display: flex;
    }

    select[name='category']{
      min-width: 180px;
      margin-right: 5px;
    }

    input[name='title']{
      width: 100%;
    }

    input[name='gametitle'] + span{
      padding-left: 5px;
      display: inline-block;
      margin-top: 20px;
      width: 150px;
    }

    #selectedGame{
      padding: 5px;
    }

    .deleteGame{
      color: #C53A32;
      cursor: pointer;
    }

    #buttonSet{
      text-align: center;
    }

    button[id*="btn"]{
      cursor: pointer;
      width: 82px;
      height: 34px;
      font-size: 16px;
      font-weight: bold;
      border-radius: 0;
    }

    #btnsave{
      background-color: #F9841A;
      color: white;
      border: 0;
    }

    #btnlist{
      border: 1px solid black;
      background-color: white;
      margin-right: 10px;
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

      $("#selectedGame").append("<div class='selected-value cursor_pointer' name='selectedGame' item='"+
              $(this).attr("item")+"'>" + selectedGame
              +"<span class='deleteGame'>&nbsp;x</span></div>");
      console.log("배열"+selectedGames);
      $('input[name="inputGame"]').val("");
      $("#gametitleSuggestions").empty().hide();
      updategameInput();
      console.log("인풋"+$("#gametitle").val());
    });
    // 선택된 값 클릭 이벤트 처리

    $("#selectedGame").on("click", ".deleteGame", function() {
      var value = $(this).closest(".selected-value").text();
      // 선택된 값 배열에서 해당 값을 제거
      selectedGames = selectedGames.filter(function(selected) {
        return selected !== value;
      });
      // 선택된 값 표시가 삭제되도록 처리
      $(this).closest(".selected-value").remove();
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
    <h2>커뮤니티</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 커뮤니티 &gt 글등록
  </div>

  <div id="contentsMain">
    <%--리뷰 수정 페이지--%>
    <form name="reviewInsertSave" method="get" action="${path}/review/reviewinsertsave.do">
      <input type="hidden" name="freeFlag" value="${freeFlag}">
      <input type="hidden" name="gameGnum" id="gameGnum">

      <c:forEach items="${list}" var="vo">
        <input type="hidden" name="regNum" value="${vo.regNum}">

        <div class="titleArea">
          <select id="category" name="category" size="1">
            <option value="">카테고리</option>
            <c:choose>
              <c:when test="${freeFlag eq 'Y'}">
                <option value="자유게시판" <c:if test='${"자유게시판" eq vo.category}'>selected</c:if>>자유게시판</option>
              </c:when>
              <c:when test="${freeFlag eq 'N'}">
                <option value="게임후기" <c:if test='${"게임후기" eq vo.category}'>selected</c:if>>게임후기</option>
                <option value="노하우" <c:if test='${"노하우" eq vo.category}'>selected</c:if>>노하우</option>
                <option value="질문" <c:if test='${"질문" eq vo.category}'>selected</c:if>>질문</option>
              </c:when>
              <c:otherwise>
                <option value="게임후기" <c:if test='${"게임후기" eq vo.category}'>selected</c:if>>게임포럼 > 게임후기</option>
                <option value="노하우" <c:if test='${"노하우" eq vo.category}'>selected</c:if>>게임포럼 > 노하우</option>
                <option value="질문" <c:if test='${"질문" eq vo.category}'>selected</c:if>>게임포럼 > 질문</option>
                <option value="자유게시판" <c:if test='${"자유게시판" eq vo.category}'>selected</c:if>>자유게시판</option>
              </c:otherwise>
            </c:choose>
          </select>
          <input type="text" name="title" value="${vo.title}" placeholder="제목">
        </div>

        <%--게임 검색--%>
        <div align="left" <%--style="border: 1px solid goldenrod;"--%>>
          <input type="hidden" name="gametitle" id="gametitle">
          <span>게임첨부(선택사항)</span><input name="inputGame" class="input_game" autocomplete="off" placeholder="게임명을 검색하세요.">
          <div id="gametitleSuggestions" style="width: 300px;	background-color: white; overflow-y: auto;"></div>
          <div id="selectedGame">
            <c:forEach items="${gameList}" var="gl" varStatus="status">
              <div class="selected-value cursor_pointer" name="selectedGame" item="${gl.gnum}">${gl.gametitle}
                <span class="deleteGame">x</span></div>
            </c:forEach>
          </div>
        </div>


<%--      <p>게임ID(임시) : <input type="text" name="gnum" value="${vo.gnum}"></p>--%>
      <%--<p>모임ID(임시) : <input type="text" name="gatheringId" value="${vo.gatheringId}"></p>--%>

      <input type="hidden" name="createUser" value="${vo.nickName}"  readonly/>

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

        <div class="titleArea">
        <select id="category" name="category" size="1">
          <option value="">카테고리</option>
          <c:choose>
            <c:when test="${freeFlag eq 'Y'}">
              <option value="자유게시판" <c:if test='${"자유게시판" eq vo.category}'>selected</c:if>>자유게시판</option>
            </c:when>
            <c:when test="${freeFlag eq 'N'}">
              <option value="게임후기" <c:if test='${"게임후기" eq vo.category}'>selected</c:if>>게임후기</option>
              <option value="노하우" <c:if test='${"노하우" eq vo.category}'>selected</c:if>>노하우</option>
              <option value="질문" <c:if test='${"질문" eq vo.category}'>selected</c:if>>질문</option>
            </c:when>
            <c:otherwise>
              <option value="게임후기" <c:if test='${"게임후기" eq vo.category}'>selected</c:if>>게임포럼 > 게임후기</option>
              <option value="노하우" <c:if test='${"노하우" eq vo.category}'>selected</c:if>>게임포럼 > 노하우</option>
              <option value="질문" <c:if test='${"질문" eq vo.category}'>selected</c:if>>게임포럼 > 질문</option>
              <option value="자유게시판" <c:if test='${"자유게시판" eq vo.category}'>selected</c:if>>자유게시판</option>
            </c:otherwise>
          </c:choose>
        </select>
        <input type="text" name="title" placeholder="제목">
        </div>

        <%--게임 검색--%>
        <div align="left" <%--style="border: 1px solid goldenrod;"--%>>
          <input type="hidden" name="gametitle" id="gametitle">
          <span>게임첨부(선택사항)</span><input name="inputGame" class="input_game" autocomplete="off" placeholder="게임명을 검색하세요.">
          <div id="gametitleSuggestions" style="width: 300px;	background-color: white; overflow-y: auto;"></div>
          <div id="selectedGame"></div>
        </div>


       <%--로그인 아이디 불러오기--%>
        <c:forEach items="${list}" var="vo">
        <p><input type="text" name="createUser" value="${vo.nickName}"></p>
        </c:forEach>

        <%-- 체크 에디터 적용 테스트 --%>
        <p><textarea name = "reviewDetail" id="reviewDetailID2" rows = "5" cols = "80"></textarea></p>
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

      <div id="buttonSet">
        <button type="button" onclick="btnList()" id="btnlist">목록</button>
        <button type="button" id="btnsave" onclick="btnSaveClick()">저장</button>
      </div>
  </div>


</div>

<%@include file="../include/footer.jsp" %>
</body>
</html>