package com.example.boardinfo.model.chat.dao;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.util.List;

public interface ChatMessageDAO {

    public void insert(ChatMessageDTO message);
    public List<ChatMessageDTO> getList(int gathering_id, int curPage, boolean desc);


}
