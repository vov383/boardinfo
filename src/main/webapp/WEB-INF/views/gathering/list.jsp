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

    #filter div{
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

    form[name="gatheringSearchForm"]{
      margin: 0 auto;
    }


    form[name="gatheringSearchForm"] select{
      width: 110px;
      height: 33px;
      margin-right: 5px;
      font-size: 17px;
      padding-left: 8px;

    }

    form[name="gatheringSearchForm"] input[type="text"]{
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

    $(function(){

      $("#showAvailable").change(function(){
        document.formGatheringSearch.submit();
      });

      $("input[name='address1']").change(function(){
        document.formGatheringSearch.submit();
      });

    });


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
      <div>
        <h3>지역</h3>
        <ul>
          <c:forEach var="address1" items="address1List" varStatus="status">
            <li>
              <input type="checkbox" name="address1" id="${status.index}"
            </li>
          </c:forEach>
          <li></li>
        <li><input type="checkbox" name="address1" id="all" value="all">
          <label for="all">전체</label></li>
        <li><input type="checkbox" name="address1" id="seoul" value="서울">
          <label for="seoul">서울</label></li>
        <li><input type="checkbox" name="address1" id="busan" value="부산">
          <label for="busan">부산</label></li>
        <li><input type="checkbox" name="address1" id="daegu" value="대구">
          <label for="daegu">대구</label></li>
        <li><input type="checkbox" name="address1" id="incheon" value="인천">
          <label for="incheon">인천</label></li>
        <li><input type="checkbox" name="address1" id="gwangju" value="광주">
          <label for="gwangju">광주</label></li>
        <li><input type="checkbox" name="address1" id="daejun" value="대전">
          <label for="daejun">대전</label></li>
        <li><input type="checkbox" name="address1" id="ulsan" value="울산">
          <label for="ulsan">울산</label></li>
        <li><input type="checkbox" name="address1" id="gyeonggi" value="경기">
          <label for="gyeonggi">경기</label></li>
        <li><input type="checkbox" name="address1" id="gangwon" value="강원">
          <label for="gangwon">강원</label></li>
        <li><input type="checkbox" name="address1" id="chungbuk" value="충북">
          <label for="chungbuk">충북</label></li>
        <li><input type="checkbox" name="address1" id="chungnam" value="충남">
          <label for="chungnam">충남</label></li>
        <li><input type="checkbox" name="address1" id="junbuk" value="전북">
          <label for="junbuk">전북</label></li>
        <li><input type="checkbox" name="address1" id="junnam" value="전남">
          <label for="junnam">전남</label></li>
        <li><input type="checkbox" name="address1" id="gyeongbuk" value="경북">
          <label for="gyeongbuk">경북</label></li>
        <li><input type="checkbox" name="address1" id="gyeongnam" value="경남">
          <label for="gyeongnam">경남</label></li>
        <li><input type="checkbox" name="address1" id="jeju" value="제주">
          <label for="jeju">제주</label></li>
        <li><input type="checkbox" name="address1" id="sejong" value="세종">
          <label for="sejong">세종</label></li>
        </ul>
      </div>
      <div>
        <h3>기간</h3>
        <div>
        <input type="date">
        <span>~</span>
        <input type="date">
          <div>
            <button type="button" id="dateResetBtn">초기화</button>
            <button type="button" id="dateSubmitBtn">검색</button>
          </div>
        </div>
      </div>
      </form>
    </div>

    <div id="listArea">

      <form name="gatheringSearchForm">
        <select>
          <option>전체</option>
          <option>제목</option>
          <option>내용</option>
          <option>글쓴이</option>
        </select>
        <input type="text" name="keyword">
        <button type="button" id="gatheringSearchBtn">검색</button>
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
	              <fmt:formatDate value="${post.gathering_date}" pattern="M.d a h:mm"/>
	          </span>
            </div>
          </div>
          <div class="postLower">
            <span>${post.writer_id}</span>
            <span><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd"/></span>
            <span>조회 ${post.view_count}</span>
            <span>댓글 12</span>
          </div>
        </div>     	
      	</c:forEach>


      </div>




    </div>
  </div>
</div>

<%@include file="../include/footer.jsp" %>


</body>
</html>