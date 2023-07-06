<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/js/header.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>


<title>채팅</title>

    <style>

    #contentsMain{
		padding-top: 10px;
		display: flex;
	}

	#contentsMain > div{
		display: flex;
		flex-direction: column;
	}

	#chatRoomListBox{
        padding-top: 42px;
        min-width: 300px;
        max-width: 300px;
        margin-right: 20px;
		flex-grow: 0;
	}

    #chatRoomList{
        height: 500px;
        overflow: auto;
        border: 1px solid #d9d9d9;
        padding: 1px;
    }

    /*
	form[name="chatRoomSearch"]{
		position: relative;
		margin-bottom: 10px;
	}

	form[name="chatRoomSearch"] > input{
		width: 100%;
		height: 35px;
		padding:  0 40px 0 15px;
		border: 1px solid #D9D9D9;
	}

	form[name="chatRoomSearch"] > img{
		position: absolute;
		z-index: 10;
		top: 7px;
		right: 15px;
	}
     */

	.chatRoom{
        border-bottom: 1px solid #D9D9D9;
		padding: 12px 10px;
	}

    .chatRoom:hover{
        cursor: pointer;
        background-color: #FFE699;
    }

	.roomName{
		display: flex;
        align-items: center;
        justify-content: space-between;
	}

    .chatRoom h4{
        font-size: 15px;
        margin: 0 5px 0 0;
        max-width: 200px;
        padding: 0;
        display: inline;
    }

    .chatRoom > div:last-of-type{
        margin-top: 5px;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        text-overflow: ellipsis;
        overflow: hidden;
    }

    .chatRoom .attendee_count{
        font-size: 13px;
    }

    .unread{
        width: 4px;
        height: 4px;
        background-color: red;
        border-radius: 50px;
        visibility: hidden;
    }


	.selectedRoom{
		background-color: #D9D9D9;
	}


	.lastChatTime{
		font-size: 12px;
		line-height: 12px;
		text-align: right;
	}


	.chatRoom > div:last-of-type{
		font-size: 13px;
	}

	#msgBox{
		flex-grow: 1;
	}

	#chatRoomInfo{
		width: 100%;
		height: 32px;
		margin-bottom: 10px;
		display: flex;
		justify-content: space-between;
        position: relative;
	}

    #chatRoomInfo > div:first-child{
		flex-grow: 1;
        display: flex;
        align-items: center;
	}

    #chatRoomInfo > div:first-child img{
        width: 30px;
        height: 30px;
        cursor: pointer;
    }

	#chatRoomInfo a{
		color: black;
		text-decoration: none;
		font-size: 20px;
		font-weight: bold;
		padding-left: 10px;
	}


	#chatRoomInfo > div:first-child > span {
		font-size: 18px;
		margin-left: 20px;
	}

    #chatRoomInfo .attendee_count{
        font-size: 18px;
    }

	#chatRoomInfo button{
		height: 100%;
		border: 1px solid black;
		font-size: 16px;
		font-weight: bold;
		background-color: white;
		width: 112px;
		cursor: pointer;
	}

    .rotated{
        transform: rotate(180deg);
    }

    #attendeeList{
        overflow-x:auto;
        white-space:nowrap;

        background-color: white;
        top: 125%;
        left: 0;
        margin-top: 3px;

        position: absolute;
        z-index: 10;
        box-shadow: 0 4px 5px -2px rgba(0,0,0,.1);

        width: 100%;
        padding-bottom: 8px;
        display: none;
        flex-wrap: wrap;
        border-bottom-left-radius: 6px;
        border-bottom-right-radius: 6px;
        border-left: 1px solid #D9D9D9;
        border-right: 1px solid #D9D9D9;
        border-bottom: 1px solid #D9D9D9;
    }

    .attendee-wrap{
        display: inline-flex;
    }

    .attendee{
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .attendee span{
        font-weight: normal;
        font-size: 13px;
    }

    .attendee img{
        width: 42px;
        height: 42px;
        margin: 8px 0 3px 0;
        border-radius: 50%;
        object-fit: cover;
    }

    #msgArea{
		flex-grow: 1;
		border: 1px solid #D9D9D9;
		padding: 20px;
		height: 500px;
		overflow: auto;
	}

	[class*="message_"]{
		display: flex;
		margin-bottom: 10px;
	}

	.message_yours{
		flex-direction: column;
	}

	.message_mine{
		justify-content: right;
		align-items: center;
	}

	.message_notice{
		justify-content: center;
	}

	.sender{
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 3px;
	}

	.message_yours > div:nth-child(2){
		display: flex;
		align-items: center;
	}

	.messageContent{
		padding: 5px 8px;
		border-radius: 5px;
	}

	.message_yours .messageContent{
		background-color: #D9D9D9;
		margin-right: 10px;
	}

	.message_mine .messageContent{
		background-color: #FFC61A;
		margin-left: 10px;
	}

	.message_notice .messageContent{
		background-color: #1432B1;
		color: white;
	}

	.chatTime{
		font-size: 13px;
	}


	#msgBox > div:last-child {
		width: 100%;
		display: flex;
		position: relative;
	}

	#msg, #msg2{
		flex-grow: 1;
		height: 37px;
		padding:  0 40px 0 15px;
		background-color: #3D3D43;
		color: white;
	}

	#msg::placeholder, #msg2::placeholder{
		color: #D9D9D9;
	}

	#sendBtn, #sendBtn2{
		width: 40px;
		position: absolute;
		z-index: 1;
		right: 15px;
		bottom: 3px;
	}

	#sendBtn:hover{
		cursor: pointer;
	}



