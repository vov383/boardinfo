/*
package com.example.boardinfo.model.gathering.dto;

import org.springframework.web.socket.WebSocketSession;

import java.util.HashMap;
import java.util.Map;

public class ChatChannel {

    private int gathering_id;
    private String title;
    //참가자들의 세션과 함께 닉네임을 저장
    private Map<WebSocketSession, String> sessions = new HashMap<>();

    //채팅방 생성
    public static ChatChannel create(int gathering_id){
        ChatChannel chatChannel = new ChatChannel();
        chatChannel.gathering_id = gathering_id;
        return chatChannel;
    }

    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Map<WebSocketSession, String> getSessions() {
        return sessions;
    }

    public void setSessions(Map<WebSocketSession, String> sessions) {
        this.sessions = sessions;
    }


    public void handleMessage(WebSocketSession session, ChatMessage)




    public void handleMessage(WebSocketSession session, ChatMessage chatMessage) throws Exception{
        if(chatMessage.getType().equals(ChatMessage.MessageType.OPEN)) {
            sessions.put(session, chatMessage.getNickname());
            chatMessage.setMessage("알림: " + chatMessage.getNickname() + "님이 입장하셨습니다.");

        } else if(chatMessage.getType().equals(ChatMessage.MessageType.CLOSE)) {
            sessions.remove(session);
            chatMessage.setMessage("알림: " + chatMessage.getNickname() + "님이 퇴장하셨습니다.");

        }

        send(chatMessage);

    }



}

*/
