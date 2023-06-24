package com.example.boardinfo.model.chat.dao;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ChatMessageDAO {

    public void insert(ChatMessageDTO message);
    public List<ChatMessageDTO> getList(int gathering_id, int curPage, boolean desc);
    public List<ChatMessageDTO> getLastChatMessages(List<Integer> idList);
    public long countMyUnreads(List<ChatRoomDTO> myRooms);

}
