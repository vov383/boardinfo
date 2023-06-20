package com.example.boardinfo.controller.chat;


import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import javax.inject.Inject;
import java.text.SimpleDateFormat;


@Controller
public class ChatController {
    @Inject
    ChatMessageDAO chatMessageDao;

    private SimpMessagingTemplate messagingTemplate;

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @EventListener
    @MessageMapping("/chat/message")
    public void message(ChatMessageDTO chatMessage){

        if(chatMessage.getType().equals(ChatMessageDTO.MessageType.ATTEND)) {
            chatMessage.setMessage("[" + chatMessage.getUserId() + "]님이 입장하셨습니다.");
            chatMessage.setUserId("SYSTEM");
        }

        else if(chatMessage.getType().equals(ChatMessageDTO.MessageType.LEAVE)) {
            chatMessage.setMessage("[" + chatMessage.getUserId() + "]님이 퇴장하셨습니다.");
            chatMessage.setUserId("SYSTEM");
        }

        else if(chatMessage.getType().equals(ChatMessageDTO.MessageType.CLOSE)){
            chatMessage.setMessage("모임이 종료된 지 3일이 지나 채팅이 종료되었습니다.\n우리 다음에 또 만나요!");
            chatMessage.setUserId("SYSTEM");
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd'T'HH:mm");
        chatMessage.setFormattedDate(dateFormat.format(chatMessage.getInsertDate()));

        messagingTemplate.convertAndSend("/sub/chat/room/" +
                chatMessage.getGathering_id(), chatMessage);
        chatMessageDao.insert(chatMessage);

    }



}
