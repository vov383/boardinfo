package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ChatService {

    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc, Date accessDate);
    public Map<String, String> getNicknameMap(int gathering_id);
    public Map<String, Object> getAttendingChatroomList(String user_id, Integer gathering_id);
    public List<Integer> getMyActiveChats(String user_id);
    public boolean checkUnreadMessage(String user_id);
    public void updateActiveChatList(HttpSession session);
    public ChatRoomDTO getAttendingChatroom(String user_id, int gathering_id);
}
