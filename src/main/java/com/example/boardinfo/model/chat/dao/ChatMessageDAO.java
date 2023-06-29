package com.example.boardinfo.model.chat.dao;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;

import java.util.Date;
import java.util.List;

public interface ChatMessageDAO {

    public void insert(ChatMessageDTO message);
    public List<ChatMessageDTO> getList(int gathering_id, int curPage, boolean desc, Date accessDate);
    public List<ChatMessageDTO> getLastChatMessages(List<Integer> idList);
    public boolean hasUnreadMessages(List<ChatRoomDTO> myRooms);
}
