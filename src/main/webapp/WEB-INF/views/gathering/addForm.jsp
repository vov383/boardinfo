<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>글쓰기 - 모임모집</title>
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

  <script>

    $(function(){

      $('input[name=attendSystem]').change(function(){

        if($("input[name=attendSystem]:checked").val()=="p"){
          $("#hiddenQuestion").css("visibility", "visible");
        }

        else{
          $("#hiddenQuestion").css("visibility", "hidden");
          $("input[name=question]").val("");
        }

      });

    });
    
    
    
    function add(){
    	
    	let title = $("#title").val().trim();
    	$("#title").val(title);
    	if(title==''){
    		alert('제목을 입력하세요');
    		$("#title").focus();
    		window.scrollTo(0, 0);
    		return;
    	}
    	
    	/*
    	let locationFull = $("#locationFull").val();
    	if(locationFull==''){
    		alert('검색 버튼을 눌러 장소를 선택해주세요.');
    		window.scrollTo(0, 0);
    		return;
    	}
    	*/
    	

    	
    	let offerdate = $("#gathering_date").val();
    	
    	if(offerdate==''){
    		alert('모임 날짜를 선택해주세요.');
    		$("#gathering_date").focus();
    		window.scrollTo(0, 50);
    		return;
    	}
    	
    	let index = offerdate.indexOf('T');
    	offerdate = offerdate.substr(0, index) + ' ' + offerdate.substr(index+1);
    	
    	let date1 = new Date();
    	date1.setDate(date1.getMinutes() + 30);
    	let minDate = getFormatDate(date1);
    	
    	let date2 = new Date();
    	date2.setDate(date2.getDate() + 60);
    	date2.setMinutes(23);
    	date2.setHours(59);
    	let maxDate = getFormatDate(date2);
    	
    	if(offerdate < minDate){
    		alert('현재로부터 최소 30분 이후의 일정만 만들 수 있습니다.');
    		$("#gathering_date").focus();
    		window.scrollTo(0, 50);
    		return;  		
    	}
    	
    	if(offerdate > maxDate){
    		alert('모임 날짜는 2개월 이내까지 설정 가능합니다.');
    		$("#gathering_date").focus();
    		window.scrollTo(0, 50);
    		return;  		
    	}
    	
    	
    	let maxPeople = $("#maxPeople");
    	if(isNaN(maxPeople.val())){
    		alert('모임에 초대할 최대 인원을 선택해주세요.');
    		maxPeople.val(2);
    		maxPeople.focus();
    		window.scrollTo(0, 50);
    		return;  	    		
    	}
    	
    	else if(maxPeople.val() < 2 || maxPeople.val() > 30){
    		alert('설정 가능한 참석 인원은 최소 2명, 최대 30명입니다.');
    		maxPeople.focus();
    		window.scrollTo(0, 50);
    		return;  	    		
    	}
    	
    	
    	if($("#permit").is(':checked')){
    		let question = $("#question").val().trim();
    		$("#question").val(question);
    		if(question == ''){
    			alert('승인제를 선택하셨습니다.\n모임을 신청하려는 보드인들에게 묻고 싶은 질문을 입력해주세요.');
    			$("#question").focus();
        		window.scrollTo(0, 100);
    		}
    		
    	}
    	
    	
    	let description = $("#description").val().trim();
    	$("#description").val(description);
    	if(description==''){
    		alert('모임 소개글을 입력하세요');
    		$("#description").focus();
    		window.scrollTo(0, 200);
    		return;
    	}
    	
    	
    	document.gatheringAddForm.submit();
    	
    }
    
    
    function getFormatDate(date){
    	var year = date.getFullYear();
    	var month = (1+date.getMonth());
    	month = month >= 10? month: '0'+month;
    	var day = date.getDate();
    	day = day >= 10? day : '0' + day;
    	var hour = date.getHours();
    	hour = hour >= 10? hour : '0' + hour;
    	var minute = date.getMinutes();
    	minute = minute >= 10? minute : '0' + minute;
    	return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
    }
    

	function locationSearch(){
    	
    	let top = screen.availHeight/2 - 290;
		if(top < 0) top = 0;

		let left = screen.availWidth/2 - 410;
		if(left < 0) left = 0
		
    	window.open("${path}/gathering/locationSearch.do", "날짜검색 - 모임모집", "left="+left+", top="+top+", width=820, height=580");
    }
    

  </script>


