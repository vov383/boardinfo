<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>모임모집</title>
  <%@ include file="../include/js/header.jsp" %>

  <style>
    #filter{
      float: left;
      width: 180px;
      border: 1px solid #D9D9D9;
      border-radius: 18px;
      margin-right: 30px;
      margin-top: 52px;
    }

    #filter h3{
      margin: 0 0 10px 0;
      padding: 0;
    }

    #filter > form > div{
      padding: 13px 20px;
      border-bottom: 1px solid #D9D9D9;
    }

    #filter input[type="checkbox"]{
      margin-right: 10px;
    }

    #filter ul{
      margin: 0;
      padding: 0;
      list-style: none;
    }

    #filter li{
      margin-bottom: 4px;
    }

    #filter input[type="date"]{
      width: 100%;
    }


    #filter div:last-of-type{
      border-bottom: none;
    }

    #filter div:last-of-type > div{
      display: flex;
      flex-direction: column;
      margin-top: 10px;
      padding: 0;
      align-items: center;
    }


    #filter div:last-of-type > div > div{
      display: flex;
      flex-direction: row;
      justify-content: end;
      width: 100%;
    }

    #dateResetBtn{
      margin-right: 10px;
    }

    #listArea{
      flex-grow: 1;
      display: flex;
      flex-direction: column;
    }

    #keywordForm{
      margin: 0 auto;
    }


    #keywordForm select{
      width: 110px;
      height: 33px;
      margin-right: 5px;
      font-size: 17px;
      padding-left: 8px;

    }

    #keywordForm input[type="text"]{
      padding-left: 8px;
      width: 300px;
      height: 33px;
      margin-right: 5px;
      margin-bottom: 20px;
      font-size: 17px;
    }

    #gatheringSearchBtn{
      width: 96px;
      height: 33px;
      font-weight: bold;
      background-color: #1432B1;
      color: white;
      border: none;
      font-size: 17px;
    }

    .gatheringPost{
      width: 100%;
      border: 1px solid #D9D9D9;
      padding: 0 30px;
      margin-bottom: 12px;
    }

    .postUpper{
      border-bottom: 1px solid #D9D9D9;
      padding: 18px 0 12px 0;
    }

    .profile{
      margin-bottom: 12px;
    }

    .status{
      width: 85px;
      border: 1px solid black;
      border-radius: 10px;
      padding: 0 10px;
      margin-right: 6px;
    }

    .title{
      font-weight: bold;
      font-size: 17px;
      color: black;
      text-decoration: none;
    }

    .title:hover{
      text-decoration: underline;
    }


    .numPeople{
      margin-left: 7px;
      font-weight: bold;
      color: #C53A32;
      font-size: 15px;
    }

    .detail{
      display: flex;
      align-items: center;
    }

    .location, .dateTime{
      display: flex;
      align-items: center;
    }

    .detail img{
      margin-right: 4px;
    }

    .location{
      margin-right: 8px;
    }

    .postLower{
      text-align: right;
      display: flex;
      justify-content: right;
      padding: 8px 0;
    }

    .postLower span{
      min-width: 60px;
      padding: 0 8px;
      text-align: center;
      border-right: 1px solid black;
    }

    .postLower span:last-of-type{
      border: none;
      padding-right: 0;
    }

    #paginationArea{
      display: flex;
      margin: 20px auto 0 auto;
    }

    .pageItem{
      width: 35px;
      height: 35px;
      border-radius: 10px;
      line-height: 35px;
      text-align: center;
      margin: 0 3px;
      font-size: 1.2em;
    }

    .pageItem:hover{
      cursor: pointer;
    }

    .pageItem:not(#curPage):hover{
      background-color: #D9D9D9;
    }

    #curPage{
      border: 2px solid #1432B1;
      color: #1432B1;
      line-height: 31px;
    }
    /*
    #curPage:hover{
      background-color: #1432B1;
      color: white;
    }
    */

    footer{
      font-size: 15px;
      color: #DFDFDF;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding-left: 200px;
      height: 190px;
      background-color: #3D3D43;
      bottom: 0;
      clear: both;
    }


  </style>


  <script>

    window.onpageshow = function (event) {
      $("form[name='FormGatheringSearch']").find("input").attr("disabled", false);
    }

    $(function(){


      $("#showAvailable").change(function(){
        document.formGatheringSearch.submit();
      });

      $("input[name='address1']").change(function(){

        if($(this).val()!='전체'){
          $("input[name='address1']:input[value='전체']").prop("checked", false);
        }

        document.formGatheringSearch.submit();
      });

      $("input[name='from']").change(function(){

        let to = $("input[name='to']");

        if(to.val()!=''){
          if($(this).val() > to.val()){
            to.val($(this).val());
          }
        }
      });


      $("input[name='to']").change(function(){

        let from = $("input[name='from']");

        if(from.val()!=''){
          if($(this).val() < from.val()){
            from.val($(this).val());
          }
        }
      });


      $("#dateResetBtn").click(function(){

        $("input[name='from']").val('');
        $("input[name='to']").val('');
        document.formGatheringSearch.submit();

      });


    });


    function list(curPage){
      //queryString이 비어있는 경우는 어떡하지?
      let queryString = $("form[name='formGatheringSearch']").serialize() + '&curPage=' + curPage;
      location.href="${path}/gathering/list.do?" + queryString;
    }


    function searchByKeyword(){
      let keyword = $("#newKeyword");
      keyword.val(keyword.val().trim());
      if(keyword.val()=='') return;

      else{

        let data = {
          'option': $("#newOption").val(),
          'keyword': $("#newKeyword").val()
        };

        $("#oldKeyword").attr("disabled", true);
        $("#oldOption").attr("disabled", true);
        let queryString = $("form[name='formGatheringSearch']").serialize() + '&' + $.param(data);
        location.href = "${path}/gathering/list.do?" + queryString;
      }

    }



  </script>


