package com.example.boardinfo.scheduler;


import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.inject.Inject;
import java.util.List;

@Component
public class GatheringScheduler {

    @Inject
    GatheringDAO gatheringDAO;

    @Autowired
    ApplicationEventPublisher eventPublisher;


    @Scheduled(cron = "0 0 0 * * *")
    public void autoUpdate() throws Exception {

        List<Integer> finishChatList = gatheringDAO.finishList();
        gatheringDAO.finishChat();

        for(Integer item : finishChatList){
            //채팅 종료 알림
            ChatMessageDTO notice = new ChatMessageDTO();
            notice.setGathering_id(item);
            notice.setUserId("SYSTEM");
            notice.setMessage("모임이 종료된지 3일이 지나 채팅이 종료되었습니다.\n우리 다음에 또 만나요!");
            notice.setType(ChatMessageDTO.MessageType.CLOSE);
            eventPublisher.publishEvent(notice);
        }


    }

}
