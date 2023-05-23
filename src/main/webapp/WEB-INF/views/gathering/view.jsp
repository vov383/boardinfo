<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

<%@ include file="../include/js/header.jsp" %>
  <title>${dto.title} - 모임모집</title>

    <style>
    .map_wrap {
      position:relative;
    }

    .title {
      font-weight:bold;
      display:block;
    }

    .hAddr {
      position:absolute;
      left:10px;
      top:10px;
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
    
    
        #postInfo{
	      text-align: right;
	      padding-bottom: 5px;
    	  }
    	  
    	  #postInfo > span{
    	  padding: 0 10px;
    	  border-right: 1px solid black;
    	  }
    	  
    	  #postInfo > span:last-of-type{
    	  border:  none;
    	  }
    
        #postUpper{
            display: flex;
            border-top: 2px solid black;
        }

        #postUpper > div:first-of-type{
            padding: 30px 0;
        }

        #map{
            width: 400px;
            height: 280px;
            border: 1px solid black;
            text-align: center;
            line-height: 257px;
            overflow: hidden;
        }

        #profileArea{
            padding: 30px 0 30px 50px;
            flex-grow: 1;
            display: flex;
            justify-content: space-between;
            flex-direction: column;
        }

        .status{
            width: 85px;
            border: 1px solid black;
            border-radius: 10px;
            padding: 0 10px;
            margin-right: 6px;
]        }

        #title{
            padding-top: 10px;
            font-weight: bold;
            font-size: 22px;
        }

        #profileArea > ul{
            padding-left: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            padding-bottom: 10px;
        }

        #profileArea > ul > li{
            flex-grow: 1;
            font-size: 16px;
        }

        #profileArea > div:last-of-type{
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        #profileArea > div:last-of-type > span{
            font-weight: bold;
            font-size: 17px;
        }

        #applyBtn{
            width: 120px;
            height: 40px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            background-color: #F9841A;
            border: 0;
            color: white;
            cursor: pointer;
        }

        #postMain{
            padding: 30px 13px;
            border-top: 2px dashed #D9D9D9;
            display: flex;
            flex-direction: column;
        }

        #replyUpper{
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #D9D9D9;
            border-top: 1px solid #D9D9D9;
        }

        #replyUpper > span:first-of-type{
            font-weight: bold;
            margin-right: 15px;
        }

        #replyUpper > span:nth-of-type(2){
            flex-grow: 1;
        }

        .reply{
            padding: 16px 13px;
            border-bottom: 1px solid #D9D9D9;
        }

        .reply > div:first-of-type{
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .reply > div:first-of-type > span:first-of-type {
            font-weight: bold;
        }

        .reply > div:first-of-type > div > span{
            padding-right: 10px;
            margin-right: 10px;
        }

        form[name="replyForm"]{
            text-align: right;
        }

        textarea{
            width: 100%;
            box-sizing: border-box;
            margin: 15px 0 5px 0;
            height: 100px;
            resize: none;
        }

        button[id*="btn-"]{
            width: 82px;
            height: 34px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            cursor: pointer;
        }

        #btn-GoList{
            border: 1px solid black;
            background-color: white;
        }

        #btn-addReply{
            background-color: #1432B1;
            border: 0;
            color: white;
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
    		<div id="postInfo">
    		<span>
	    		<fmt:formatDate value="${dto.post_date}" pattern="yyyy-MM-dd HH:mm"/>
			</span><span>조회 ${dto.view_count}</span><span>댓글 3</span>
    		</div>
            <div id="postUpper">
                 <div class="map_wrap">
					  <div id="map" style="position:relative;overflow:hidden;"></div>
				  	<div class="hAddr">
					    <span class="title">주소정보</span>
					    <span id="centerAddr"></span>
				   </div>
				 </div>
				 
				 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
