package com.example.boardinfo.controller.chat;


import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.gathering.dao.GatheringAlarmDAO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.service.chat.ChatRoomStore;
import com.example.boardinfo.service.chat.ChatService;
import com.example.boardinfo.service.chat.ChatServiceImpl;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.broker.SubscriptionRegistry;
import org.springframework.stereotype.Controller;

import javax.inject.Inject;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.UUID;


@Controller
public class ChatMessageController {
    @Inject
    ChatMessageDAO chatMessageDao;

    @Inject
    GatheringDAO gatheringDAO;

    @Inject
    GatheringAlarmDAO gatheringAlarmDAO;

    @Inject
    MemberDAO memberDAO;






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

        if(type.equals(GatheringAlarmDTO.AlarmType.FOCUS)){
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getReceiver_id(), chatAlarm);
            /*gatheringDAO.updateLastVisit(chatAlarm.getGathering_id(), chatAlarm.getReceiver_id(), LocalDateTime.of(2200, 12, 30, 0, 0));*/
        }

        else if(type.equals(GatheringAlarmDTO.AlarmType.BLUR)){
            gatheringDAO.updateLastVisit(chatAlarm.getGathering_id(), chatAlarm.getReceiver_id(), LocalDateTime.now());
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    chatAlarm.getReceiver_id(), chatAlarm);
        }

    }


    @EventListener
    public void handleAlarm(GatheringAlarmDTO gatheringAlarm){
        GatheringAlarmDTO.AlarmType type = gatheringAlarm.getType();

        //알람 저장
        if(type.equals(GatheringAlarmDTO.AlarmType.ACCEPTED) ||
                type.equals(GatheringAlarmDTO.AlarmType.THROWN) ||
                type.equals(GatheringAlarmDTO.AlarmType.APPLY) ||
                type.equals(GatheringAlarmDTO.AlarmType.REJECTED)
        ){
            gatheringAlarmDAO.addAlarm(gatheringAlarm);
        }

        //보내주기
        if(type.equals(GatheringAlarmDTO.AlarmType.DELETED)){
            messagingTemplate.convertAndSend("/sub/chatting/room/" +
                    gatheringAlarm.getGathering_id(), gatheringAlarm);
        }
        else{
            messagingTemplate.convertAndSend("/sub/alarm/user/" +
                    gatheringAlarm.getReceiver_id(), gatheringAlarm);
        }
    }



    @EventListener
    @MessageMapping("/chatting/message")
    public void handleMessage(ChatMessageDTO chatMessage) {
        ChatMessageDTO.MessageType type = chatMessage.getType();

        if(chatMessage.getNickname() == null){
            String nickname = memberDAO.getNickname(chatMessage.getUserId());
            chatMessage.setNickname(nickname);
        }

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

        else if(type.equals(ChatMessageDTO.MessageType.THROW)){
            chatMessage.setMessage("[" + chatMessage.getUserId() + "]님이 모임에서 방출되었습니다.");
            chatMessage.setUserId("SYSTEM");
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd'T'HH:mm");
        chatMessage.setFormattedDate(dateFormat.format(chatMessage.getInsertDate()));

        messagingTemplate.convertAndSend("/sub/chatting/room/" +
                chatMessage.getGathering_id(), chatMessage);
        chatMessageDao.insert(chatMessage);

    }



}
