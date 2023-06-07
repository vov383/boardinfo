package com.example.boardinfo.controller.chat;


import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;


@Controller
public class ChatController {
    private SimpMessagingTemplate messagingTemplate;

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/chat/message")
    public void message(ChatMessageDTO chatMessage){
        System.out.println("들어옴");
        System.out.println(chatMessage.getGathering_id() + "로 보내줍니다");


        if(chatMessage.getType().equals(ChatMessageDTO.MessageType.ATTEND)) {
            chatMessage.setMessage(chatMessage.getUserId() + "님이 입장하셨습니다.");
            chatMessage.setUserId("System");
        }

        else if(chatMessage.getType().equals(ChatMessageDTO.MessageType.LEAVE)) {
            chatMessage.setMessage(chatMessage.getUserId() + "님이 퇴장하셨습니다.");
            chatMessage.setUserId("System");
        }

        System.out.println(chatMessage.getGathering_id() + "로 보내줍니다");

        //여기서 채팅내용 저장하고 보내주기
        messagingTemplate.convertAndSend("/sub/chat/room/" +
                chatMessage.getGathering_id(), chatMessage);
    }



}
