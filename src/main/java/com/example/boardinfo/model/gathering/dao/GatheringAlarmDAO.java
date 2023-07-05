package com.example.boardinfo.model.gathering.dao;


import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.time.LocalDateTime;
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

    public void noticeGatheringDeleted(GatheringAlarmDTO chatAlarm, List<String> attendeeList) {
        Map<String, Object> map = new HashMap<>();
        map.put("chatAlarm", chatAlarm);
        map.put("attendeeList", attendeeList);
        sqlSession.insert("gatheringAlarm.gatheringDeleted", map);
    }

    public int countUrgentAlarms(String user_id, LocalDateTime lastUpdateDate) {
        Map<String, Object> map = new HashMap<>();
        map.put("user_id", user_id);
        map.put("lastUpdateDate", lastUpdateDate);
        return sqlSession.selectOne("gatheringAlarm.countUrgentAlarms", map);
    }

    public int countAlarms(String user_id) {
        return sqlSession.selectOne("gatheringAlarm.countAlarms", user_id);
    }

    public int countTotList(String user_id) {
        return sqlSession.selectOne("gatheringAlarm.countTotList", user_id);
    }


    public List<GatheringAlarmDTO> getAlarmList(String user_id, int start, int end) {
        Map<String, Object> map = new HashMap<>();
        map.put("user_id", user_id);
        map.put("start", start);
        map.put("end", end);
        return sqlSession.selectList("gatheringAlarm.getAlarmList", map);
    }

    public GatheringAlarmDTO getAlarm(int alarm_id) {
        return sqlSession.selectOne("gatheringAlarm.getAlarm", alarm_id);
    }

    public void readSameTypeAlarms(int gathering_id, GatheringAlarmDTO.AlarmType type, String user_id) {
        Map<String, Object> map = new HashMap<>();
        map.put("gathering_id", gathering_id);
        map.put("type", type);
        map.put("user_id", user_id);
        sqlSession.update("gatheringAlarm.readSameTypeAlarms", map);

    }
}
