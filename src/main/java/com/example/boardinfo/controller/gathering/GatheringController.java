package com.example.boardinfo.controller.gathering;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.boardinfo.controller.chat.ChatController;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.service.gathering.GatheringService;

@Controller
@RequestMapping("gathering/*")
public class GatheringController {
	
	@Inject GatheringService gatheringService;
	
	private static final Logger logger = 
			LoggerFactory.getLogger(ChatController.class);
	
	@GetMapping("/add.do")
	public String addForm() {
		return "gathering/addForm";
	}
	
	
	@PostMapping("/add.do")
	public String add(@ModelAttribute GatheringDTO dto) {
		gatheringService.addPost(dto);
		return "redirect:/gathering/add.do";
	}
	
	
	@RequestMapping("locationSearch.do")
	public String locationSearch(){
		return "gathering/setLocation";
	}	

}
