package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.util.List;

public interface ChatService {

    List<ChatMessageDTO> chatList(int gathering_id);

}
