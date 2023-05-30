package com.example.boardinfo.handler;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.controller.chat.ChatController;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.chat.dto.ChatRoom;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO.MessageType;
import com.example.boardinfo.service.chat.ChatRoomStore;
import com.google.gson.Gson;


public class ChatHandler extends TextWebSocketHandler {
	
	private static final org.slf4j.Logger logger = 
			LoggerFactory.getLogger(ChatController.class);
	
	@Inject
	ChatRoomStore chatRoomStore;

	private final List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		logger.info("#ChatHandler, afterConnectionEstablished");
		
		/*
		sessionList.add(session); 

		Map<String, Object> map = session.getAttributes();
		String user_id = (String)map.get("user_id");
		logger.info(user_id + "님이 입장하셨습니다.");
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage("알림: " + user_id + "님이 입장하셨습니다."));
		}
		*/
	}

	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("#ChattingHandler, handleMessage");
		
		Map<String, Object> map = session.getAttributes();
		String userId = (String)map.get("userId");
		System.out.println("아이디는 " + userId);
		
		Gson gson = new Gson();
		ChatMessageDTO chatMessage = gson.fromJson(message.getPayload(), ChatMessageDTO.class);
		chatMessage.setUserId(userId);
		System.out.println(chatMessage.toString());

		if(chatMessage.getType() == MessageType.OPEN) {
			ChatRoom room = chatRoomStore.joinOrCreateRoom(session, chatMessage.getGathering_id(), chatMessage.getUserId());
			chatRoomStore.handleMessage(room, session, chatMessage);
		} else {
			try {
				ChatRoom room = chatRoomStore.getChannelByGatheringId(chatMessage.getGathering_id());
				chatRoomStore.handleMessage(room, session, chatMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*
		Map<String, Object> map = session.getAttributes();
		String user_id = (String)map.get("user_id");
		
		logger.info(user_id + ": " + message);


		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(user_id + ": " + message.getPayload()));
		}
		*/
		
	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("#ChattingHandler, afterConnectionClosed");
		
		ChatRoom room = chatRoomStore.findRoomWithSession(session);
		ChatMessageDTO message = new ChatMessageDTO();
		message.setType(MessageType.CLOSE);
		message.setUserId(room.getUserIdBySession(session));
		chatRoomStore.handleMessage(room, session, message);
		
		/*
		sessionList.remove(session); 
		
		Map<String, Object> map = session.getAttributes();
		String user_id = (String)map.get("user_id");

		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage("알림: " + user_id + "님이 퇴장하셨습니다."));
		}
		*/
		
	}


	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("에러발생");
	}
	
	
	


	
	

}
