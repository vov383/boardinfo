<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
  <div id="footer">
    <div class="footerMain">
      서울특별시 강남구 테헤란로14길 6 남도빌딩 2,3F<br>
      KH정보교육원 TEAM BOARDINFO
    </div>
    <div class="footerSub">
      <div class="footerSubLeft"></div>
      <div class="footerSubCenter"></div>
      <div class="footerSubRight">
        <c:if test="${sessionScope.userid==null && sessionScope.admin_id==null}">
          <button id="adminLoginBtn">관리자 로그인</button>
        </c:if>
      </div>
    </div>
  </div>
</footer>

<script>


  let chatList;
  let focusList = {};

  //for sujin
  var sock = new SockJS('http://localhost:8098/ws-stomp-out');

  //for others
  //var sock = new SockJS('http://localhost:80/ws-stomp-out');

  //for taeyoung
  //var sock = new SockJS('http://localhost:80/board-info/ws-stomp-out');


  var stomp = Stomp.over(sock);
  stomp.debug = null;


  //로그인 풀리면 채팅도 연결 끊어야 함
  let cur_session = '${userid}';
  const unreadChatSpan = $("#unreadChat");


  $(function (){

    $("#adminLoginBtn").on("click", function () {
      const adminLoginBtn = document.getElementById("adminLoginBtn");
      location.href = "${path}/admin/admin_login.do";
    });


    if(cur_session !=""){

      chatList = JSON.parse('${sessionScope.activeChats}');

      updateUnreadChatMessages();


      stomp.connect({}, function () {

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

            //안읽은 메시지 업데이트
            updateUnreadChatMessages();
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
              end = false;

              getAlarms();
            }
          }

        });


        for (let i = 0; i < chatList.length; i++) {
          stomp.subscribe("/sub/chatting/room/" + chatList[i], handleChatMessage);
        }
      });


    }


  });


  function handleChatMessage(msg){
    var chatMessageDto = JSON.parse(msg.body);
    var sender = chatMessageDto.userId; //데이터를 보낸 사람
    var msg_gathering_id = chatMessageDto.gathering_id; //채팅방
    var type = chatMessageDto.type;


    if(type == 'DELETED'){
      //알람으로 처리해야 함
      if (chatList.includes(msg_gathering_id)) {
        var index = chatList.indexOf(msg_gathering_id);
        if (index > -1) {
          chatList.splice(index, 1);
        }
        stomp.unsubscribe("/sub/chatting/room/" + msg_gathering_id);
      }

      //세션 업데이트
      updateSession();

      //안읽은 메시지 업데이트
      updateUnreadChatMessages();

    }


    else if(sender != cur_session && !focusList[msg_gathering_id]){

      let message = chatMessageDto.message;
      let nickname = chatMessageDto.nickname;

      if(sender == 'SYSTEM'){
        let user_nickname = nickname;
        nickname = '알림';

        //내가 나가거나 나가진 거라면 채팅을 업데이트할 필요 없음
        if(type == 'LEAVE' || type == 'THROW'){
          if(user_nickname == '${sessionScope.nickname}'){
            return;
          }
        }

        let index = message.indexOf("]");
        if(index!=-1) {
          message = user_nickname + message.substr(index + 1);
        }
      }

      unreadChatSpan.removeClass('hidden');

      var chatAlarm = $("<span class='chatMessages'>" + nickname + ": "
              + message + "</span>");
      chatAlarm.click(function(){
        location.href = "${path}/chat/room.do?gathering_id=" + msg_gathering_id;
      });

      $(".toast-chat").append(chatAlarm);

      chatAlarm.fadeIn(100, function() {
        setTimeout(function() {
          chatAlarm.slideUp(300, function() {
            $(this).remove();
          });
        }, 7000);

      });
    }
  }


  function updateUnreadChatMessages(){

    $.ajax({
      type: "get",
      url: "${path}/chat/unreadCount.do/",
      success: function (result) {
        let unread = result.unread;
        if(unread) {
          unreadChatSpan.removeClass('hidden');
        }
        else {
          unreadChatSpan.addClass('hidden');
        }

      }
    });

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