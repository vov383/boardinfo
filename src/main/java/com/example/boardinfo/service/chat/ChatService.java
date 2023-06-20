package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.util.List;
import java.util.Map;

public interface ChatService {

    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc);
    public Map<String, String> getNicknameMap(int gathering_id);
}
