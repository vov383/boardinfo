<%@ page import="com.example.boardinfo.model.gathering.dto.GatheringDTO" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>글수정 - 오프모임</title>

  <%@ include file="../include/js/header.jsp" %>

  <style>

    #contentsMain{
      border-top: 2px solid black;
    }

    #postUpper{
      display: flex;
    }

    #postUpper > div:first-of-type{
      padding: 30px 0;
    }

    .map_wrap{
      position: relative;
      background-color: yellow;
    }

    #map{
      width: 400px;
      height: 280px;
      border: 1px solid black;
      text-align: center;
      line-height: 280px;
    }

    #map{
      overflow: hidden;
      /*display: none;*/
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

    #gathering_content{
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


    .title {
      font-weight:bold;
      display:block;
    }

    .hAddr {
      position:absolute;
      right:10px;
      bottom:10px;
      border-radius: 2px;
      background:#fff;
      background:rgba(255,255,255,0.8);
      z-index:1;
      padding:5px;
    }

    #centerAddr {
      display: block;
      margin-top: 2px;
      font-weight: normal;
    }

    #infoWindow{
      background-color: white;
      border: 1px solid black;
      border-radius: 6px;
      padding: 10px 10px;
    }

    #infoWindow > span{
      display: block;
      line-height: 16px;
      max-width: 300px;
      word-break: break-all;
    }



  </style>

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
  <script src="${path}/ckeditor/ckeditor.js"></script>
  <script>

    $(function(){

      if("${attendSystem}"=='p'){
        $("input[name=attendSystem][value='p']").attr("checked", "true");
      }

      else{
        $("input[name=attendSystem][value='o']").attr("checked", "true");
        $("#hiddenQuestion").css("visibility", "hidden");

      }


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


      let locationFull = $("#locationFull").val();
      if(locationFull==''){
        alert('검색 버튼을 눌러 장소를 선택해주세요.');
        window.scrollTo(0, 0);
        return;
      }


      let offerdate = $("#gathering_date").val();

      if(offerdate==''){
        alert('모임 날짜를 선택해주세요.');
        $("#gathering_date").focus();
        window.scrollTo(0, 50);
        return;
      }

      let index = offerdate.indexOf('T');
      offerdate = offerdate.substr(0, index) + ' ' + offerdate.substr(index+1);

      //수정 시 최소 날짜는 오늘 날짜가 아닌 최초 업로드 일자를 기준으로 판단
      let minDate = "${minDate}";

      //일단 최대 날짜는 '오늘' 기준으로 했는데 이것도 업로드 기준으로 바꿀지 고민중!
      //안그러면 계속해서 업데이트하려고 할 수도 있다
      let date2 = new Date();
      date2.setDate(date2.getDate() + 60);
      date2.setMinutes(23);
      date2.setHours(59);
      let maxDate = getFormatDate(date2);

      if(offerdate < minDate){
        alert('최초 게시일로부터 최소 30분 이후의 일정만 만들 수 있습니다.');
        $("#gathering_date").focus();
        window.scrollTo(0, 50);
        return;
      }

      if(offerdate > maxDate){
        alert('모임 날짜는 오늘로부터 2개월 이내까지 설정 가능합니다.');
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
          return;
        }

      }


      if(CKEDITOR.instances.gathering_content.getData().length < 1){
        alert("모임 소개글을 입력해 주세요.");
        $("#cke_gathering_content").focus();
        return;
      }


      document.gatheringEditForm.submit();

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

      window.open("${path}/gathering/locationSearch.do",
              "날짜검색 - 모임모집", "left="+left+", top="+top+", width=820, height=580");
    }

  </script>




</head>
<body>

<%@include file="../include/top.jsp" %>


