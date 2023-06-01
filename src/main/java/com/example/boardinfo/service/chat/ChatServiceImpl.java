package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class ChatServiceImpl implements ChatService {

    @Inject
    ChatMessageDAO dao;

    @Override
    public List<ChatMessageDTO> chatList(int gathering_id) {
        return dao.getList(gathering_id);
    }
}
