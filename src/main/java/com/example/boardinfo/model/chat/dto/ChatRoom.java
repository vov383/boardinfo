package com.example.boardinfo.model.chat.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class ChatRoom {

	private int gathering_id;
	
	//세션과 함께 해당 세션 사용자의 아이디를 String값으로 넣어줌
	private Map<WebSocketSession, String> sessions = new HashMap<>();
	
	
	public static ChatRoom create(int gathering_id)
	{
	  ChatRoom chatRoom = new ChatRoom();
	  chatRoom.gathering_id = gathering_id;
	  return chatRoom;
	}
	
	public Map<WebSocketSession, String> getSessions() {
		return sessions;
	}


	public void setSessions(Map<WebSocketSession, String> sessions) {
		this.sessions = sessions;
	}

	public int getGathering_id() {
		return gathering_id;
	}

	public void setGathering_id(int gathering_id) {
		this.gathering_id = gathering_id;
	}
	

	public void send(ChatMessageDTO chatMessage) throws Exception{
		ObjectMapper objectMapper = new ObjectMapper();
		
		TextMessage textMessage = 
				new TextMessage(objectMapper.writeValueAsString(chatMessage));
		
		//sessions를 돌아다니면서 open된 소켓에다가 메시지 뿌려주기
		for(WebSocketSession s : sessions.keySet()) {
			if(s.isOpen()) {
				s.sendMessage(textMessage);
			}
		}
	}
	
	
	public void addSession (WebSocketSession session, String userId) {
		sessions.put(session, userId);
	}
	
	public void removeSession (WebSocketSession session) {
		sessions.remove(session);
	}

	public ArrayList<WebSocketSession> getAllSessions() {
		if(sessions == null || sessions.isEmpty()) {
			return null;
		}
		return (ArrayList)sessions;
	}

	public String getUserIdBySession(WebSocketSession session) {
		return sessions.get(session);
	}

	
	
	

}
