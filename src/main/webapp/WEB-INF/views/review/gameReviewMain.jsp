<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>커뮤니티 - 게임리뷰</title>
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


    table{border-collapse:collapse; background-color:#fff8e1}
    tr, td{border-color: #ffffff; border-style: solid;}
    tr:nth-child(1n+2){background-color: #ffffff;}

/*    !*짝수줄만 배경색을 다르게*!
    tr:nth-child(2n+0){background-color: #ffffaf;}*/


  </style>

  <script>
    /*검색 스크립트*/
    function searchFu(nowPage) {
      $("#searchTitleHidden").val($("#searchTitle").val());
      $("#nowPage").val(nowPage);
      //alert($("#searchTitleHidden").val());
      document.reviewSearch.submit();
    }

    /*리뷰 글쓰기 진입*/
    function reviewInsert(regNum) {
      /*alert("버튼 잘 눌리는지 테스트")*/
      location.href="${path}/review/reviewInsert.do";
    }



    /*리뷰 디테일 진입, 조회수 증가*/
    function reviewDetail(regNum) {
      $("#reviewDetailKey").val(regNum);
      /*alert($("#reviewDetailKey").val());*/
      document.reviewDetail.submit();
    }



  </script>





</head>


<body>
<%@include file="../include/top.jsp" %>

<%--검색 폼--%>
<form name="reviewSearch" method="post" action="${path}/review/reviewlist.do">
  <input type="hidden" name="searchTitle" id="searchTitleHidden">
  <input type="hidden" name="nowPage" id="nowPage" value="1">
  <input type="hidden" name="cntPage" id="cntPage" value="10">
  <input type="hidden" name="cntPerPage" id="cntPerPage" value="10">
</form>

<%--디테일 진입 폼--%>
<form name="reviewDetail" method="post" action="${path}/review/reviewdetail.do">
  <input type="hidden" name="reviewDetailKey" id="reviewDetailKey">
</form>


<div id="contents">
  <div id="contentsHeader">
    <h2>커뮤니티</h2>
  </div>
  <div id="contentsLocation">
    홈&gt 커뮤니티&gt 게임리뷰
  </div>
  <div id="contentsMain">

    <%--검색 및 글쓰기 버튼--%>
    <div class="searchBox">
      <input type="text" id="searchTitle" placeholder="제목 및 내용을 검색하세요.">
      <button type="button" id="search" onclick="searchFu('1')">검색</button>
      <button type="button" onclick="reviewInsert()">글쓰기</button>
    </div>


    <%--본문--%>
    <form name="reviewlist" method="post" action="${path}/review/reviewlist.do">
      <table style="table-layout:fixed;">
        <tr>
          <th style="width: 200px;">카테고리</th>
          <th style="width: 200px;">&#x1f495</th> <%--좋아요--%>
          <th style="width: 200px;">제목</th>
          <th style="width: 200px;">닉네임</th>
          <th style="width: 200px;">등록일자</th>
          <th style="width: 200px;">&#128366;</th> <%--조회수--%>
          <th style="width: 200px;">댓글</th>
          <th style="width: 200px;">게임</th>
        </tr>

        <%--<script>
          console.log(<c:out value="${list}"></c:out>)
        </script>--%>
        <c:forEach items="${list}" var="vo">
          <tr>
            <td style="width: 200px; text-align: center;">${vo.category}</td>
            <td style="width: 200px; text-align: center;">${vo.good}</td>
            <td style="width: 200px; text-align: center;"><a href="javascript:reviewDetail('${vo.regNum}')">${vo.title}</a></td>
            <td style="width: 200px; text-align: center;">${vo.nickName}</td>
            <td style="width: 200px; text-align: center;">${vo.createDate}</td>
            <td style="width: 200px; text-align: center;">${vo.views}</td>
            <td style="width: 200px; text-align: center;">/댓글 연결 예정/</td>
            <td style="width: 200px; text-align: center;">${vo.gametitle}</td>

          </tr>
        </c:forEach>
      </table>
    </form>

<%--      private int nowPage;                 // 현재 페이지--%>
<%--      private int cntPage;                 // 화면 페이지 개수 (가로)--%>
<%--      private int cntPerPage;              // 쿼리 리스트 개수 (세로)--%>
<%--      private int total;                   // 쿼리 리스트 총 개수--%>
<%--      private int lastPage;                // 마지막 번호 (시작번호는 1로고정)--%>
<%--      private int startPage;               // 화면 페이지 가로 시작 번호--%>
<%--      private int endPage;                 // 화면 페이지 가로 마지막 번호--%>
<%--      private int start;                   // 쿼리 리스트 변수--%>
<%--      private int end;                     // 쿼리 리스트 변수--%>

       nowPage;   <c:out value="${page.nowPage   }"></c:out>
       cntPage;   <c:out value="${page.cntPage   }"></c:out>
       lastPage;  <c:out value="${page.lastPage  }"></c:out>
       startPage; <c:out value="${page.startPage }"></c:out>
       endPage;   <c:out value="${page.endPage   }"></c:out>


      <div class="paging-btn">
        <a href="">처음</a>
        <a href="">이전</a>

        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
          <a href="javascript:searchFu('${i}')">${i}</a>
        </c:forEach>

        <a href="">다음</a>
        <a href="">마지막</a>
      </div>

  </div>
</div>
<%--!!!F;O;O;T;E;R 첨부해주세요--%>
<%@include file="../include/footer.jsp" %>

</body>

</html>