<div id="contents">
  <div id="contentsHeader">
    <h2>오프모임</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 오프모임
  </div>
  <div id="contentsMain">
    <form name="gatheringEditForm" method="post" action="${path}/gathering/update.do">
      <div id="postUpper">
        <div>
          <div class="map_wrap">
            <div id="map"></div>
            <div class="hAddr">
              <span class="title">주소정보</span>
              <span id="centerAddr"></span>
            </div>
          </div>
          <script>
            let lat = "${dto.lat}";
            let lng = "${dto.lng}";

            let mapContainer = document.getElementById('map'); // 지도를 표시할 div

            let mapOption =
                    {
                      center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                      level: 3 // 지도의 확대 레벨
                    };

            // 지도를 생성합니다
            let map = new kakao.maps.Map(mapContainer, mapOption);

            // 주소-좌표 변환 객체를 생성합니다
            let geocoder = new kakao.maps.services.Geocoder();

            let imageSrc = 'https://img.freepik.com/icones-gratuites/espace-reserve_318-556820.jpg?w=360', // 마커이미지의 주소입니다
                    imageSize = new kakao.maps.Size(44, 48); // 마커이미지의 크기입니다

            // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
            let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            let mainMarker;

            let infoDiv = document.getElementById('centerAddr');

            let markerPosition = new window.kakao.maps.LatLng(lat, lng);
            mainMarker = new window.kakao.maps.Marker({
              position: markerPosition,
              image: markerImage
            });

            mainMarker.setMap(map);
            mainMarker.setZIndex(3);

            // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
            searchDetailAddrFromCoords(map.getCenter(), displayCenterInfo);


            function makeMap(getLat, getLng){

              lat = getLat;
              lng = getLng;
              mapOption =
                      {
                        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                        level: 4// 지도의 확대 레벨
                      };

              // 지도를 생성합니다
              map = new kakao.maps.Map(mapContainer, mapOption);

              //마커 생성
              markerPosition = new window.kakao.maps.LatLng(lat, lng);

              //마커 생성
              mainMarker = new window.kakao.maps.Marker({
                position: markerPosition,
                image: markerImage
              });

              mainMarker.setMap(map);
              mainMarker.setZIndex(3);

              // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
              searchDetailAddrFromCoords(map.getCenter(), displayCenterInfo);
            }

            /*
            function searchAddrFromCoords(coords, callback) {
              // 좌표로 행정동 주소 정보를 요청합니다
              geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
            }
            */


            function searchDetailAddrFromCoords(coords, callback) {
              // 좌표로 법정동 상세 주소 정보를 요청합니다
              geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
            }

            //지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
            function displayCenterInfo(result, status) {
              if (status === kakao.maps.services.Status.OK) {
                infoDiv.innerHTML = result[0].address.address_name;

                var content = "";

                if($("#place_name").val()!=""){
                  content = '<div id="infoWindow"><span>'+$("#place_name").val() + '</span></div>';
                }

                else{
                  content = '<div id="infoWindow"><span>'+result[0].address.address_name+
                          ' ' + $("#place_name").val() + '</span></div>';
                }

                var position = new kakao.maps.LatLng(lat, lng);
                var customOverlay = new kakao.maps.CustomOverlay({
                  position: position,
                  content: content,
                  xAnchor: 0.5, // 커스텀 오버레이의 x축 위치입니다. 1에 가까울수록 왼쪽에 위치합니다. 기본값은 0.5 입니다
                  yAnchor: 2.6 // 커스텀 오버레이의 y축 위치입니다. 1에 가까울수록 위쪽에 위치합니다. 기본값은 0.5 입니다
                });

                customOverlay.setMap(map);
                map.setCenter(customOverlay.getPosition());
              }
            }


          </script>


        </div>
        <div>
          <%
            GatheringDTO dto = (GatheringDTO) request.getAttribute("dto");
            String locationFull = "";

            String address1 = dto.getAddress1();
            String address2 = dto.getAddress2();
            String address3 = dto.getAddress3();
            String place_name = dto.getPlace_name();

            if(address2!=null && !address2.equals(""))
              locationFull = address1 + " " + address2;
            else locationFull = address1;

            if(address3!=null && !address3.equals(""))
              locationFull = locationFull + " " + address3;

            if(place_name!=null && !place_name.equals(""))
              locationFull = locationFull + " " + place_name;
          %>

          <input type="hidden" name="writer_id" value="${dto.writer_id}">
          <input type="hidden" name="gathering_id" value="${dto.gathering_id}">
          <div class="labelAndItem"><span>제목</span>
            <input class="flex" name="title" id="title" value="${dto.title}"></div>
          <div class="labelAndItem"><span>장소</span>
            <input class="flex" disabled id="locationFull"
                   value = "<%=locationFull%>">
            <input type="hidden" name="address1" id="address1" value="${dto.address1}">
            <input type="hidden" name="address2" id="address2" value="${dto.address2}">
            <input type="hidden" name="address3" id="address3" value="${dto.address3}">
            <input type="hidden" name="place_name" id="place_name" value="${dto.place_name}">
            <input type="hidden" name="lat" id="lat" value="${dto.lat}">
            <input type="hidden" name="lng" id="lng" value="${dto.lng}">
            <button type="button" id="locationSearchBtn" onclick="locationSearch()">검색</button></div>
          <div class="labelAndItem"><span>일시</span>
            <input type="datetime-local" name="gathering_date" id="gathering_date" value="${dto.gathering_date}">
            <span class="flex" style="text-align: right;">*30분 이후 ~ 2개월 이내만 가능</span>
          </div>
          <div class="labelAndItem">
            <span>유의사항</span>
            <input class="flex" placeholder="예시) 각자 게임 하나씩 가져오기로 해요~" name="note" value="${dto.note}"></div>
          <div class="labelAndItem">
            <span>최대인원</span>
            <input type="number" min="2" max="30" value="${dto.maxPeople}" name="maxPeople" id="maxPeople"><span>명</span>
            <span class="flex" style="text-align: right;">*최소 2명~최대 30명</span>
          </div>
          <div class="labelAndItem">
            <span>참가방식</span>
            <div class="flex">
              <div>
                <input type="radio" name="attendSystem" value="o" id="order">
                <label for="order">선착순</label>
                <input type="radio" name="attendSystem" value="p" id="permit">
                <label for="permit">승인제</label>
              </div>
              <div id="hiddenQuestion">
                <div>보드인에게 묻고 싶은 질문을 입력하세요. (참가신청 시 제출)</div>
                <input name="question" id="question" placeholder="예시) 가장 좋아하는 게임은 무엇인가요?"
                       value="${dto.question}">
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="postMain">
        <div>
          <button type="button" id="btn-attachGame">게임첨부</button>
        </div>
        <textarea id="gathering_content" name="gathering_content" placeholder="모임을 자유롭게 소개해보세요.">
          ${dto.gathering_content}
        </textarea>
        <script>
          CKEDITOR.replace("gathering_content",{
            filebrowserUploadUrl : "${path}/imageUpload.do"
          });
        </script>

        <ul>
          <li>참가인원이 모두 모이면 '모집완료', 모임시간이 되면 '모임종료'로 변경됩니다.</li>
          <li>소외되는 보드인 없이 모두가 즐거운 모임이 될 수 있게 노력해주세요.</li>
          <li>모임에서 사이트 운영정책에 어긋나는 행위를 하는 경우 이용재제가 가해질 수 있습니다.</li>
        </ul>
        <div>
          <button type="button" id="btn-submit" onclick="add()">수정</button>
          <button type="button" id="btn-reset">돌아가기</button>
        </div>

      </div>
    </form>
  </div>
</div>

<%@include file="../include/footer.jsp" %>

</body>
</html>