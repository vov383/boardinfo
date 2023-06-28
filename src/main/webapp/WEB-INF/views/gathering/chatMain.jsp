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
		border-top: 1px solid #D9D9D9;
		padding-top: 10px;
		display: flex;
	}
	
	#contentsMain > div{
		display: flex;
		flex-direction: column;
	}
	
	#chatRoomListBox{
		min-width: 300px;
		margin-right: 20px;
		flex-grow: 0;
	}

    #chatRoomList{
        height: 500px;
        overflow: auto;
        border: 1px solid #d9d9d9;
        padding: 1px;
    }
	
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

    .attendees{
        font-size: 13px;
    }

    .unread{
        width: 4px;
        height: 4px;
        background-color: red;
        border-radius: 50px;
        opacity: 0;
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
	}

	#chatRoomInfo > div:first-child{
		flex-grow: 1;
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
	
	#chatRoomInfo button{
		height: 100%;
		border: 1px solid black;
		font-size: 16px;
		font-weight: bold;
		background-color: white;
		width: 112px;
		cursor: pointer;
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
	  <form name="chatRoomSearch">
	  <input name="chatRoomKeyword" placeholder="채팅방 검색">
	  <img src="${path}/images/search.png" onclick="" width="20px">
	  </form>
  <div id="chatRoomList">
	  <c:forEach var="room" items="${rlist}">
		  <div class="chatRoom" data-room="${room.gathering_id}">
			  <div class="roomName">
                  <div><h4>${room.title}</h4><span class="attendees">${room.attendee_count}</span></div>
                  <span class="unread"></span>
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
              <div id="alarmBox"></div>
              <div>
                  <a href="${path}/gathering/view/${dto.gathering_id}">${dto.title}</a>
                  <span>${dto.attendee_count}/${dto.maxPeople}명 참가중</span>
              </div>
              <button type="button" onclick="withdraw()">채팅방 나가기</button>
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
    var cur_session = '${user_id}'; //현재 로그인한 사람

    let end = false;
    let loading = false;
    let size = 20;

    let firstDate = "${firstDate}";

    let nicknameMap = ${nicknameMap};

    var lastTalker = "${lastTalker}";
    var lastDate = "${lastDate}";
    var lastTime = "${lastTime}";


    var sock = new SockJS('http://localhost:80/ws-stomp');
    var stomp = Stomp.over(sock);
    let list;
    let chatList = {};
    var gathering_id = "${gathering_id}";


    $(function(){
        $(".chatRoom").click(function(){
            location.href = "${path}/gathering/chatRoom.do?gathering_id=" + $(this).data("room");
        });

        if("${message}"!=""){
            alert("${message}");
        }

        //여기서 채팅 연결시키자
        $.ajax({
            type: "get",
            url : "${path}/gathering/getMyActiveChats.do",
            async: false,
            success: function(result) {
                list = result.glist;
            }
            });


        var connectHeaders = {};

        stomp.connect({}, function () {

            stomp.subscribe("/sub/alarm/user/" + cur_session, function(msg){

                var chatMessageDto = JSON.parse(msg.body);
                var type = chatMessageDto.type; //데이터를 보낸 사람
                var message = chatMessageDto.message; //메시지
                var gathering_id = chatMessageDto.gathering_id;

                if(type == 'FOCUS'){
                    if (chatList.hasOwnProperty(gathering_id)) {
                        chatList[gathering_id].push(message);
                    } else {
                        chatList[gathering_id] = [message];
                    }
                }

                else if(type == 'BLUR'){
                    if (chatList.hasOwnProperty(gathering_id)) {
                        const index = chatList[gathering_id].indexOf(message);
                        if (index !== -1) {
                            chatList[gathering_id].splice(index, 1);
                            if(chatList[gathering_id].length == 0){
                                delete chatList[gathering_id];
                            }
                        }
                    }
                }

                $("#alarmBox").text(JSON.stringify(chatList));

            });

            for (let i = 0; i < list.length; i++) {

                if (list[i] == gathering_id) {
                    $("#sendBtn").click(function(){
                        if($('#msg').val()!=''){
                            sendMessage("SEND");
                            $('#msg').val('');
                        }
                    });

                        stomp.subscribe("/sub/chat/room/" + list[i], function(msg){
                        var chatMessageDto = JSON.parse(msg.body);
                        var sender = chatMessageDto.userId; //데이터를 보낸 사람
                        var message = chatMessageDto.message; //메시지

                        var thisDate = chatMessageDto.formattedDate.substr(0, 10);
                        var thisTime = chatMessageDto.formattedDate.substr(11);
                        var dateTime = thisDate + " " + thisTime;
                        var nickname = "";


                            if(sender == 'SYSTEM'){
                                var index = message.indexOf("]");
                                if(index!=-1){
                                    var user = message.substr(1, index-1);
                                    nickname = nicknameMap[user];
                                    if(!nickname) {
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
                            }

                        var room = $('.chatRoom[data-room="' + list[i] + '"]');
                        room.find("div[class='lastChatTime']").text(dateTime);
                        room.find("div[class='lastChatTime']").next().text(message);
                        $("#chatRoomList").prepend(room);


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
                                nickname = nicknameMap[user];
                                if(!nickname) {
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

                        });

                    var openMessageDTO = {
                        userId: cur_session,
                        type: "FOCUS",
                        gathering_id: "${gathering_id}",
                    };


                    var closeMessageDTO = {
                        userId: cur_session,
                        type: "BLUR",
                        gathering_id: "${gathering_id}",
                    };

                    if(document.hasFocus()){
                        stomp.send('/pub/chat/room', {}, JSON.stringify(openMessageDTO));
                        $(".selectedRoom").css("background-color", "blue");
                    }

                    window.addEventListener('focus', function() {
                        stomp.send('/pub/chat/room', {}, JSON.stringify(openMessageDTO));
                        $(".selectedRoom").css("background-color", "blue");
                    });

                    window.addEventListener('blur', function() {
                        stomp.send('/pub/chat/room', {}, JSON.stringify(closeMessageDTO));
                        $(".selectedRoom").css("background-color", "red");
                    });


                } else {
                    stomp.subscribe("/sub/chat/room/" + list[i], function (msg) {
                        //이 채팅방을 찾아서 제일 위로
                        var room = $('.chatRoom[data-room="' + list[i] + '"]');

                        var chatMessageDto = JSON.parse(msg.body);
                        var message = chatMessageDto.message; //메시지
                        var dateTime = chatMessageDto.formattedDate.replace('T', ' ');
                        var sender = chatMessageDto.userId; //데이터를 보낸 사람


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

                        if (sender != cur_session){
                            room.find("span[class='unread']").css("opacity", 100);
                        }
                        $("#chatRoomList").prepend(room);


                    });
                }
            }

            stomp.heartbeat.outgoing = 10000;
            stomp.heartbeat.incoming = 10000;

        });


        if(gathering_id != ""){

            $(".chatRoom[data-room='" + "${gathering_id}" + "']").eq(0).addClass("selectedRoom");
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
                            url : "${path}/gathering/viewMoreChat.do",
                            async: false,
                            data : {
                                "gathering_id" : "${gathering_id}",
                                "curPage" : curPage
                            },
                            success: function(result) {
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
                                            nickname = nicknameMap[user];
                                            div = "<div class='message_notice'><div class='messageContent'>" + list[i].message.substr(index+1) + "</div></div>" + div;
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


    function sendMessage(type){

        var messageDTO = {
            userId: "${user_id}",
            message: $("#msg").val(),
            type: type,
            gathering_id: "${gathering_id}",
        };

        stomp.send('/pub/chat/message', {}, JSON.stringify(messageDTO));
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
                location.href="${path}/gathering/view/${dto.gathering_id}";
                return;
            }
            else return;
        }

        if(confirm("채팅방을 나가려면 모임을 탈퇴해야 합니다.\n정말로 이 모임에서 탈퇴하시겠습니까?")){
            $.ajax({
                type: "get",
                url : "${path}/gathering/withdraw.do",
                data : {
                    "gathering_id": "${dto.gathering_id}"
                },
                success: function(result){
                    location.href="${path}/gathering/chatRoom.do";
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


</script>




</body>
</html>