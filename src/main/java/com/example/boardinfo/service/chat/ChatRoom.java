package com.example.boardinfo.service.chat;


import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ChatRoom {

    @Inject
    GatheringDAO gatheringDAO;

    private int gathering_id;

    //세션과 함께 해당 세션 사용자의 아이디를 값으로 넣어줌
    private Map<String, String> sessions = new HashMap<>();

    public static ChatRoom create(int gathering_id)
    {
        ChatRoom chatRoom = new ChatRoom();
        chatRoom.gathering_id = gathering_id;
        return chatRoom;
    }

    public Map<String, String> getSessions() {
        return sessions;
    }

    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public void addUser(String session_id, String user_id) {
        sessions.put(session_id, user_id);
    }


    public void removeUser (String session_id) {
        sessions.remove(session_id);
    }


    public String getUserIdBySession (String session_id){
        return sessions.get(session_id);
    }

    public ArrayList<String> getAllSessions() {
        if(sessions == null || sessions.isEmpty()) {
            return null;
        }
        return new ArrayList<>(sessions.keySet());
    }

    public int getThisUserCount(String user_id) {

        int count = 0;
        for(String id : sessions.values()){
            if(id.equals(user_id)) count++;
        }
        return count;
    }
}
