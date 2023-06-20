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
            position: relative;
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
            border-radius: 5px;
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

        button[id*="bigBtn-"], button[class*="bigBtn-"]{
            width: 120px;
            height: 40px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            cursor: pointer;
        }

        #bigBtn-apply{
            background-color: #1432B1;
            border: 0;
            color: white;
        }

        .bigBtn-cancel{
            background-color: white;
            border: 1px solid black;
            margin-left: 5px;
        }

        #bigBtn-chat{
            background-color: #F9841A;
            border: 0;
            color: white;
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

        .reply > div:first-of-type > div > span:first-of-type{
            padding-right: 10px;
            margin-right: 10px;
        }

        .addRe_reply > a{
            text-decoration: none;
            color: black;
        }

        form[name="replyForm"]{
            text-align: right;
        }

        .re-replyForm{
            padding: 15px 20px 10px 20px;
        }

        [class*="re-reply"]{
            background-color: #F5F5F5;
            padding-top: 10px;
        }

        textarea{
            width: 100%;
            box-sizing: border-box;
            margin: 15px 0 5px 0;
            height: 100px;
            resize: none;
        }

        button[id*="btn-"], button[class*="btn-"]{
            width: 82px;
            height: 34px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            cursor: pointer;
        }

        #btn-GoList, #btn-Edit, #btn-Delete{
            border: 1px solid black;
            background-color: white;
        }

        #btn-Delete{
            margin: 0 5px;
        }


        .btn-AddReply, .btn-editReply, .btn-cancelReply{
            background-color: #3D3D43;
            border: 0;
            color: white;
        }

        .btn-cancelReply{
            margin-right: 5px;
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

        /*여기부터 모달*/
        .popup-wrap{
            background-color:rgba(0,0,0,.3);
            z-index: 1000;
            justify-content:center;
            align-items: center;
            position: fixed;
            display: none;
            top:0;
            left:0;
            right:0;
            bottom:0;
            padding: 15px;
        }

        .popup{
            overflow: hidden;
            box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
        }

        .popup-body{
            max-width: 480px;
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px;
            background-color:#ffffff;
        }

        .popup div{
            font-size: 16px;
        }

        .popup-body > div:last-of-type{
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        .popup-body button:first-of-type{
            margin-right: 10px;
        }


    </style>

    <script>


        $(function(){

            getReplies();

            $("#bigBtn-apply").on("click", function(){

                if("${sessionScope.userid}" == ""){
                    if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                        location.href= "${path}/member/member_login.do";
                        return;
                    }

                    else return;

                }

                if("${dto.attendSystem}"=='p') {
                    document.body.style.overflowY = "hidden";
                    $(".popup-wrap").css('display','flex').hide().fadeIn();
                    return;
                }

                if(confirm("이 모임에 참여하시겠습니까?")){

                  $.ajax({
                           type: "get",
                           url : "${path}/gathering/addAttendee.do",
                           data : {
                               "gathering_id": "${dto.gathering_id}"
                           },
                           success: function(result){
                               alert(result.message);
                               location.reload();
                           },
                           error: function(e){
                                   alert("에러가 발생했습니다.");
                           }
                       });
                   }

            });


            $(document).on("click", ".btn-AddReply", function() {

                if("${sessionScope.userid}" == ""){
                    if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                        location.href= "${path}/member/member_login.do";
                        return;
                    }
                    else return;
                }


                let form = $(this).closest("form");
                let reply_text = form.find('textarea[name="reply_text"]');
                reply_text.val(reply_text.val().trim());
                if(reply_text.val()=='') return;

                let queryString = form.serialize()+"&gathering_id="+"${dto.gathering_id}";

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/addReply.do",
                    data : queryString,
                    success: function(result){
                       if(result){
                           reply_text.val("");
                           getReplies();
                       }
                       else alert("에러가 발생했습니다.");
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });



            });

        });


        function getReplies(){
            $.ajax({
                type: "get",
                url : "${path}/gathering/getReplies.do",
                data : {gathering_id : "${dto.gathering_id}"},
                success: function(result){
                    let list = result.list;
                    if(list!=null && list.length > 0){

                        let repliesContainer = $("#replies");
                        repliesContainer.empty();

                        for(let i=0; i<list.length; i++){

                            let addReplySpan = "";

                            if("${sessionScope.userid}" == list[i].creator_id){
                                addReplySpan =
                                    "<span class='addRe_reply'><img src='${path}/images/reply_arrow.png' width='15px'>" +
                                    "<img ><a href='javascript:showRe_reply(" + list[i].reply_id + "," +
                                    list[i].parent_reply + "," + list[i].inner_order + ")'>답글</a>" +
                                    "&nbsp&nbsp<a href='javascript:editReply(" +
                                    list[i].reply_id + ")'>수정</a>&nbsp&nbsp<a href='javascript:deleteReply()'>삭제</a>";
                            }

                            else{
                                addReplySpan =
                                    "<span class='addRe_reply'><img src='${path}/images/reply_arrow.png' width='15px'>" +
                                    "<img ><a href='javascript:showRe_reply(" + list[i].reply_id + "," +
                                    list[i].parent_reply + "," + list[i].inner_order + ")'>답글</a>";
                            }


                            let reply = $("<div>").addClass("reply").attr("id", list[i].reply_id);

                            let writer = $("<span>").text(list[i].nickname);
                            let text= $("<div>").text(list[i].reply_text);

                            if(list[i].depth > 0) {
                                reply.addClass("re-reply");
                                writer.html("<img width='10px' style='margin-right: 7px;' " +
                                    "src='${path}/images/re_reply.png'>" + writer.text());
                                writer.css("padding-left", (list[i].depth * 18) + "px");
                                text.css("padding-left", (list[i].depth * 18) + "px");
                            }

                            let bigDiv = $("<div>");
                            let smallDiv = $("<div>");


                            let date = new Date(list[i].create_date);
                            let formattedDate = new Date(date + 3240 * 10000)
                                .toISOString().replace('T', ' ').replace(/\..*/,'');

                            let span = $("<span>").text(formattedDate);



                            smallDiv.append(span, addReplySpan);
                            bigDiv.append(writer, smallDiv);
                            reply.append(bigDiv, text);

                            repliesContainer.append(reply);
                        }

                    }

                    $("#countReplies").text(list.length==null ? 0 : list.length);

                }, error: function(){
                    $("#countReplies").text(0);
                }
            });
        }

        function showRe_reply(reply_id){
            $("form[class='re-replyForm']").remove();

            let re_reply_form = $("<form>").addClass("re-replyForm")
                .attr({
                    name: "replyForm",
                    action: "${path}/gathering/addReply.do"
                });

            let textArea = $("<textarea>").attr({
                name: "reply_text"
            });

            let input = $("<input>").attr({
                type: "hidden",
                name: "mother_reply",
                value: reply_id
            });

          let button = $("<button>").attr({
                type: "button",
                class: "btn-AddReply"
            }).text("댓글쓰기");

            re_reply_form.append(textArea, input, button);
            $("#" + reply_id).append(re_reply_form);

        }

        function editPost(){
            location.href="${path}/gathering/edit/${dto.gathering_id}";
        }

        function deletePost(){
            if(Number("${dto.attendee_count}") > 1){
                if(!confirm("게시글을 삭제하면 모든 채팅 내역이 삭제되며 모든 모임원이 자동으로 모임에서 나가게 됩니다. " +
                    "다른 모임원들과 상의하여 신중하게 결정해주세요!\n\n정말로 게시글을 삭제하시겠습니까?")){
                    return;
                }
            }

            else{
                if(!confirm("게시글을 삭제하면 모든 채팅 내역이 삭제됩니다.\n정말로 게시글을 삭제하시겠습니까?")){
                    return;
                }
            }

            location.href="${path}/gathering/delete.do?gathering_id=${dto.gathering_id}";
        }


        function withdraw(){
            if(confirm("정말로 이 모임을 탈퇴하시겠습니까?\n(자동으로 채팅방에서 나가게 됩니다.)")){
                $.ajax({
                        type: "get",
                        url : "${path}/gathering/withdraw.do",
                        data : {
                            "gathering_id": "${dto.gathering_id}"
                        },
                        success: function(result){
                            alert(result.message);
                            location.reload();
                            },
                        error: function(e){
                            if(e.status==999){
                                if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                                    location.href= "${path}/member/member_login.do";
                                    return;
                                }
                            }
                            else{
                                alert("에러가 발생했습니다.");
                            }
                        }
                    });
                }

        }


        function modalClose(){
            $(".popup-wrap").fadeOut(); //페이드아웃 효과
            $("input[name='answer']").val('');
            document.body.style.overflowY = "auto";
        }

        function submitApplication(){
            $.ajax({
                type: "get",
                url : "${path}/gathering/addAttendee.do",
                data : {
                    "answer": $("input[name='answer']").val(),
                    "gathering_id": "${dto.gathering_id}"
                },
                success: function(result){
                    alert(result.message);
                    location.reload();
                },
                error: function(e){
                    alert("에러가 발생했습니다.");
                }
            });
        }


        function cancelApplication(){
            if(confirm("모임 참가 신청을 취소하시겠습니까?")){
                $.ajax({
                    type: "get",
                    url : "${path}/gathering/cancelApplication.do",
                    data : {
                        "gathering_id": "${dto.gathering_id}"
                    },
                    success: function(result){
                        alert(result.message);
                        location.reload();
                    },
                    error: function(e){
                            alert("에러가 발생했습니다.");
                    }
                });
            }
        }


        function editReply(reply_id){

            let reply = $("#"+reply_id);
            let original = reply.html();
            let text = reply.children("div:eq(1)").text();

            let edit_reply_form = $("<form>").addClass("edit-replyForm")
                .attr({
                    name: "replyForm",
                    action: "${path}/gathering/editReply.do"
                });

            let textArea = $("<textarea>").attr({
                name: "reply_text"
            });

            textArea.text(text);

            let input = $("<input>").attr({
                type: "hidden",
                name: "reply_id",
                value: reply_id
            });

            let button = $("<button>").attr({
                type: "button",
                class: "btn-editReply"
            }).text("수정");


            let button2 = $("<button>").attr({
                type: "button",
                class: "btn-cancelReply"
            }).text("취소");


            button2.click(function(){
                $("#"+reply_id).html(original);
            });


            edit_reply_form.append(textArea, input, button2, button);
            $("#" + reply_id).html(edit_reply_form);

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
    		<div id="postInfo">
    		<span>
	    		<fmt:formatDate value="${dto.post_date}" pattern="yyyy-MM-dd HH:mm"/>
			</span><span>조회 ${dto.view_count}</span>
    		</div>
            <div id="postUpper">
                <div>
                 <div class="map_wrap">
					  <div id="map"></div>
    				  	<div class="hAddr">
					    <span class="title">주소정보</span>
					    <span id="centerAddr"></span>
				   </div>
				 </div>
                </div>

				 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
<script>

  var mapContainer = document.getElementById('map'); // 지도를 표시할 div

  var mapOption =
          {
            center: new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
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
              level: 4 // 지도의 확대 레벨
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

        let content = "";

        if("${dto.place_name}"!=null && "${dto.place_name}"!=""){
            content = "<div id='infoWindow'><span>" + "${dto.place_name}" + "</span></div>";
        }
        else
            content = '<div id="infoWindow"><span>'+result[0].address.address_name + '</span></div>';

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
                        <li>일시:&nbsp&nbsp
                            <fmt:parseDate value="${dto.gathering_date}"
                                           pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
                            <fmt:formatDate value="${parsedDateTime}" pattern="yyyy.M.dd a h:mm"/>
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
                        <li>${dto.attendee_count}/${dto.maxPeople}명 참가중
                            <img src="${path}/images/more.png" width="30px"
                                         style="vertical-align: middle; padding-bottom: 2px;"></li>
                    </ul>
                    <div>
                        <span>작성자: ${dto.nickname}</span>
                        <!--모집완료, 모집마감 고려해서 다시 짜기-->
                        <c:choose>
                            <c:when test="${type == 'WAIT'}">
                                <button type="button" class="bigBtn-cancel" onclick="cancelApplication()">신청취소</button>
                            </c:when>
                            <c:when test="${type == 'ATTENDING'}">
                                <div>
                                <button type="button" id="bigBtn-chat"
                                        onclick="location.href='${path}/gathering/chatRoom/${dto.gathering_id}'">
                                    채팅하기</button>
                                    <c:if test="${dto.writer_id != sessionScope.userid}">
                                    <button type="button" class="bigBtn-cancel"
                                        onclick="withdraw()">
                                    탈퇴하기</button>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <button type="button" id="bigBtn-apply">참가신청</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div id="postMain">
            ${dto.gathering_content}
            </div>

            <div id="replyArea">
                <div id="replyUpper">
                    <span>댓글[<span id="countReplies"></span>]</span>
                    <span>이 모임에 대해 궁금한 사항이 있으면 댓글을 달아보세요.</span>
                    <c:if test="${sessionScope.userid==dto.writer_id}">
                        <button type="button" id="btn-Edit"
                                onclick='editPost()'>수정
                        </button>
                        <button type="button" id="btn-Delete"
                                onclick="deletePost()"> 삭제
                        </button>
                    </c:if>
                    <form name="form1" action="${path}/gathering/list.do">
                        <input type="hidden" name="showAvailable" value="${showAvailable}">
                        <input type="hidden" name="option" value="${option}">
                        <input type="hidden" name="keyword" value="${keyword}">
                        <input type="hidden" name="from" value="${from}">
                        <input type="hidden" name="to" value="${to}">
                        <input type="hidden" name="curPage" value="${curPage}">
                        <c:forEach var="address1" items="${address1List}">
                            <input type="hidden" name="address1" type="hidden" value="${address1}">
                        </c:forEach>
                        <button type="submit" id="btn-GoList">목록</button>
                    </form>
                </div>
                <div id="replies">
                </div>
                <form name="replyForm" action="${path}/gathering/addReply.do">
                    <textarea name="reply_text"></textarea>
                    <input type="hidden" name="gathering_id" value="${dto.gathering_id}">
                    <button type="button" class="btn-AddReply">댓글쓰기</button>
                </form>
            </div>
    </div>


    <div class="popup-wrap">
        <div class="popup">
            <div class="popup-body">
                <div>이 모임은 허가제 모입입니다.<br>
                    다음 질문에 답한 뒤 모임장의 승인을 받아야 참석할 수 있습니다.</div>
                <div>[질문]&nbsp;${dto.question}</div>
                <input name="answer">
                <div>
                    <button type="button" onclick="submitApplication()">답변제출</button>
                    <button type="button" onclick="modalClose()">취소</button>
                </div>
            </div>
        </div>
    </div>


</div>

<%@include file="../include/footer.jsp" %>
</body>
</html>