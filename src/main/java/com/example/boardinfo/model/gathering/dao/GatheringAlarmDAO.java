package com.example.boardinfo.model.gathering.dao;


import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GatheringAlarmDAO {

    @Inject
    SqlSession sqlSession;


    public void addAlarm(GatheringAlarmDTO chatAlarm) {
        sqlSession.insert("gatheringAlarm.addAlarm", chatAlarm);
    }

    public GatheringAlarmDTO isProcessed(String  alarm_id) {
        return sqlSession.selectOne("gatheringAlarm.isProcessed", alarm_id);
    }

    public void processDone(String alarm_id) {
        sqlSession.update("gatheringAlarm.processDone", alarm_id);
    }

    public void noticeGatheringDeleted(GatheringAlarmDTO chatAlarm, List<String> attendeeList) {
        Map<String, Object> map = new HashMap<>();
        map.put("chatAlarm", chatAlarm);
        map.put("attendeeList", attendeeList);
        sqlSession.insert("gatheringAlarm.gatheringDeleted", map);
    }

}