<script>

  var mapContainer = document.getElementById('map'); // 지도를 표시할 div

  var mapOption =
          {
            center: new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"), // 지도의 중심좌표
            level: 1 // 지도의 확대 레벨
          };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  var imageSrc = 'https://img.freepik.com/icones-gratuites/espace-reserve_318-556820.jpg?w=360', // 마커이미지의 주소입니다
          imageSize = new kakao.maps.Size(44, 48); // 마커이미지의 크기입니다

  // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  let mainMarker;

  // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
  var infowindow = new kakao.maps.InfoWindow({
    zIndex:4,
    disableAutoPan: true
  });

  var infoDiv = document.getElementById('centerAddr');


  makeMap("${dto.lat}", "${dto.lng}");


  function makeMap(lat, lan){
    mapOption =
            {
              center: new kakao.maps.LatLng(lat, lan), // 지도의 중심좌표
              level: 1 // 지도의 확대 레벨
            };

    // 지도를 생성합니다
    map = new kakao.maps.Map(mapContainer, mapOption);

    //마커 생성
    const markerPosition = new window.kakao.maps.LatLng(lat, lan);

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


  function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }

  //지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
  function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        infoDiv.innerHTML = result[0].address.address_name;

        var content = '<div id="infoWindow"><span>'+result[0].address.address_name+
                ' ' + "${dto.place_name}" + '</span></div>';
        var position = new kakao.maps.LatLng("${dto.lat}", "${dto.lng}");
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
				 
                <div id="profileArea">
                    <div>
                        <span class="status">${dto.status}</span>
                        <span class="status">
                        <c:choose>
                        	<c:when test="${dto.attendSystem=='p'}">
                        	승인제
                        	</c:when>
                        	<c:otherwise>
                        	선착순
                        	</c:otherwise>
                        </c:choose>
                        </span>
                    </div>
                    <div id="title">${dto.title}</div>
                    <ul>
                        <li>장소:&nbsp&nbsp${dto.address1} ${dto.address2} ${dto.address3} ${dto.place_name}</li>
                        <li>일시:&nbsp&nbsp<fmt:formatDate value="${dto.post_date}" pattern="yyyy.M.dd a h:mm"/></li>
                        <li>유의사항:&nbsp&nbsp
                        	<c:choose>
                        		<c:when test="${dto.note==null || dto.note == ''}">
                        			-
                        		</c:when>
                        		<c:otherwise>
     		                        ${dto.note}
                        		</c:otherwise>
                        	</c:choose>

                        
                        
                        </li>
                        <li>2/${dto.maxPeople}명 참가중<img src="${path}/images/more.png" width="30px"
                                         style="vertical-align: middle; padding-bottom: 2px;"></li>
                    </ul>
                    <div>
                        <span>작성자: ${dto.writer_id}</span>
                        <button type="button" id="applyBtn">참가신청</button>
                    </div>
                </div>
            </div>
            <div id="postMain">
            ${dto.description}
            </div>

            <div id="replyArea">
                <div id="replyUpper">
                    <span>댓글[3]</span>
                    <span>이 모임에 대해 궁금한 사항이 있으면 댓글을 달아보세요.</span>
                    <button type="button" id="btn-GoList">목록</button>
                </div>
                <div id="replies">

                    <div class="reply">
                        <div>
                            <span>귤선생</span>
                            <div>
                                <span>2023.05.15&nbsp&nbsp07:02:14</span>
                                <img src="${path}/images/reply_arrow.png" width="15px;">답글
                            </div>
                        </div>
                        <div>
                            우와 ㅠㅠㅠㅠ 너무 가고 싶은데 시간이 안되는 게 아쉽네요 ㅠㅠㅠㅠㅠ
                        </div>
                    </div>

                    <div class="reply">
                        <div>
                            <span>귤선생</span>
                            <div>
                                <span>2023.05.15&nbsp&nbsp07:02:14</span>
                                <img src="${path}/images/reply_arrow.png" width="15px;">답글
                            </div>
                        </div>
                        <div>
                            우와 ㅠㅠㅠㅠ 너무 가고 싶은데 시간이 안되는 게 아쉽네요 ㅠㅠㅠㅠㅠ
                        </div>
                    </div>

                    <div class="reply">
                        <div>
                            <span>귤선생</span>
                            <div>
                                <span>2023.05.15&nbsp&nbsp07:02:14</span>
                                <img src="${path}/images/reply_arrow.png" width="15px;">답글
                            </div>
                        </div>
                        <div>
                            우와 ㅠㅠㅠㅠ 너무 가고 싶은데 시간이 안되는 게 아쉽네요 ㅠㅠㅠㅠㅠ
                        </div>
                    </div>




                </div>
                <form name="replyForm">
                    <textarea></textarea>
                    <button type="button" id="btn-addReply">댓글쓰기</button>
                </form>
            </div>
    </div>
</div>

<%@include file="../include/footer.jsp" %>

</body>
</html>