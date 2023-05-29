<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<!-- 
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"> </script>
 -->

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<title>Insert title here</title>

<script>

$(function(){
	
	$("#sendBtn").click(function(){
		sendMessage("SEND");
		$('#msg').val('');
	});
	
});


var sock = new SockJS('http://localhost:8098/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;



function sendMessage(type){
	
	var messageDTO = {
			message: $("#msg").val(),
			type: type,
			gathering_id: 1,
	};
	
	var jsonPayload = JSON.stringify(messageDTO);
	sock.send(jsonPayload);	

}


//서버로부터 메시지를 받을 때
function onMessage(msg){
	
	//받은 메시지의 데이터를 data에 저장
	var chatMessageDto = JSON.parse(msg.data);
	var sender = chatMessageDto.userId; //데이터를 보낸 사람
	var message = chatMessageDto.message; //메시지
	var cur_session = '${userId}'; //현재 세션에 로그인한 사람
	//컨트롤러에서 이미 userid 이름으로 넘겨줬음
	
	//로그인한 클라이언트와 타 클라이언트 분류하기 (css적으로다가)
	//시간없으니까 그냥 통일시켜
	if(sender == cur_session){ //내가 보낸 메시지라면
		var str = "<div><div>"+sender+": "+message+"</div></div>";
		$("#msgArea").append(str);
	}
	
	else{
		var str = "<div><div>"+sender+": "+message+"</div></div>";
		$("#msgArea").append(str);		
	}
	
	
}


//채팅방에서 나갔을 때
function onClose(evt){
	alert('종료');
	var user = "${userId}";
	//var user = '${pr.username}'; //나간사람 이름
	var str = "알림: " + user + "님이 퇴장하셨습니다.";
	$("#msgArea").append(str);		
}


//채팅방에 들어왔을 때
function onOpen(evt){
	sendMessage("OPEN");
}



</script>

</head>
<body>

<h2>임시채팅방</h2>
<div id="container">
	<div id="msgArea">
	</div>
	<input id="msg">
	<button id="sendBtn">전송</button>
</div>


</body>
</html>