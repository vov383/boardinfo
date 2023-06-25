package com.example.boardinfo.controller.chat;


import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.service.chat.ChatRoomStore;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import javax.inject.Inject;
import java.text.SimpleDateFormat;
import java.util.HashMap;


@Controller
public class ChatController {
    @Inject
    ChatMessageDAO chatMessageDao;

    @Inject
    ChatRoomStore chatRoomStore;


    private SimpMessagingTemplate messagingTemplate;

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }


    @MessageMapping("/chat/room")
    public void handleRoom(ChatMessageDTO chatMessage, SimpMessageHeaderAccessor accessor){
        System.out.println(chatMessage.toString());
        String session_id = accessor.getSessionId();
        ChatMessageDTO.MessageType type = chatMessage.getType();
        chatMessage.setMessage(session_id);

        if(type.equals(ChatMessageDTO.MessageType.FOCUS)){
            chatRoomStore.joinOrCreateRoom(chatMessage.getGathering_id(), chatMessage.getUserId(), session_id);
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatMessage.getUserId(), chatMessage);
        }

        else if(type.equals(ChatMessageDTO.MessageType.BLUR)){
            chatRoomStore.leaveOrRemoveRoom(session_id);
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatMessage.getUserId(), chatMessage);
        }

    }



    @EventListener
    @MessageMapping("/chat/message")
    public void handleMessage(ChatMessageDTO chatMessage) {
        ChatMessageDTO.MessageType type = chatMessage.getType();

        if(type.equals(ChatMessageDTO.MessageType.ATTEND)) {
            chatMessage.setMessage("[" + chatMessage.getUserId() + "]님이 입장하셨습니다.");
            chatMessage.setUserId("SYSTEM");
        }

        else if(type.equals(ChatMessageDTO.MessageType.LEAVE)) {
            chatMessage.setMessage("[" + chatMessage.getUserId() + "]님이 퇴장하셨습니다.");
            chatMessage.setUserId("SYSTEM");
        }

        else if(type.equals(ChatMessageDTO.MessageType.CLOSE)){
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
