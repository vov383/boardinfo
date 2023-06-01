<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<title>채팅</title>
  <%@ include file="../include/js/header.jsp" %>

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
		border: 1px solid #D9D9D9;
		padding: 12px 10px;
	}
	
	.roomName{
		display: flex;
	}
	
	.chatRoom h4{
		font-size: 15px;
		margin: 0 5px 0 0;
		max-width: 200px;
		padding: 0;
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
	
	#chatRoomInfo > div:first-child > span:first-child{
		padding-left: 10px;
		font-size: 20px;
		font-weight: bold;
	}
	
	#chatRoomInfo > div:first-child > span:nth-child(2) {
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
	
	#msg{
		flex-grow: 1;
		height: 37px;
		padding:  0 40px 0 15px;
		background-color: #3D3D43;
		color: white;
	}
	
	#msg::placeholder{
		color: #D9D9D9;
	}
	
	#sendBtn{
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


<script>

$(function(){
	
	$("#sendBtn").click(function(){
		//sendMessage("SEND");
		$('#msg').val('');
	});
	
});


//var sock = new SockJS('http://localhost:80/boardinfo/chatting');
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
		var str = 
			"<div class='message_mine'><span class='chatTime'>오후 7:30</span>"
				+ "<div class='messageContent'>"+message+"</div></div>";
	}

	else if(sender == '알림'){
		var str =
				"<div class='message_notice'>"+
				"<div class='messageContent'>"+message+"</div></div>";
	}
	
	else{
		var str = 
			"<div class='message_yours'><div class='sender'>"+sender+"</div>"
				+"<div><div class='messageContent'>"+message+"</div>"
				+ "<span class='chatTime'>오후 7:30</span></div>";
	}
	$("#msgArea").append(str);	
	
	
}


//채팅방에서 나갔을 때
function onClose(evt){
	alert('종료');
	/*
	var user = "${userId}";
	//var user = '${pr.username}'; //나간사람 이름
	var str = "알림: " + user + "님이 퇴장하셨습니다.";
	$("#msgArea").append(str);
	*/
}


//채팅방에 들어왔을 때
function onOpen(evt){
	sendMessage("OPEN");
}



</script>

</head>
<body>

<%@include file="../include/top.jsp" %>

<div id="contents">
  <div id="contentsHeader">
    <h2>채팅</h2>
  </div>
  <div id="contentsLocation">
    홈 &gt 마이페이지 &gt 채팅
  </div>
  
  <div id="contentsMain">
  
  <div id="chatRoomListBox">
	  <form name="chatRoomSearch">
	  <input name="chatRoomKeyword" placeholder="채팅방 검색">
	  <img src="${path}/images/search.png" onclick="" width="20px">
	  </form>
  <div id="chatRoomList">
	  <div class="chatRoom selectedRoom">
	  	<div class="roomName">
	  		<h4>수원 레드버튼에서 모여요~!</h4><span>(3)</span>
	  	</div>
	  	<div class="lastChatTime">오후 4:15</div>
	  	<div>그럼 저희 테라포밍마스 할까요?</div>
	  </div>
	  <div class="chatRoom">
	  	<div class="roomName">
	  		<h4>수원 레드버튼에서 모여요~!</h4><span>(3)</span>
	  	</div>
	  	<div class="lastChatTime">오후 4:15</div>
	  	<div>그럼 저희 테라포밍마스 할까요?</div>
	  </div>
	  <div class="chatRoom">
	  	<div class="roomName">
	  		<h4>수원 레드버튼에서 모여요~!</h4><span>(3)</span>
	  	</div>
	  	<div class="lastChatTime">오후 4:15</div>
	  	<div>그럼 저희 테라포밍마스 할까요?</div>
	  </div>
  </div>
  </div>
  
  <div id="msgBox">
  	<div id="chatRoomInfo">
  		<div>
  			<span>수원 레드버튼에서 모여요~!</span>
  			<span>3명 참가중</span>
  		</div>
  		<button type="button">채팅방 나가기</button>
  	</div>
  	<div id="msgArea">
	
	</div>
	<div>
	<input id="msg" placeholder="텍스트를 입력해주세요.">
	<img id="sendBtn" src="${path}/images/chatSend.png" onclick="">
	</div>
</div>
  
  </div>


  </div>
</div>

<%@include file="../include/footer.jsp" %>  
  

</body>
</html>