</style>

</head>
<body>
<%@include file="../include/top.jsp" %>


<div id="contents">
  <div id="contentsHeader">
    <h2>채팅</h2>
  </div>
  <div id="contentsMain">

  <div id="chatRoomListBox">

<!--
	  <form name="chatRoomSearch">
	  <input name="chatRoomKeyword" placeholder="채팅방 검색">
	  <img src="${path}/images/search.png" onclick="" width="20px">
	  </form>
-->

  <div id="chatRoomList">
	  <c:forEach var="room" items="${rlist}">
		  <div class="chatRoom" data-room="${room.gathering_id}">
			  <div class="roomName">
                  <div><h4>${room.title}</h4><span class="attendee_count">${room.attendee_count}</span></div>
                    <c:choose>
                        <c:when test="${room.unread == true}">
                            <span class="unread" style="visibility: visible"></span>
                        </c:when>
                        <c:otherwise>
                            <span class="unread"></span>
                        </c:otherwise>
                    </c:choose>
			  </div>
			  <div class="lastChatTime">${room.lastChat.formattedDate}</div>
			  <div>${room.lastChat.message}</div>
		  </div>
	  </c:forEach>
  </div>
  </div>

      <c:choose>
          <c:when test="${dto!=null}">
      <div id="msgBox">
          <div id="chatRoomInfo">
              <div>
                  <a href="${path}/gathering/view/${dto.gathering_id}">${dto.title}</a>
                  <span><span class="attendee_count">${dto.attendee_count}</span>/${dto.maxPeople}명 참가중</span>
                  <img src="${path}/images/more.png" id="showAttendeeBtn">
              </div>
              <button type="button" onclick="withdraw()">채팅방 나가기</button>
              <div id="attendeeList">
                  <c:forEach var="attendee" items="${dto.attendeeDTOList}">
                      <a class="attendee-wrap" href="${path}/mypage/goMypage/${attendee.user_id}" data-user_id="${attendee.user_id}">
                          <div class="attendee">
                              <img src="${path}/images/${attendee.profile}">
                              <span>${attendee.nickname}</span>
                          </div>
                      </a>
                  </c:forEach>
              </div>
          </div>
          <div id="msgArea">

              <c:forEach var="row" items="${list}" varStatus="status">
                  <fmt:parseDate value="${row.formattedDate}"
                                 pattern="yyyy.MM.dd'T'HH:mm" var="parsedDateTime" type="both"/>
                  <c:set var="thisDate">
                      <fmt:formatDate value="${parsedDateTime}" pattern="yyyy.MM.dd"/>
                  </c:set>
                  <c:set var="thisTime">
                      <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm"/>
                  </c:set>
                  <c:set var="thisTalker" value="${row.userId}"/>


                  <c:if test="${status.index==0}">
                      <c:set var="firstDate" value="${thisDate}"/>
                      <c:set var="firstTime" value="${thisTime}"/>
                      <c:set var="lastDate" value="${thisDate}"/>
                      <c:set var="lastTime" value="${thisTime}"/>
                      <c:set var="firstTalker" value="${row.userId}"/>
                      <c:set var="lastTalker" value="${row.userId}"/>
                      <div class='message_notice'>
                          <div class='messageContent chatDate'>
                                  ${thisDate}
                          </div>
                      </div>
                  </c:if>

                  <c:choose>
                      <c:when test="${lastDate==thisDate}">
                          <c:if test="${
						list[status.index-1]!=null &&
						lastTime == thisTime &&
						lastTalker == thisTalker}">
                              <c:set var="thisTalker" value=""/>
                          </c:if>
                      </c:when>

                      <c:otherwise>
                          <c:set var="lastDate" value="${thisDate}"/>
                          <div class='message_notice'>
                              <div class='messageContent chatDate'>
                                      ${thisDate}
                              </div>
                          </div>
                      </c:otherwise>
                  </c:choose>

                  <c:if test="${
						list[status.index+1]!=null &&
						list[status.index+1].userId==row.userId &&
						list[status.index+1].formattedDate==row.formattedDate}">
                      <c:set var="thisTime" value=""/>
                  </c:if>

                  <c:choose>
                      <c:when test="${row.userId==user_id}">
                          <div class='message_mine'>
						<span class='chatTime'>
                                ${thisTime}
                        </span>
                              <div class='messageContent'>${row.message}</div>
                          </div>
                      </c:when>

                      <c:when test="${row.userId=='SYSTEM'}">
                          <div class='message_notice'>
                              <div class='messageContent'>${row.message}</div>
                          </div>
                      </c:when>

                      <c:otherwise>
                          <div class='message_yours'>
                              <div class='sender'>
                                  <c:if test="${thisTalker!=''}">
                                      ${row.nickname}
                                  </c:if>
                              </div>
                              <div>
                                  <div class='messageContent'>${row.message}</div>
                                  <span class='chatTime'>${thisTime}</span>
                              </div>
                          </div>
                      </c:otherwise>

                  </c:choose>

                  <c:set var="lastTime">
                      <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm"/>
                  </c:set>
                  <c:set var="lastTalker" value="${row.userId}"/>

              </c:forEach>

          </div>
          <c:choose>
              <c:when test="${dto.finishChat == 'y'}">
                  <div>
                      <input id="msg2" placeholder="채팅이 종료된 모임입니다." disabled>
                      <img id="sendBtn2" src="${path}/images/gathering/chatSend.png">
                  </div>
              </c:when>
              <c:otherwise>
                  <div>
                      <input id="msg" placeholder="텍스트를 입력해주세요." onkeypress="enterChat(event)">
                      <img id="sendBtn" src="${path}/images/gathering/chatSend.png">
                  </div>
              </c:otherwise>
          </c:choose>
      </div>

        </c:when>
      </c:choose>


  </div>


  </div>
