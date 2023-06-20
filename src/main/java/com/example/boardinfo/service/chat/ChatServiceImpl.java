package com.example.boardinfo.service.chat;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChatServiceImpl implements ChatService {

    @Inject
    ChatMessageDAO dao;

    @Inject
    GatheringDAO gdao;

    @Override
    public List<ChatMessageDTO> chatList(int gathering_id, int curPage, boolean desc) {
        List<ChatMessageDTO> list = dao.getList(gathering_id, curPage, desc);
        return list;
    }

    @Override
    public Map<String, String> getNicknameMap(int gathering_id) {
        List<Map<String, String>> list = gdao.getIdAndNicknames(gathering_id);
        Map<String, String> nicknameMap = new HashMap<>();

        for(Map<String, String> item : list){
            nicknameMap.put(item.get("USER_ID"), item.get("NICKNAME"));
        }

        return nicknameMap;
    }
}
