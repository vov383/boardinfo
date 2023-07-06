package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
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
    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc, Date accessDate) {
        List<ChatMessageDTO> list = chatMessageDAO.getList(gathering_id, curPage, desc, accessDate);
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
    public Map<String, Object> getAttendingChatroomList(String user_id, Integer gathering_id) {

        List<ChatRoomDTO> chatRoomList = gatheringDAO.getAttendingGatheringList(user_id);

        List<Integer> idList = new ArrayList<>();
        List<ChatRoomDTO> resultList = new ArrayList<>();

        boolean unread = false;

        for(ChatRoomDTO item : chatRoomList) {
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

            Optional<ChatRoomDTO> dto = chatRoomList.stream()
                    .filter(g -> g.getGathering_id() == item.getGathering_id())
                    .findFirst();

            if(dto.isPresent()){
                ChatRoomDTO r = dto.get();
                r.setLastChat(item);
                resultList.add(r);

                //finishChat인 경우 재처리
                if(r.getFinishChat().equals("N")){
                    if(r.getLast_visit().before(item.getInsertDate())) {
                        if(gathering_id==null || r.getGathering_id()!=gathering_id){
                            r.setUnread(true);
                            unread = true;
                        }
                    }
                }

            }

        }

        Map<String, Object> map = new HashMap<>();
        map.put("unread", unread);
        map.put("rlist", resultList);
        return map;
    }


    /*
    @Override
    public long countMyUnreads(List<ChatRoomDTO> myRooms) {
        long unread = 0L;

        for (ChatRoomDTO room : myRooms) {
            Query query = new Query()
                    .addCriteria(Criteria.where("gathering_id").is(room.getGathering_id())
                            .*and("timestamp").gt(room.getLast_visit()));
            long unreadCount = mongoTemplate.count(query, ChatMessageDTO.class);
            unread += unreadCount;
        }

        return unread;
    }
    */


    @Override
    public ChatRoomDTO getAttendingChatroom(String user_id, int gathering_id) {
        ChatRoomDTO dto = gatheringDAO.getAttendingChatroom(user_id, gathering_id);

        if(dto!=null) {
            ChatMessageDTO lastMessage = chatMessageDAO.getLastChatMessages(gathering_id);

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
            lastMessage.setFormattedDate(dateFormat.format(lastMessage.getInsertDate()));
            if(lastMessage.getUserId().equals("SYSTEM")){
                String message = lastMessage.getMessage();
                int index = message.indexOf("]");
                if(index!=-1){
                    String user = message.substring(1, index);
                    lastMessage.setMessage(memberDAO.getNickname(user) + message.substring(index+1));
                }
            }

            dto.setLastChat(lastMessage);
            if(dto.getLast_visit().before(lastMessage.getInsertDate())) {
                dto.setUnread(true);
            }
        }

            return dto;
  }

    @Override
    public List<Integer> getMyActiveChats(String user_id) {
        return gatheringDAO.getMyActiveChats(user_id);
    }


    @Override
    public boolean checkUnreadMessage(String user_id) {
        List<ChatRoomDTO> myChats = gatheringDAO.getMyLastVisit(user_id);
        return chatMessageDAO.hasUnreadMessages(myChats);
    }

    @Override
    public void updateActiveChatList(HttpSession session){
        List<Integer> activeChats = gatheringDAO.getMyActiveChats((String)session.getAttribute("userid"));
        Gson gson = new Gson();
        session.setAttribute("activeChats", gson.toJson(activeChats));

        LocalDateTime now = LocalDateTime.now();
        session.setAttribute("lastUpdateDate", now);

    }


}


