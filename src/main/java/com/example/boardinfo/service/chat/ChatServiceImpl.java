package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ChatServiceImpl implements ChatService {

    @Inject
    ChatMessageDAO chatMessageDAO;

    @Inject
    GatheringDAO gatheringDAO;

    @Inject
    MemberDAO memberDAO;

    @Override
    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc) {
        List<ChatMessageDTO> list = chatMessageDAO.getList(gathering_id, curPage, desc);
        return list;
    }

    @Override
    public Map<String, String> getNicknameMap(int gathering_id) {
        List<Map<String, String>> list = gatheringDAO.getIdAndNicknames(gathering_id);
        Map<String, String> nicknameMap = new HashMap<>();

        for(Map<String, String> item : list){
            nicknameMap.put(item.get("USER_ID"), item.get("NICKNAME"));
        }

        return nicknameMap;
    }

    @Override
    public List<GatheringDTO> getAttendingChatroomList(String user_id, Integer gathering_id) {
        List<GatheringDTO> gatheringList = gatheringDAO.getAttendingGatheringList(user_id);

        List<Integer> idList = new ArrayList<>();
        List<GatheringDTO> resultList = new ArrayList<>();

        for(GatheringDTO item : gatheringList) {
            idList.add(item.getGathering_id());
        }

        List<ChatMessageDTO> lastMessages = chatMessageDAO.getLastChatMessages(idList);

        for(ChatMessageDTO item : lastMessages){

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
            item.setFormattedDate(dateFormat.format(item.getInsertDate()));

            if(item.getUserId().equals("SYSTEM")){
                String message = item.getMessage();
                int index = message.indexOf("]");
                if(index!=-1){
                    String user = message.substring(1, index);
                    item.setMessage(memberDAO.getNickname(user) + message.substring(index+1));
                }
            }

            Optional<GatheringDTO> dto = gatheringList.stream()
                    .filter(g -> g.getGathering_id() == item.getGathering_id())
                    .findFirst();

            if(dto.isPresent()){
                GatheringDTO g = dto.get();
                g.setLastChat(item);

                resultList.add(g);
            }

        }
        return resultList;
    }

    @Override
    public List<Integer> getMyActiveChats(String user_id) {
        return gatheringDAO.getMyActiveChats(user_id);
    }


    @Override
    public long getMyUnreadCount(String user_id, Integer curChat) {
        List<ChatRoomDTO> myChats = gatheringDAO.getMyLastVisit(user_id, curChat);
        return chatMessageDAO.countMyUnreads(myChats);
    }


}


