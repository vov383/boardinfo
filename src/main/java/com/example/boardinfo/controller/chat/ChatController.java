package com.example.boardinfo.controller.chat;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.service.chat.ChatService;
import com.example.boardinfo.service.gathering.GatheringService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("chat/*")
public class ChatController {

    @Inject
    GatheringService gatheringService;

    @Inject
    ChatService chatService;

    @GetMapping("/room.do")
    public ModelAndView ChatRoomMain(@RequestParam(required = false) Integer gathering_id,
                                     HttpSession session, ModelAndView mav){

        String user_id = (String) session.getAttribute("userid");

        //채팅방 목록 불러오기
        List<GatheringDTO> rlist = chatService.getAttendingChatroomList(user_id, gathering_id);
        mav.addObject("rlist", rlist);
        mav.addObject("user_id", user_id);
        mav.setViewName("gathering/chatMain");

        Map<String, String> nicknameMap = null;

        if(gathering_id != null) {

            if (gatheringService.checkIfAttendee(gathering_id, user_id) == AttendeeType.ATTENDING) {
                GatheringDTO dto = gatheringService.view(gathering_id, false);
                List<ChatMessageDTO> list = chatService.chatList(gathering_id, 1, false);
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
        return mav;
    }


    @ResponseBody
    @GetMapping("/viewMoreChat.do")
    public Map<String, Object> viewMoreChat(@RequestParam int gathering_id, @RequestParam int curPage) {

        List<ChatMessageDTO> list = chatService.chatList(gathering_id, curPage, true);
        System.out.println("curPage" + curPage);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        return map;
    }


    /*
    @ResponseBody
    @RequestMapping("/getMyActiveChats.do")
    public Map<String, Object> getMyActiveChats(HttpSession session){
        String user_id = (String)session.getAttribute("userid");
        String message = "";
        List<Integer> glist = null;
        Map<String, Object> map = new HashMap<>();

        if(user_id == null){
            //오류 발생시키기
        }

        else{
            glist = gatheringService.getMyActiveChats(user_id);
        }

        map.put("glist", glist);
        return map;
    }

     */


    @ResponseBody
    @GetMapping("/unreadCount.do")
    public Map<String, Long> getActiveUnreadCount(HttpSession session) {

        String user_id = (String) session.getAttribute("userid");
        Integer curChat = (Integer) session.getAttribute("curChat");
        long count = chatService.getMyUnreadCount(user_id, curChat);
        Map<String, Long> map = new HashMap<>();
        map.put("chatCount", count);
        return map;
    }



}
