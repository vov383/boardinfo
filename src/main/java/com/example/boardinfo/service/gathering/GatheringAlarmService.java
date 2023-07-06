package com.example.boardinfo.service.gathering;


import com.example.boardinfo.model.gathering.dao.GatheringAlarmDAO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import com.example.boardinfo.service.chat.ChatService;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class GatheringAlarmService {

    @Inject
    GatheringAlarmDAO gatheringAlarmDAO;

    @Inject
    GatheringDAO gatheringDAO;

    @Inject
    ChatService chatService;


    public void updateSessionByAlarm(String user_id, HttpSession session) {
        LocalDateTime lastUpdateDate = (LocalDateTime)session.getAttribute("lastUpdateDate");
        System.out.println("lastUpdateDate : " + lastUpdateDate);
        System.out.println(gatheringAlarmDAO.countUrgentAlarms(user_id, lastUpdateDate) + "개의 알림");
        if(gatheringAlarmDAO.countUrgentAlarms(user_id, lastUpdateDate)>0){
            chatService.updateActiveChatList(session);
        }
    }

    public boolean checkUnreadAlarm(String user_id) {
        if(gatheringAlarmDAO.countAlarms(user_id)>0){
            return true;
        }

        else return false;
    }

    public int countTotList(String user_id) {
        return gatheringAlarmDAO.countTotList(user_id);
    }

    public List<GatheringAlarmDTO> getAlarmList(String user_id, int start, int end, HttpServletRequest request) {
        List<GatheringAlarmDTO> list = gatheringAlarmDAO.getAlarmList(user_id, start, end);

        for(GatheringAlarmDTO item : list){
            if(item.getType().equals(GatheringAlarmDTO.AlarmType.ACCEPTED)){
                item.setMessage("님의 " + item.getPost_title() + " 모임에 가입 승인되었습니다.");
                item.setUrl(request.getContextPath() + "/gathering/view/" + item.getGathering_id());
            }
            else if(item.getType().equals(GatheringAlarmDTO.AlarmType.DELETED)){
                item.setMessage("님이 " + item.getPost_title() + " 모임을 삭제하였습니다.");
                item.setUrl(request.getContextPath() + "/gathering/list.do");
            }
            else if(item.getType().equals(GatheringAlarmDTO.AlarmType.APPLY)){
                item.setMessage("님이 " + item.getPost_title() + " 모임에 가입 신청하였습니다.");
                item.setUrl(request.getContextPath() + "/gathering/view/" + item.getGathering_id());
            }
            else if(item.getType().equals(GatheringAlarmDTO.AlarmType.THROWN)){
                item.setMessage("님의 " + item.getPost_title() + " 모임에서 탈퇴되었습니다.");
                item.setUrl(request.getContextPath() + "/gathering/view/" + item.getGathering_id());
            }

            else if(item.getType().equals(GatheringAlarmDTO.AlarmType.REJECTED)){
                item.setMessage("님의 " + item.getPost_title() + " 모임에 대한 가입신청이 거절되었습니다.");
                item.setUrl(request.getContextPath() + "/gathering/view/" + item.getGathering_id());
            }

        }

        return list;


    }
    public void read(int alarm_id, String user_id) {
        GatheringAlarmDTO alarm = gatheringAlarmDAO.getAlarm(alarm_id);
        GatheringAlarmDTO.AlarmType type = alarm.getType();
        int gathering_id = alarm.getGathering_id();
        gatheringAlarmDAO.readSameTypeAlarms(gathering_id, type, user_id);


    }
}