</head>
<body>

<%@include file="../include/top.jsp" %>

<div id="contents">
  <div id="contentsHeader">
    <h2>모임모집</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 오프모임 &gt 모임모집
  </div>
  <div id="contentsMain">
    <div id="filter">
      <form name="formGatheringSearch" action="${path}/gathering/list.do">
        <input type="hidden" name="option" id="oldOption" value="${option}">
        <input type="hidden" name="keyword" id="oldKeyword" value="${keyword}">
        <div>
          <div>
          <c:choose>
            <c:when test="${showAvailable!=null && showAvailable==true}">
              <input type="checkbox" name="showAvailable" id="showAvailable" value="y" checked>
            </c:when>
            <c:otherwise>
              <input type="checkbox" name="showAvailable" id="showAvailable" value="y">
            </c:otherwise>
          </c:choose>
          <label for="showAvailable">모집중만 보기</label>
          </div>
        </div>
        <div>
          <h3>지역</h3>
          <ul>
            <c:forEach var="address1" items="${address1List}" varStatus="status">
              <li>
                <input type="checkbox" name="address1" id="${status.index}" value="${address1}" checked="checked">
                <label for="${status.index}">${address1}</label>
              </li>
            </c:forEach>


            <c:forEach var="address1" items="${koreanAddress1List}" varStatus="status">
              <li>
                <input type="checkbox" name="address1" id="${status.index+fn:length(address1List)}" value="${address1}">
                <label for="${status.index+fn:length(address1List)}">${address1}</label>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div>
          <h3>모임날짜</h3>
          <div>
            <input type="date" name="from" value="${from}">
            <span>~</span>
            <input type="date" name="to" value="${to}">
            <div>
              <button type="button" id="dateResetBtn">초기화</button>
              <button type="submit" id="dateSubmitBtn">검색</button>
            </div>
          </div>
        </div>
      </form>
    </div>

    <div id="listArea">
      <form name="keywordSearchForm" id="keywordForm">
        <select name="option" id="newOption">
        <c:choose>
          <c:when test="${option=='title'}">
            <option value="all">전체</option>
            <option value="title" selected>제목</option>
            <option value="gathering_content">내용</option>
            <option value="writer">글쓴이</option>
          </c:when>
          <c:when test="${option=='gathering_content'}">
            <option value="all">전체</option>
            <option value="title" selected>제목</option>
            <option value="gathering_content" selected>내용</option>
            <option value="writer">글쓴이</option>
          </c:when>
          <c:when test="${option=='writer'}">
            <option value="all">전체</option>
            <option value="title">제목</option>
            <option value="gathering_content">내용</option>
            <option value="writer" selected>글쓴이</option>
          </c:when>
          <c:otherwise>
            <option value="all" selected>전체</option>
            <option value="title">제목</option>
            <option value="gathering_content">내용</option>
            <option value="writer">글쓴이</option>
          </c:otherwise>
        </c:choose>

        </select>
        <input type="text" name="keyword" id="newKeyword" value="${keyword}">
        <button type="button" id="gatheringSearchBtn" onclick="searchByKeyword()">검색</button>
      </form>

      <div id="gatheringList">
        <c:forEach var="post" items="${list}">
          <div class="gatheringPost">
            <div class="postUpper">
              <div class="profile">
                <span class="status">${post.status}</span>
                <span>
              <a class="title" href="${path}/gathering/view/${post.gathering_id}">${post.title}</a>
              </span>
                <span class="numPeople">(3/${post.maxPeople}명)</span>
              </div>
              <div class="detail">
                <span class="location"><img src="${path}/images/location_pin.png" width="18px">${post.address1} ${post.address2}</span>
                <span class="dateTime">
	              <img src="${path}/images/date.png" width="18px">
                  <fmt:parseDate value="${post.gathering_date}"
                                 pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
	              <fmt:formatDate value="${parsedDateTime}" pattern="M.d a h:mm"/>
	          </span>
              </div>
            </div>
            <div class="postLower">
              <span>${post.writer_id}</span>
              <span><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd"/></span>
              <span>조회 ${post.view_count}</span>
              <span>댓글 ${post.reply_count}</span>
            </div>
          </div>
        </c:forEach>
      </div>

      <div id="paginationArea">
        <c:if test="${page.curPage > 1}">
          <div class="pageItem" onclick="list(1)">&lt&lt</div>
        </c:if>
        <c:if test="${page.curBlock > 1}">
          <div class="pageItem" onclick="list(${page.prevBlock})">&lt</div>
        </c:if>
        <c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
          <c:choose>
            <c:when test="${num == page.curPage}">
              <div id="curPage" class="pageItem" onclick="list(${num})">${num}</div>
            </c:when>
            <c:otherwise>
              <div class="pageItem" onclick="list(${num})">${num}</div>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${page.curBlock < page.totBlock}">
          <div class="pageItem" onclick="list(${page.nextBlock})">&gt</div>
        </c:if>
        <c:if test="${page.curPage < page.totPage}">
          <div class="pageItem" onclick="list(${page.totPage})">&gt&gt</div>
        </c:if>
      </div>

    </div>


  </div>
</div>

<%@include file="../include/footer.jsp" %>


</body>
</html>