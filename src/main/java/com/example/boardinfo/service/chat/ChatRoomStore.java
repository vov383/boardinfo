package com.example.boardinfo.service.chat;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.chat.dto.ChatRoom;

@Component
public class ChatRoomStore {
	
	@Inject 
	private ChatMessageDAO dao;
	
	//gathering_id를 key로 갖는 ChatRoom map
	private Map<Integer, ChatRoom> map;
	
	@PostConstruct
	private void init() {
		map = new LinkedHashMap<Integer, ChatRoom>();
	}
	
	
	public ChatRoom getChannelByGatheringId(Integer gathering_id) {
		ChatRoom room = map.get(gathering_id);
		return room;
	}
	
	//해당 gathering_id의 채팅방이 존재하면 참가하고, 없으면 생성한 후 참가
	public ChatRoom joinOrCreateRoom (WebSocketSession session, int gathering_id, String userId) {
		ChatRoom room = null;
		room = map.get(gathering_id);
		if(room == null) { //해당 채팅방이 없다면
			room = ChatRoom.create(gathering_id);
			room.addSession(session, userId);
			map.put(gathering_id, room);
			return room;
		} else {
			room.addSession(session, userId);
			return room;
		}
	}
	
	
	//session이 채널의 마지막 session이었다면 null, 다른 session이 존재한다면 room 반환
	public ChatRoom leaveOrRemoveRoom (WebSocketSession session, int gathering_id) {
		try {
			ChatRoom room = map.get(gathering_id);
			room.removeSession(session);
			if(room.getAllSessions() == null) {
				map.remove(gathering_id);
				return null;
			} else {
				return room;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	//세션이 연결되어 있던 채널을 찾은 후, 해당 채널에 연결된 사용자들에게 연결 종료를 알림
	//그런데 여러 채널에 연결되어 있을수도 있는거 아님?
	public ChatRoom findRoomWithSession(WebSocketSession session) {
		
		ChatRoom room = null;
		for (ChatRoom c : map.values()) {
			if(c.getSessions().containsKey(session))
				return c;
		}
		
		return room;
		
	}


	public void handleMessage(ChatRoom room, WebSocketSession session, ChatMessageDTO chatMessage) {
		//채팅이 왔는데 OPEN타입이라면 세션+아이디 추가

		//근데 우리는 입퇴장 메시지 필요없을듯 함 일단은 추가해보자
		if(chatMessage.getType().equals(ChatMessageDTO.MessageType.OPEN)) {
			room.addSession(session, chatMessage.getUserId());
			chatMessage.setMessage(chatMessage.getUserId() + "님이 입장하셨습니다.");
			chatMessage.setUserId("알림");
		} else if(chatMessage.getType().equals(ChatMessageDTO.MessageType.CLOSE)) {
			room.removeSession(session);
			chatMessage.setMessage(chatMessage.getUserId() + "님이 퇴장하셨습니다.");
			chatMessage.setUserId("알림");
		} 
		
		//dao.insert(chatMessage);
		try {
			room.send(chatMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		
	}
	
	

}
