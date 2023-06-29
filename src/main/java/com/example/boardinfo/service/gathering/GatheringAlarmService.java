package com.example.boardinfo.service.gathering;


import com.example.boardinfo.model.gathering.dao.GatheringAlarmDAO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.service.chat.ChatService;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class GatheringAlarmService {

    @Inject
    GatheringAlarmDAO gatheringAlarmDAO;

    @Inject
    GatheringDAO gatheringDAO;

    @Inject
    ChatService chatService;


    public void updateSessionByAlarm(String alarm_id, HttpSession session) {
        if(gatheringAlarmDAO.isProcessed(alarm_id).getProcess().equals("n")){
            chatService.updateActiveChatList(session);
            gatheringAlarmDAO.processDone(alarm_id);
        }
    }


}