</div>


<script>

    var curPage = 1;
    const cur_session = '${user_id}'; //현재 로그인한 사람
    const this_gathering_id = '${gathering_id}';

    let curNickName = '${sessionScope.nickname}';
    let chatList = JSON.parse('${sessionScope.activeChats}');

    let end = false;
    let loading = false;
    let size = 20;

    let firstDate = "${firstDate}";

    let nicknameMap = ${nicknameMap};

    var lastTalker = "${lastTalker}";
    var lastDate = "${lastDate}";
    var lastTime = "${lastTime}";



    //for sujin
    //var sock = new SockJS('http://localhost:8098/ws-stomp-in');

    //for others
    var sock = new SockJS('http://localhost:80/ws-stomp-in');

    //for taeyoung
    //var sock = new SockJS('http://localhost:80/board-info/ws-stomp-in');


    var stomp = Stomp.over(sock);
    stomp.debug = null;

    let list;
    let focusList = {};
    const thisRoom = $('.chatRoom[data-room="' + this_gathering_id + '"]');
    var room;

    const unreadChatSpan = $("#unreadChat");


    $(function(){

        if('${unread}' == 'true'){
            unreadChatSpan.removeClass('hidden');
        }

        if("${message}"!=""){
            alert("${message}");
        }

        if(cur_session=="") return;

        $("#showAttendeeBtn").click(function(){
            $(this).toggleClass("rotated")
            $("#attendeeList").slideToggle(500, function(){
                if ($(this).is(":hidden")) {
                    $(this).css("display", "none");
                } else {
                    $(this).css("display", "block");
                }
            });
        });

        $(document).on("click", ".chatRoom", function() {
            location.href = "${path}/chat/room.do?gathering_id=" + $(this).data("room");
        });

        var connectHeaders = {};


        if(this_gathering_id!=""){
            connectHeaders = {
                "user_id" : cur_session,
                "inChatRoom" : this_gathering_id
            }
        }

        stomp.connect(connectHeaders, function () {

            //reconnect될 때 위치파악 작업 필요할듯
            stomp.subscribe("/sub/alarm/user/" + cur_session, function(msg){

                var alarmDto = JSON.parse(msg.body);
                var type = alarmDto.type;
                var message = alarmDto.message;
                var gathering_id = alarmDto.gathering_id;


                if(type == 'FOCUS'){
                    addToFocusList(gathering_id, message);

                    if(alarmDto.existingUnread == true){
                        unreadChatSpan.removeClass('hidden');
                    }
                    else{
                        unreadChatSpan.addClass('hidden');
                    }
                }

                else if(type == 'BLUR'){
                    removeFromFocusList(gathering_id, message);
                }


                else if(type=='ATTEND' || type == 'ACCEPTED'){
                    if (!chatList.includes(gathering_id)) {
                        chatList.push(gathering_id);
                        stomp.subscribe("/sub/chatting/room/" + gathering_id, handleChatMessage);
                    }

                    //방 있는지 먼저 확인하고
                    //채팅방 목록 업데이트
                    if($("#chatRoomList").find("div[data-room='" + gathering_id + "']").length == 0){

                        $.ajax({
                            type: "get",
                            data: {"gathering_id": gathering_id},
                            url: "${path}/chat/getNewRoom.do",
                            success: function(result){

                                if(result){
                                    $chatRoom = $("<div class='chatRoom' data-room='" + result.gathering_id + "'>"
                                        + "<div class='roomName'><div><h4>" + result.title + "</h4><span class='attendee_count'>"
                                        + result.attendee_count + "</span></div>"
                                        + "<span class='unread'></span></div>"
                                        + "<div class='lastChatTime'>" + result.lastChat.formattedDate + "</div>"
                                        + "<div>" + result.lastChat.message + "</div></div>");

                                    if(result.unread){
                                        $chatRoom.find(".unread").css("visibility", "visible");
                                    }

                                    $("#chatRoomList").prepend($chatRoom);

                                }
                            }
                        });
                    }


                    unreadChatSpan.removeClass('hidden');
                }

                else if(type=='LEAVE' || type == 'THROWN' || type == 'CLOSE') {
                    if (chatList.includes(gathering_id)) {
                        var index = chatList.indexOf(gathering_id);
                        if (index > -1) {
                            chatList.splice(index, 1);
                        }
                        stomp.unsubscribe("/sub/chatting/room/" + gathering_id);
                    }

                    //그게 이 방이라면?
                    if(this_gathering_id == gathering_id){
                        location.reload();
                    }

                    else{
                        stomp.unsubscribe("/sub/chatting/room/" + gathering_id);
                        room = $('.chatRoom[data-room="' + gathering_id + '"]');
                        room.remove();

                        //안읽은 메시지 업데이트
                        updateUnreadChatMessages();

                        //채팅방 목록 업데이트
                    }

                }

                if(type == 'ACCEPTED' || type == 'THROWN' || type == 'CLOSE') {
                    updateSession();
                }


                if(type == 'ACCEPTED' || type == 'THROWN' || type == 'DELETED'
                    || type == 'APPLY' || type == 'COMMENT' || type == 'REJECTED'){
                    //안읽은 알람 업데이트
                    unreadAlarmSpan.removeClass('hidden');

                    if($alarmList.is(":visible")){
                        $alarmList.scrollTop(0);
                        $alarmList.html("");
                        alarmCurPage = 1;
                        alarmEnd = false;
                        getAlarms();
                    }
                }

            });



            for (let i = 0; i < chatList.length; i++) {

                //현재 채팅방
                if (chatList[i] == this_gathering_id) {
                    $("#sendBtn").click(function(){
                        if($('#msg').val()!=''){
                            sendMessage("SEND");
                            $('#msg').val('');
                        }
                    });

                        stomp.subscribe("/sub/chatting/room/" + chatList[i], function(msg){
                        var chatMessageDto = JSON.parse(msg.body);
                        var type = chatMessageDto.type;
                        var sender = chatMessageDto.userId; //데이터를 보낸 사람
                        var message = chatMessageDto.message; //메시지


                        if(type == 'DELETED'){
                            //현재 채팅방이 DELETED됨! 세션 업데이트하고 새로고침
                            updateSession();
                            location.reload();
                        }

                        else{

                            var thisDate = chatMessageDto.formattedDate.substr(0, 10);
                            var thisTime = chatMessageDto.formattedDate.substr(11);
                            var dateTime = thisDate + " " + thisTime;
                            var nickname = "";


                        if(sender == cur_session){
                            if(lastTime == thisTime && lastDate == thisDate){
                                $(".message_mine:last-child").find("span[class='chatTime']").text("");
                            }

                            var str =
                                "<div class='message_mine'><span class='chatTime'>" + thisTime + "</span>"
                                + "<div class='messageContent'>"+message+"</div></div>";
                        }


                        else if(sender == 'SYSTEM'){

                            var str = "";

                            var index = message.indexOf("]");

                            if(index!=-1){
                                var user = message.substr(1, index-1);


                                //회원 처리
                                if(type == 'LEAVE' || type == 'THROW'){

                                    if($("#attendeeList").find("a[class='attendee-wrap'][data-user_id='" + user + "']").length > 0){
                                        $("#attendeeList").find("a[class='attendee-wrap'][data-user_id='" + user + "']").remove();
                                        thisRoom.find(".attendee_count").text(Number(thisRoom.find(".attendee_count").text())-1);
                                        $("#chatRoomInfo").find(".attendee_count").text(Number($("#chatRoomInfo").find(".attendee_count").text())-1);
                                    }
                                }

                                else if(type == 'ATTEND'){
                                    nickname = chatMessageDto.nickname;
                                    nicknameMap[user] = nickname;
                                    var profile = "";

                                    $.ajax({
                                        type: "get",
                                        url : "${path}/gathering/getProfile.do",
                                        async: false,
                                        data : {
                                            "user_id" : user
                                        },
                                        success: function(result){
                                            if(result){
                                                profile = result.profile;
                                            }
                                            else alert("에러가 발생했습니다.");
                                        },
                                        error: function(){
                                            alert("에러가 발생했습니다.");
                                        }
                                    });


                                    //개수 체크먼저 하자

                                    if($("#attendeeList").find("a[class='attendee-wrap'][data-user_id='" + user + "']").length == 0){
                                        $attendee = "<a class='attendee-wrap' data-user_id='" + user + "' href='${path}/mypage/goMypage/" + user + "'>"
                                            + "<div class='attendee'><img src='${path}/images/" + profile + "'>"
                                            + "<span>" + nickname + "</span></div></a>";

                                        $("#attendeeList").append($attendee);
                                        thisRoom.find(".attendee_count").text(Number(thisRoom.find(".attendee_count").text())+1);
                                        $("#chatRoomInfo").find(".attendee_count").text(Number($("#chatRoomInfo").find(".attendee_count").text())+1);

                                    }

                                }


                                if(nicknameMap[user]){
                                    nickname = nicknameMap[user];
                                } else if(chatMessageDto.nickname && chatMessageDto.nickname!=""){
                                    nickname = chatMessageDto.nickname;
                                } else{

                                    $.ajax({
                                        type: "get",
                                        url : "${path}/gathering/getNickname.do",
                                        async: false,
                                        data : {
                                            "user_id" : user
                                        },
                                        success: function(result){
                                            if(result){
                                                nicknameMap[user] = result.nickname;
                                                nickname = result.nickname;
                                            }
                                            else alert("에러가 발생했습니다.");
                                        },
                                        error: function(){
                                            alert("에러가 발생했습니다.");
                                        }
                                    });

                                }


                                str =
                                    "<div class='message_notice'>"+
                                    "<div class='messageContent'>"+nickname+message.substr(index+1)+"</div></div>";

                                message = nickname+message.substr(index+1);

                            }

                            else{
                                str =
                                    "<div class='message_notice'>"+
                                    "<div class='messageContent'>"+message+"</div></div>";

                            }
                        }

                        else{
                            if(lastTalker == sender && lastTime == thisTime && lastDate == thisDate){
                                $(".message_yours:last-child").find("span[class='chatTime']").text("");
                            }

                            else{
                                nickname = nicknameMap[sender];
                            }

                            var str =
                                "<div class='message_yours'><div class='sender'>"+nickname+"</div>"
                                +"<div><div class='messageContent'>"+message+"</div>"
                                + "<span class='chatTime'>" + thisTime + "</span></div></div>";
                        }


                            thisRoom.find("div[class='lastChatTime']").text(dateTime);
                            thisRoom.find("div[class='lastChatTime']").next().text(message);
                            $("#chatRoomList").prepend(thisRoom);

                        let msgArea = $("#msgArea");
                        msgArea.append(str);

                        let height = msgArea.prop('scrollHeight');
                        let position = msgArea.scrollTop();

                        if(position>(height - 800)){
                            msgArea.scrollTop(height);
                        }

                        lastTime = thisTime;
                        lastDate = thisDate;
                        lastTalker = sender;
                        nickname = "";


                        if (sender != cur_session && !focusList.hasOwnProperty(this_gathering_id)){
                            thisRoom.find("span[class='unread']").css("visibility", "visible");
                            unreadChatSpan.removeClass('hidden');
                        }

                        }



                        });



                    if(window.onfocus){
                        var focusMessageDTO = {
                            receiver_id: cur_session,
                            type: "FOCUS",
                            gathering_id: this_gathering_id
                        };
                        stomp.send('/pub/chatting/room', {}, JSON.stringify(focusMessageDTO));
                    }


                    window.addEventListener('focus', function() {
                        thisRoom.find("span[class='unread']").css("visibility", "hidden");

                        var existingUnread = updateUnreadChatMessages();

                        var focusMessageDTO = {
                            receiver_id: cur_session,
                            type: "FOCUS",
                            gathering_id: this_gathering_id,
                            existingUnread: existingUnread
                        };

                        stomp.send('/pub/chatting/room', {}, JSON.stringify(focusMessageDTO));

                    });

                    window.addEventListener('blur', function() {
                        var blurMessageDTO = {
                            receiver_id: cur_session,
                            type: "BLUR",
                            gathering_id: this_gathering_id
                        };
                        stomp.send('/pub/chatting/room', {}, JSON.stringify(blurMessageDTO));
                    });


                    //다른 방인 경우
                } else {
                    stomp.subscribe("/sub/chatting/room/" + chatList[i], handleChatMessage);

                }
            }

            stomp.heartbeat.outgoing = 10000;
            stomp.heartbeat.incoming = 10000;

        });


        if(this_gathering_id != ""){

            $(".chatRoom[data-room='" + this_gathering_id + "']").eq(0).addClass("selectedRoom");
            let msgArea = $("#msgArea");
            let height = msgArea.prop('scrollHeight');
            msgArea.scrollTop(height);

            msgArea.scroll(function() {

                if(msgArea.scrollTop() < 200) {

                    if (end == false && loading == false){
                        loading = true;
                        curPage ++;


                        $.ajax({
                            type: "get",
                            url : "${path}/chat/viewMoreChat.do",
                            async: false,
                            data : {
                                "gathering_id" : this_gathering_id,
                                "curPage" : curPage,
                                "dateString" : '${accessDate}'
                            },
                            success: function(result) {
                                //채팅목록
                                list = result.list;

                                if(list.length < size) {
                                    end = true;
                                }

                                let div = "";
                                let thisDate = "";
                                let thisTime = "";
                                let thisTalker = "";
                                let dateDiv = "";
                                let nextDate = "";
                                let thisNickname = "";

                                //이렇게 하면 안되고 text()로 값 꺼내와야 함

                                for (var i = 0; i < list.length; i++) {
                                    thisTalker = list[i].userId;
                                    if(nextDate!=""){
                                        thisDate = nextDate;
                                    }

                                    else thisDate = list[i].formattedDate.substr(0, 10);
                                    thisTime = list[i].formattedDate.substr(11);

                                    if(list[i+1]!=null){
                                        nextDate = list[i+1].formattedDate.substr(0, 10);
                                    }
                                    else nextDate = "";

                                    if(list[i-1]!=null && list[i-1].userId == thisTalker &&
                                        list[i-1].formattedDate == list[i].formattedDate){
                                        thisTime = "";
                                    }

                                    if(list[i+1]!=null && list[i+1].userId == thisTalker
                                        && list[i+1].formattedDate == list[i].formattedDate){
                                        thisTalker = "";
                                    }

                                    if(thisTalker != "") thisNickname = nicknameMap[thisTalker];

                                    if(firstDate == thisDate && dateDiv=="") {
                                        if ($('.chatDate')) {
                                            $('.chatDate').eq(0).closest("div[class='message_notice']").remove();
                                            dateDiv = "<div class='message_notice'><div class='messageContent chatDate'>" + thisDate + '</div></div>';
                                        }
                                    }

                                    if (list[i].userId == cur_session) {
                                        div = "<div class='message_mine'><span class='chatTime'>" + thisTime + "</span>" +
                                            "<div class='messageContent'>" + list[i].message + "</div></div>" + div;

                                    } else if (list[i].userId == 'SYSTEM') {

                                        var index = list[i].message.indexOf("]");
                                        var user = "";
                                        if(index!=-1){
                                            user = list[i].message.substr(1, index-1);
                                            let nickname = nicknameMap[user];
                                            div = "<div class='message_notice'><div class='messageContent'>" + nickname + list[i].message.substr(index+1) + "</div></div>" + div;
                                        }
                                        else{
                                            div = "<div class='message_notice'><div class='messageContent'>" + list[i].message + "</div></div>" + div;
                                        }

                                    } else {
                                        div = "<div class='message_yours'><div class='sender'>" + thisNickname + "</div>"
                                            + "<div><div class='messageContent'>" + list[i].message + "</div>"
                                            + "<span class='chatTime'>" + thisTime + "</span></div></div>" + div;
                                    }

                                    if(firstDate != thisDate || i == list.length-1){
                                        if(dateDiv!='')
                                            div = dateDiv + div;
                                        else
                                            div = "<div class='message_notice'><div class='messageContent chatDate'>" + thisDate + '</div></div>' + div;
                                    }

                                    firstDate = thisDate;
                                    firstTime = list[i].formattedDate.substr(11);
                                    firstTalker = list[i].userId;
                                    thisNickname = "";
                                }
                                let msgArea = $("#msgArea");
                                msgArea.prepend(div);

                            },
                            error: function(){
                                alert("에러가 발생했습니다.");
                            }
                        });
                    }
                }

                loading = false;

        });

    }


    });


    function handleChatMessage(msg){

        var chatMessageDto = JSON.parse(msg.body);
        var message = chatMessageDto.message; //메시지
        var dateTime = chatMessageDto.formattedDate.replace('T', ' ');
        var sender = chatMessageDto.userId; //데이터를 보낸 사람
        var type = chatMessageDto.type;
        var gathering_id = chatMessageDto.gathering_id;

        //이 채팅방을 찾아서 제일 위로
        room = $('.chatRoom[data-room="' + gathering_id + '"]');


        if(type == 'DELETED'){
            //채팅방 삭제시키고 unsubscribe
            if (chatList.includes(gathering_id)) {
                var index = chatList.indexOf(gathering_id);
                if (index > -1) {
                    chatList.splice(index, 1);
                }
                stomp.unsubscribe("/sub/chatting/room/" + gathering_id);
                updateSession();
                room.remove();
            }
        }


        else{

            if(sender == 'SYSTEM'){
                var index = message.indexOf("]");
                if(index!=-1){
                    var user = message.substr(1, index-1);
                    var nickname = "";
                    $.ajax({
                        type: "get",
                        url : "${path}/gathering/getNickname.do",
                        async: false,
                        data : {
                            "user_id" : user
                        },
                        success: function(result){
                            if(result){
                                nicknameMap[user] = result.nickname;
                                nickname = result.nickname;
                            }
                            else alert("에러가 발생했습니다.");
                        },
                        error: function(){
                            alert("에러가 발생했습니다.");
                        }
                    });
                }

                message = nickname+message.substr(index+1);
            }

            room.find("div[class='lastChatTime']").text(dateTime);
            room.find("div[class='lastChatTime']").next().text(message);


            if (sender != cur_session && !focusList.hasOwnProperty(gathering_id)){
                room.find("span[class='unread']").css("visibility", "visible");
                unreadChatSpan.removeClass('hidden');
            }


            $("#chatRoomList").prepend(room);

        }

    }


    function sendMessage(type){

        var messageDTO = {
            userId: cur_session,
            nickname: curNickName,
            message: $("#msg").val(),
            type: type,
            gathering_id: this_gathering_id,
        };

        stomp.send('/pub/chatting/message', {}, JSON.stringify(messageDTO));
    }


    function enterChat(e){
        if(e.keyCode == 13){
            if($('#msg').val()!=''){
                sendMessage("SEND");
                $('#msg').val('');
            }
        }
        else return;
    }


    function withdraw(){
        if("${dto.writer_id}" == "${sessionScope.userid}") {
            if (confirm("채팅방을 나가려면 게시글을 삭제해야 합니다.\n게시글 상세페이지로 이동하시겠습니까?")){
                location.href="${path}/gathering/view/" + this_gathering_id;
                return;
            }
            else return;
        }

        if(confirm("채팅방을 나가려면 모임을 탈퇴해야 합니다.\n정말로 이 모임에서 탈퇴하시겠습니까?")){
            $.ajax({
                type: "get",
                url : "${path}/gathering/withdraw.do",
                data : {
                    "gathering_id": this_gathering_id
                },
                success: function(result){
                    location.href="${path}/chat/room.do";
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


    function updateUnreadChatMessages(){
        var unreadSpans = $("span.unread[style='visibility:visible']");
        if(unreadSpans.length > 0) {
            unreadChatSpan.removeClass('hidden');
            return true;
        }
        else{
            unreadChatSpan.addClass('hidden');
            return false;
        }
    }



    function updateSession(){
        $.ajax({
            type: "get",
            url: "${path}/chat/updateByAlarm.do/"
        });
    }


    function addToFocusList(gathering_id, message){
        if (focusList.hasOwnProperty(gathering_id)) {
            focusList[gathering_id].push(message);
        } else {
            focusList[gathering_id] = [message];
        }
    }

    function removeFromFocusList(gathering_id, message){
        if (focusList.hasOwnProperty(gathering_id)) {
            var index = focusList[gathering_id].indexOf(message);
            if (index !== -1) {
                focusList[gathering_id].splice(index, 1);
                if(focusList[gathering_id].length == 0){
                    delete focusList[gathering_id];
                }
            }
        }
    }




</script>




</body>
</html>
