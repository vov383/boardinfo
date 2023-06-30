package com.example.boardinfo.controller.chat;


import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.service.chat.ChatRoomStore;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import javax.inject.Inject;
import java.text.SimpleDateFormat;
import java.util.UUID;


@Controller
public class ChatMessageController {
    @Inject
    ChatMessageDAO chatMessageDao;

    @Inject
    ChatRoomStore chatRoomStore;


    private SimpMessagingTemplate messagingTemplate;


    public ChatMessageController(SimpMessagingTemplate messagingTemplate,
                                 SimpMessageSendingOperations simpMessageSendingOperations) {
        this.messagingTemplate = messagingTemplate;
    }


    @MessageMapping("/chatting/room")
    public void handleRoom(GatheringAlarmDTO chatAlarm, SimpMessageHeaderAccessor accessor){
        String session_id = accessor.getSessionId();
        GatheringAlarmDTO.AlarmType type = chatAlarm.getType();
        chatAlarm.setMessage(session_id);

        System.out.println(chatAlarm.toString());

        if(type.equals(GatheringAlarmDTO.AlarmType.FOCUS)){
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getUser_id(), chatAlarm);
        }

        else if(type.equals(GatheringAlarmDTO.AlarmType.BLUR)){
            chatRoomStore.leaveOrRemoveRoom(session_id);
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getUser_id(), chatAlarm);
        }

    }


    @EventListener
    public void handleAlarm(GatheringAlarmDTO chatAlarm){
        GatheringAlarmDTO.AlarmType type = chatAlarm.getType();

        /*저장 등 처리하기
         //일단 얜 굳이 저장 안해도 될거같아서 패스

        if(type.equals(GatheringAlarmDTO.AlarmType.ATTEND)){

            chatAlarm.setAlarm_id(gatheringAlarmDAO.addAlarm(chatAlarm));
            chatAlarm.setMessage("모임에 가입되었습니다.");
        }
         */

        if(type.equals(GatheringAlarmDTO.AlarmType.ACCEPTED)){
            chatAlarm.setProcess("N");
            chatAlarm.setAlarm_id(UUID.randomUUID().toString());
            chatAlarm.setMessage("모임에 가입이 승인되었습니다.");

            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getUser_id(), chatAlarm);
        }

        else if(type.equals(GatheringAlarmDTO.AlarmType.DELETED)){
            messagingTemplate.convertAndSend("/sub/chatting/room/" +
                    chatAlarm.getGathering_id(), chatAlarm);
        }

        else if(type.equals(GatheringAlarmDTO.AlarmType.LEAVE)){
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getUser_id(), chatAlarm);
        }

    }



    @EventListener
    @MessageMapping("/chatting/message")
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

        messagingTemplate.convertAndSend("/sub/chatting/room/" +
                chatMessage.getGathering_id(), chatMessage);
        chatMessageDao.insert(chatMessage);

    }



}
