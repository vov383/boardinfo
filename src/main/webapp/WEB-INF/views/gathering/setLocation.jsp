<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>위치검색 - 모임모집</title>

  <%@ include file="../include/js/header.jsp" %>

  <style>
  
  
  	body{
  		text-align: center;
  	}
  
    .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
    .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
    .map_wrap {position:relative;width:100%;height:500px;}
    #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
    .bg_white {background:#fff;}
    #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
    #menu_wrap .option{text-align: center;}
    #menu_wrap .option p {margin:10px 0;}
    #menu_wrap .option button {margin-left:5px;}
    #placesList li {list-style: none;}
    #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
    #placesList .item span {display: block;margin-top:4px;}
    #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    #placesList .item .info{padding:10px 0 10px 55px;}
    #placesList .info .gray {color:#8a8a8a;}
    #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
    #placesList .info .tel {color:#009900;}
    #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
    #placesList .item .marker_1 {background-position: 0 -10px;}
    #placesList .item .marker_2 {background-position: 0 -56px;}
    #placesList .item .marker_3 {background-position: 0 -102px}
    #placesList .item .marker_4 {background-position: 0 -148px;}
    #placesList .item .marker_5 {background-position: 0 -194px;}
    #placesList .item .marker_6 {background-position: 0 -240px;}
    #placesList .item .marker_7 {background-position: 0 -286px;}
    #placesList .item .marker_8 {background-position: 0 -332px;}
    #placesList .item .marker_9 {background-position: 0 -378px;}
    #placesList .item .marker_10 {background-position: 0 -423px;}
    #placesList .item .marker_11 {background-position: 0 -470px;}
    #placesList .item .marker_12 {background-position: 0 -516px;}
    #placesList .item .marker_13 {background-position: 0 -562px;}
    #placesList .item .marker_14 {background-position: 0 -608px;}
    #placesList .item .marker_15 {background-position: 0 -654px;}
    #pagination {margin:10px auto;text-align: center;}
    #pagination a {display:inline-block;margin-right:10px;}
    #pagination .on {font-weight: bold; cursor: default;color:#777;}
    
    
    #address{
    	font-size: 18px;
    }
    
    
     button[id*="btn-"]{
      cursor: pointer;
      width: 82px;
      height: 34px;
      font-size: 16px;
      font-weight: bold;
      border-radius: 0;
      margin-top: 5px;
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
    

  </style>

  <script>
  
  
  $(function(){
	  
	  if($("#locationFull", opener.document).val()!=""){
		 let location = $("#locationFull", opener.document).val();
		 $("#address").text(location);
	  }
  });

    function sendData(){
      window.opener.document.getElementById("address1").value = $("#address1").val();
      window.opener.document.getElementById("address2").value = $("#address2").val();
      window.opener.document.getElementById("address3").value = $("#address3").val();
      window.opener.document.getElementById("place_name").value = $("#place_name").val();
      window.opener.document.getElementById("lat").value = $("#lat").val();
      window.opener.document.getElementById("lng").value = $("#lng").val();
      window.opener.document.getElementById("locationFull").value = $("#address").text();

      if($("#tmpDiv",opener.document)){
        $("#tmpDiv",opener.document).css("display", "none");
      }

      
      let lat = $("#lat").val();
      let lng = $("#lng").val()

      window.opener.makeMap(lat, lng);
      window.close();
    }
    
    
    function closeWindow(){
    	if(confirm("위치 선택을 취소하고 창을 닫으시겠습니까?")) window.close();
    }
    

  </script>


</head>


<body>
<div class="map_wrap">
  <div id="map" style="width:800px;height:500px;position:relative;overflow:hidden;"></div>
  <div id="menu_wrap" class="bg_white">
    <div class="option">
      <div>
          키워드 : <input type="text" value="" id="keyword" size="15">
          <button type="button" onclick="searchPlaces()">검색하기</button>
      </div>
    </div>
    <hr>
    <ul id="placesList"></ul>
    <div id="pagination"></div>
  </div>
</div>

  <div id="address_wrap">
  <!-- 시도 -->
  <input type="hidden" id="address1" type="text" value="">
  
  <!-- 구 -->  
  <input type="hidden" id="address2" type="text" value="">
  
  <!-- 기타주소 -->
  <input type="hidden" id="address3" type="text" value="">
   
  <!-- 건물명 --> 
  <input type="hidden" id="place_name" type="text" value="">
    
  <!-- 출력주소 -->  
  <div id="address">
  위치를 검색하거나 직접 지도를 클릭하여 선택하세요.
  </div>
  <button type="button" id="btn-submit" onclick="sendData()">확인</button>
  <button type="button" id="btn-reset" onclick="closeWindow()">취소</button>
    
  <!-- 위도 -->  
  <input type="hidden" id="lat" name="lat">
    
  <!-- 경도 -->  
  <input type="hidden" id="lng" name="lng">
  </div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
<script>
  // 마커를 담을 배열
  let markers = [];
  let mapContainer = document.getElementById("map"); //지도를 표시할 div
  
  let lat;
  let lng;
  
  if($("#lat",opener.document).val()!=''){
	lat = $("#lat", opener.document).val();
	lng = $("#lng", opener.document).val();
  }
  
  else {
	  lat = 37.4989347355231;
	  lng = 127.032854329609;
  }
  
 
	let mapOption = {
			    center: new window.kakao.maps.LatLng(lat, lng),
			    level: 3 //지도의 확대 레벨
			  };  

  
  // 지도를 생성한다.
  let map = new kakao.maps.Map(mapContainer, mapOption);

  //마커 생성
  const markerPosition = new window.kakao.maps.LatLng(
          lat,
          lng
  );


  var imageSrc = 'https://img.freepik.com/icones-gratuites/espace-reserve_318-556820.jpg?w=360', 
          imageSize = new kakao.maps.Size(44, 48); // 마커이미지의 크기입니다

  // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

  let mainMarker = new window.kakao.maps.Marker({
    position: markerPosition,
    image: markerImage
  });

  mainMarker.setMap(map);
  mainMarker.setZIndex(3);

  var geocoder = new kakao.maps.services.Geocoder();
  
  
  //이미 이전에 검색한 내용이 있다면 채워주기
  if($("#lat",opener.document).val()!=''){
	    printAndInput(markerPosition, true);
	  }
  
    
  
  kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

    let latlng = mouseEvent.latLng;

    mainMarker.setPosition(latlng);
    printAndInput(latlng, false);

  });


  function searchAddrFromCoords(coords, callback) {
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
  }

  function searchDetailAddrFromCoords(coords, callback) {
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }

  var ps = new kakao.maps.services.Places();

  var infowindow = new kakao.maps.InfoWindow({
    zIndex:4,
    disableAutoPan: true
  });


  // 키워드 검색을 요청하는 함수입니다
  // #keyword에 있는 값을 가져다가 입력값 검증 후 ps.keywordSearch(keyword, placesSearchCB).
  //placesSearchCB는 장소검색 완료 시 호출될 콜백함수로, data(결과값)/status(상태)/pagination을 받는다
  function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
      alert('키워드를 입력해주세요!');
      return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);
  }

  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
  function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

      // 정상적으로 검색이 완료됐으면
      // 검색 목록과 마커를 표출합니다
      displayPlaces(data);

      // 페이지 번호를 표출합니다
      displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

      alert('검색 결과가 존재하지 않습니다.');


    } else if (status === kakao.maps.services.Status.ERROR) {

      alert('검색 결과 중 오류가 발생했습니다.');


    }
  }


  // 검색 결과 목록과 마커를 표출하는 함수입니다
  function displayPlaces(places) {

    var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for ( var i=0; i<places.length; i++ ) {

      let placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
              marker = addMarker(placePosition, i),
              itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
      let xValue = places[i].x;
      let yValue = places[i].y;

      bounds.extend(placePosition);

      (function(marker, title) {
        kakao.maps.event.addListener(marker, 'mouseover', function() {
          displayInfowindow(marker, title);
        });
        kakao.maps.event.addListener(marker, 'mouseout', function() {
          infowindow.close();
        });

        itemEl.onmouseover =  function () {
          displayInfowindow(marker, title);
        };
        itemEl.onmouseout =  function () {
          infowindow.close();
        };

        kakao.maps.event.addListener(marker, 'click', function(mouseEvent){
          printAndInputUsingMarker(placePosition, title);
          map.panTo(placePosition);
          mainMarker.setPosition(placePosition);
        });
        itemEl.onclick = function(){
          printAndInputUsingMarker(placePosition, title);
          map.panTo(placePosition);
          mainMarker.setPosition(placePosition);
        };
      })(marker, places[i].place_name);
      fragment.appendChild(itemEl);
    }


    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
  }


  
  function getListItem(index, places) {
    var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
      itemStr += '    <span>' + places.road_address_name + '</span>' +
              '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
      itemStr += '    <span>' +  places.address_name  + '</span>';
    }

    itemStr += '  <span class="tel">' + places.phone  + '</span>' +
            '</div>';

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
  }

  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
  function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
              spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
              spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
              offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
              position: position, // 마커의 위치
              image: markerImage,
            });
    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
    return marker;
  }

  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
  function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
      markers[i].setMap(null);
    }
    markers = [];
    markersPositions = [];
  }

  // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
  function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
      paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
      var el = document.createElement('a');
      el.href = "#";
      el.innerHTML = i;

      if (i===pagination.current) {
        el.className = 'on';
      } else {
        el.onclick = (function(i) {
          return function() {
            pagination.gotoPage(i);
          }
        })(i);
      }

      fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
  }


  
  function printAndInput(location, getFromMother){
    searchDetailAddrFromCoords(location, function(result, status){
      if (status === kakao.maps.services.Status.OK) {
        let content = '<div style="display: flex; flex-direction: column;">' + result[0].address.address_name;

        
        let building_name = "";

        if(getFromMother == true && $("#place_name",opener.document).val()!=''){
        	building_name = $("#place_name", opener.document).val();
        }
        
        else{
        	building_name = result[0].road_address?.building_name;	
        }
        
        if(building_name!=null) content += '<div>' + building_name + '</div>';
        else content+= '</div>';

        // 인포윈도우에 클릭한 위치에 대한 주소정보를 표시합니다
        infowindow.setContent(content);
        infowindow.open(map, mainMarker);
        
        
        let address = result[0].address;

        //input값을 채워넣습니다
        $("#address1").val(address.region_1depth_name);
        $("#address2").val(address.region_2depth_name);
        $("#address3").val(address.region_3depth_name + ' ' 
        		+ address.main_address_no + 
        		(address.sub_address_no == '' || address.sub_address_no == null ? '' : ('-' + address.sub_address_no)));
        $("#place_name").val(building_name);
        $("#address").text(
                building_name==null? result[0].address.address_name : result[0].address.address_name + ' ' + building_name
        );

        $("#lng").val(location.getLng());
        $("#lat").val(location.getLat());
      }});
  }


  function printAndInputUsingMarker(location, title){
    searchDetailAddrFromCoords(location, function(result, status){
      if (status === kakao.maps.services.Status.OK) {
        let content = '<div style="display: flex; flex-direction: column;">' + result[0].address.address_name;

        let building_name = result[0].road_address?.building_name;
        content += '<div>' + title + '</div>';

        // 인포윈도우에 클릭한 위치에 대한 주소정보를 표시합니다
        infowindow.setContent(content);
        infowindow.open(map, mainMarker);
        
        
        let address = result[0].address;

        //input값을 채워넣습니다
        $("#address1").val(address.region_1depth_name);
        $("#address2").val(address.region_2depth_name);
        $("#address3").val(address.region_3depth_name + ' ' 
        		+ address.main_address_no + 
        		(address.sub_address_no == '' || address.sub_address_no == null ? '' : ('-' + address.sub_address_no)));
        $("#address").text(
                address.address_name + ' ' + title
        );
        $("#place_name").val(title);
        $("#lng").val(location.getLng());
        $("#lat").val(location.getLat());
        
      }});
  }


  
  function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
    infowindow.setContent(content);
    infowindow.open(map, marker);
  }


  
  function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
      el.removeChild (el.lastChild);
    }
  }

</script>
</body>
</html>