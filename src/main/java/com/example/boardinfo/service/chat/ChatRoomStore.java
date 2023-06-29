package com.example.boardinfo.service.chat;


import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;

@Component
public class ChatRoomStore {

    @Inject
    GatheringDAO gatheringDAO;


        //gathering_id를 key로 갖는 ChatRoom map
        private Map<Integer, ChatRoom> map;

        @PostConstruct
        private void init() {
            map = new LinkedHashMap<Integer, ChatRoom>();
        }

        public ChatRoom getChannelByGatheringId(Integer gathering_id) {
            ChatRoom room = map.get(gathering_id);
            return room;
        }

        //해당 gathering_id의 채팅방이 존재하면 참가하고, 없으면 생성한 후 참가
        public ChatRoom joinOrCreateRoom (int gathering_id, String user_id, String session_id) {
            ChatRoom room = null;
            room = map.get(gathering_id);
            if(room == null) { //해당 채팅방이 없다면
                room = ChatRoom.create(gathering_id);
                room.addUser(session_id, user_id);
                map.put(gathering_id, room);
            } else {
                room.addUser(session_id, user_id);
            }
            return room;
        }


        //session이 채널의 마지막 session이었다면 null, 다른 session이 존재한다면 room 반환
        public GatheringAlarmDTO leaveOrRemoveRoom (String session_id) {
            GatheringAlarmDTO result = new GatheringAlarmDTO();

            try {
                ChatRoom room = findRoomWithSession(session_id);
                if(room!=null) {
                    Integer gathering_id = room.getGathering_id();

                    String user_id = room.getUserIdBySession(session_id);
                    room.removeUser(session_id);

                    gatheringDAO.updateLastVisit(gathering_id, user_id, LocalDateTime.now());


                    if(room.getAllSessions() == null) {
                        map.remove(gathering_id);
                    }

                    result.setType(GatheringAlarmDTO.AlarmType.BLUR);
                    result.setGathering_id(gathering_id);
                    result.setUser_id(user_id);
                    return result;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }


    //회원이 연결되어 있던 채널을 찾음
        public ChatRoom findRoomWithSession(String session_id) {
            ChatRoom room = null;
            for (ChatRoom c : map.values()) {
                if(c.getSessions().containsKey(session_id))
                    return c;
            }

            return room;
        }



}