</head>
<body>
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

<div id="contents">
  <div id="contentsHeader">
    <h2>모임모집</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 오프모임 &gt 모임모집  
  </div>
  <div id="contentsMain">
    <form name="gatheringAddForm" method="post" action="${path}/gathering/add.do">
      <div id="postUpper">
        <div>
          <div id="map"></div>
          <div id="tmpDiv"><span>장소를 입력하세요.</span></div>
        </div>
        <div>
          <div class="labelAndItem"><span>제목</span>
          <input class="flex" name="title" id="title"></div>
          <div class="labelAndItem"><span>장소</span>
            <input class="flex" disabled id="locationFull">
	          <input type="hidden" name="location1">
	          <input type="hidden" name="location2">
	          <input type="hidden" name="location3">                    
	          <input type="hidden" name="place_name">
	          <input type="hidden" name="lat">
	          <input type="hidden" name="lng">            
            <button type="button" id="locationSearchBtn" onclick="locationSearch()">검색</button></div>
          <div class="labelAndItem"><span>일시</span>
           <input type="datetime-local" name="gathering_date" id="gathering_date">
           <span class="flex" style="text-align: right;">*30분 이후 ~ 2개월 이내만 가능</span>
          </div>
          <div class="labelAndItem">
            <span>유의사항</span>
            <input class="flex" placeholder="예시) 각자 게임 하나씩 가져오기로 해요~" name="note"></div>
          <div class="labelAndItem">
            <span>최대인원</span>
            <input type="number" min="2" max="30" value="2" name="maxPeople" id="maxPeople"><span>명</span>
            <span class="flex" style="text-align: right;">*최소 2명~최대 30명</span>
          </div>
          <div class="labelAndItem">
            <span>참가방식</span>
            <div class="flex">
              <div>
                <input type="radio" name="attendSystem" value="o" checked id="order">
                <label for="order">선착순</label>
                <input type="radio" name="attendSystem" value="p" id="permit">
                <label for="permit">승인제</label>
              </div>
              <div id="hiddenQuestion">
                <div>보드인에게 묻고 싶은 질문을 입력하세요. (참가신청 시 제출)</div>
                <input name="question" id="question" placeholder="예시) 가장 좋아하는 게임은 무엇인가요?">
              </div>
            </div>
          </div>
      </div>
      </div>
      <div id="postMain">
        <div>
          <button type="button" id="btn-attachGame">게임첨부</button>
        </div>
        <textarea id="description" name="description" placeholder="모임을 자유롭게 소개해보세요."></textarea>
        <ul>
          <li>참가인원이 모두 모이면 '모집완료', 모임시간이 되면 '모임종료'로 변경됩니다.</li>
          <li>소외되는 보드인 없이 모두가 즐거운 모임이 될 수 있게 노력해주세요.</li>
          <li>모임에서 사이트 운영정책에 어긋나는 행위를 하는 경우 이용재제가 가해질 수 있습니다.</li>
        </ul>
        <div>
          <button type="button" id="btn-submit" onclick="add()">등록</button>
          <button type="button" id="btn-reset">돌아가기</button>
        </div>

      </div>
    </form>
  </div>
</div>

<footer>
  <div>
    서울특별시 강남구 테헤란로14길 6 남도빌딩 2,3F<br>
    KH정보교육원 TEAM BOARDINFO
  </div>
</footer>

</body>
</html>