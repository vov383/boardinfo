package com.example.boardinfo.controller.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.service.chat.ChatService;
import com.example.boardinfo.service.gathering.GatheringAlarmService;
import com.example.boardinfo.service.gathering.GatheringService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("chat/*")
public class ChatController {

    @Inject
    GatheringService gatheringService;

    @Inject
    GatheringAlarmService gatheringAlarmService;

    @Inject
    ChatService chatService;


    @GetMapping("/room.do")
    public ModelAndView ChatRoomMain(@RequestParam(required = false) Integer gathering_id,
                                     HttpSession session, ModelAndView mav){

        String user_id = (String) session.getAttribute("userid");

        //채팅방 목록 불러오기
        Map<String, Object> map = chatService.getAttendingChatroomList(user_id, gathering_id);
        mav.addObject("rlist", map.get("rlist"));
        mav.addObject("unread", map.get("unread"));
        mav.setViewName("gathering/chatMain");

        Map<String, String> nicknameMap = null;
        Date accessDate = new Date();

        if(gathering_id != null) {

            if (gatheringService.checkIfAttendee(gathering_id, user_id) == AttendeeType.ATTENDING) {
                GatheringDTO dto = gatheringService.simpleView(gathering_id);
                List<AttendeeDTO> attendeeDTOList = gatheringService.getAttendeeList(gathering_id);
                dto.setAttendeeDTOList(attendeeDTOList);
                dto.setAttendee_count(attendeeDTOList.size());

                List<ChatMessageDTO> list = chatService.chatList(gathering_id, 1, false, accessDate);

                nicknameMap = chatService.getNicknameMap(gathering_id);

                for (ChatMessageDTO item : list) {
                    if (item.getUserId().equals("SYSTEM")) {
                        String message = item.getMessage();
                        int index = message.indexOf("]");
                        if (index != -1) {
                            String user = message.substring(1, index);
                            item.setMessage(nicknameMap.get(user) + message.substring(index + 1));
                        }
                    }
                    item.setNickname(nicknameMap.get(item.getUserId()));
                }

                mav.addObject("gathering_id", gathering_id);
                mav.addObject("dto", dto);
                mav.addObject("list", list);
            } else {
                //멤버가 아니라면
                mav.addObject("message", "모임의 멤버만 채팅 내용을 볼 수 있습니다.");
            }
        }

        Gson gson = new Gson();
        mav.addObject("nicknameMap", gson.toJson(nicknameMap));

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = dateFormat.format(accessDate);
        mav.addObject("accessDate", dateString);
        return mav;
    }



    @ResponseBody
    @GetMapping("/viewMoreChat.do")
    public Map<String, Object> viewMoreChat(@RequestParam int gathering_id,
                                            @RequestParam int curPage, @RequestParam String dateString) {

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date accessDate = new Date();
        try{
            accessDate = dateFormat.parse(dateString);
        } catch (Exception e){
            e.printStackTrace();
        }
        List<ChatMessageDTO> list = chatService.chatList(gathering_id, curPage, true, accessDate);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        return map;
    }


    @ResponseBody
    @GetMapping("/unreadCount.do")
    public Map<String, Boolean> getActiveUnreadCount(HttpSession session) {

        String user_id = (String) session.getAttribute("userid");
        boolean unread = chatService.checkUnreadMessage(user_id);
        Map<String, Boolean> map = new HashMap<>();
        map.put("unread", unread);
        return map;
    }

    @ResponseBody
    @GetMapping("/updateByAlarm.do")
    public void updateByAlarm(HttpSession session) {
        gatheringAlarmService.updateSessionByAlarm((String) session.getAttribute("userid"), session);
    }


    @ResponseBody
    @GetMapping("/getNewRoom.do")
    public ChatRoomDTO getNewRoom(HttpSession session, @RequestParam int gathering_id) {
        String user_id = (String) session.getAttribute("userid");
        ChatRoomDTO dto = chatService.getAttendingChatroom(user_id, gathering_id);
        return dto;
    }




}
