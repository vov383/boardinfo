package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;

import java.util.List;
import java.util.Map;

public interface ChatService {

    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc);
    public Map<String, String> getNicknameMap(int gathering_id);
    public List<GatheringDTO> getAttendingChatroomList(String user_id, Integer gathering_id);
    public List<Integer> getMyActiveChats(String user_id);
    public long getMyUnreadCount(String userId, Integer curChat);
}
