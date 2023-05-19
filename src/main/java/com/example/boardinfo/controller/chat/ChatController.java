package com.example.boardinfo.controller.chat;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("chat/*")
public class ChatController {
	
	private static final Logger logger = 
			LoggerFactory.getLogger(ChatController.class);
	
	@GetMapping("/goChat.do")
	public String chat(Model model, HttpSession session, @RequestParam String user_id) {
		
		/*세션으로부터 userDTO를 구한 다음
			UserDTO user = (UserDTO) SecurityContextHolder.
			getContext().getAuthentication().getPrincipal();
		*/
		
		//일단 다 생략하고 id 1234로 통일

		logger.info("======================================");
		logger.info("@ChatController, GET Chat / Username : 1234");
		
		//로그인 아이디를 model에 담아 뷰로 보냄
		//model.addAttribute("userid", user.getUsername());
		model.addAttribute("user_id", user_id);
		//임시방편으로 세션에 아이디 저장
		session.setAttribute("user_id", user_id);
		
		
		return "gathering/chat";
		
	}

}
