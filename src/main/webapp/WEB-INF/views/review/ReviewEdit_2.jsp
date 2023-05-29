<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>커뮤니티 - 리뷰수정</title>
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

<%--  <script type="text/javascript">
  function btnSaveClick() {
  alert("asdsadasd"); // 테스트
  document.revieweditsave.submit();
  }
  </script>--%>

</head>

<body>
<%@include file="../include/top.jsp" %>

<div id="contents">
  <div id="contentsHeader">
    <h2>리뷰수정</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 커뮤니티 &gt 리뷰수정
  </div>

  <div id="contentsMain">

    <form name="formReviewEditSave" method="post" action="${path}/review/revieweditsave.do">

      <table>
        <c:forEach items="${list}" var="vo">
          <script>
            alert(${list})
          </script>
          <tr><td>카테고리 : <input type="text" name="category" placeholder="${vo.category}"></td></tr>
          <tr><td>카테고리 : <input type="text" name="category"></td></tr>
          <tr><td>제목 : <input type="text" name="title"></td></tr>
          <tr><td>임시입력_gnum, 게임ID : <input type="text" name="gnum"></td></tr>
          <tr><td>임시입력_gatheringId, 모임ID : <input type="text" name="gatheringId"></td></tr>
          <tr><td>리뷰점수 : <input type="text" name="reviewScore"></td></tr>
          <tr><td>난이도 : <input type="text" name="gameScore"></td></tr>
          <tr><td>임시입력_ID : <input type="text" name="createUser"></td></tr>
          <tr><td>리뷰작성 : <input type="text" name="reviewDetail"></td></tr>
        </c:forEach>
      </table>

<%--
      <table border="1" width="700px">
      <c:forEach items="${list}" var="vo">
      <p>카테고리 : <input type="text" name="category" placeholder="${vo.category}"></p>
      <p>제목 : <input type="text" name="title" placeholder="${vo.title}"></p>
      <p>임시입력_gnum, 게임ID : <input type="text" name="gnum" placeholder="${vo.gnum}"></p>
      <p>임시입력_gatheringId, 모임ID : <input type="text" name="gatheringId" placeholder="${vo.gatheringId}"></p>
      <p>리뷰점수 : <input type="text" name="reviewScore" placeholder="${vo.reviewScore}"></p>
      <p>난이도 : <input type="text" name="gameScore" placeholder="${vo.gameScore}"></p>
      <p>임시입력_ID : <input type="text" name="createUser" placeholder="${vo.createUser}"></p>
      <p>리뷰작성 : <input type="text" name="reviewDetail" placeholder="${vo.reviewDetail}"></p>

      <button type="button" id="btnsave" onclick="btnSaveClick()">값 보내기</button>
      </c:forEach>
      </table>
--%>

    </form>

  </div>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>