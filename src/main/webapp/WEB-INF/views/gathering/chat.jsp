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
		sendMessage();
		$('#msg').val('');
	});
	
});


var sock = new SockJS('http://localhost:80/boardinfo/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;


function sendMessage(){
	sock.send($("#msg").val());	
}


//서버로부터 메시지를 받을 때
function onMessage(msg){
	
	//받은 메시지의 데이터를 data에 저장
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	//데이터를 :를 기준으로 쪼갠다
	var arr = data.split(":");
	//지금은 1234, message로 분리되어 있음.
	
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
	}
	
	
	var cur_session = '${userid}'; //현재 세션에 로그인한 사람
	//컨트롤러에서 이미 userid 이름으로 넘겨줬음
	
	console.log("cur_session : " + cur_session);
	//콘솔에 user_id찍어보고
	
	sessionId = arr[0];
	message = arr[1]; //근데 이렇게 하면 메시지 중간에 :를 못쓰지 않나
	//일단 이렇게 해봐~~ arr0은 보낸사람이고 그 뒤는 메시지
	
	//로그인한 클라이언트와 타 클라이언트 분류하기 (css적으로다가)
	//시간없으니까 그냥 통일시켜
	if(sessionId == cur_session){ //내가 보낸 메시지라면
		var str = "<div><div>"+sessionId+":"+message+"</div></div>";
		$("#msgArea").append(str);
	}
	
	else{
		var str = "<div><div>"+sessionId+":"+message+"</div></div>";
		$("#msgArea").append(str);		
	}
	
	
}


//채팅방에서 나갔을 때
function onClose(evt){
	
	alert('종료');
	var user = "${user_id}";
	//var user = '${pr.username}'; //나간사람 이름
	var str = user + "님이 퇴장하셨습니다.";
	$("#msgArea").append(str);		
}


//채팅방에 들어왔을 때
function onOpen(evt){
	var user = "${user_id}";
	//var user = '${pr.username}';
	var str = user + "님이 입장하셨습니다.";
	$("#msgArea").append(str);
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