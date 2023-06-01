package com.example.boardinfo.controller.chat;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.service.chat.ChatService;
import com.example.boardinfo.service.gathering.GatheringService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("chatRoom/*")
public class ChatRoomController {

	@Inject
	GatheringService gatheringService;

	@Inject
	ChatService chatService;

	private static final Logger logger = 
			LoggerFactory.getLogger(ChatRoomController.class);
	
	@GetMapping("/enter.do")
	public String chat(Model model, HttpSession session,
					   @RequestParam int gathering_id) {

		String user_id = (String) session.getAttribute("userid");

		if (gatheringService.checkIfAttendee(gathering_id, user_id) == AttendeeType.ATTENDING) {
			List<ChatMessageDTO> list = chatService.chatList(gathering_id);

			//로그인 아이디를 model에 담아 뷰로 보냄
			model.addAttribute("gathering_id", gathering_id);
			model.addAttribute("user_id", user_id);
			model.addAttribute("list", list);
			return "gathering/chat";
		} else {

			//멤버가 아니라면 어떡하지?
			return "/";
		}

	}

}
