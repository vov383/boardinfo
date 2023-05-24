package com.example.boardinfo.controller.gathering;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	
	
	@GetMapping("/list.do")
	public ModelAndView list(ModelAndView mav) {
		List<GatheringDTO> list = gatheringService.list();
		mav.addObject("list", list);
		mav.setViewName("/gathering/list");
		return mav;
	}
	
	@RequestMapping("view/{gathering_id}")
	public ModelAndView view(@PathVariable int gathering_id, ModelAndView mav,
			@CookieValue(value="gatheringView", required=false) Cookie cookie,
			HttpServletResponse response
			) {
		
		boolean updateViewCount = true;
		
		if(cookie!=null) {
			
			String gatheringViewCookie = cookie.getValue();
			
				if(gatheringViewCookie.indexOf("["+gathering_id+"]")!=-1) {
					updateViewCount = false;
				}
				
				else{
					response.addCookie(new Cookie("gatheringView", gatheringViewCookie + "_["+gathering_id+"]"));
				}
			}
			
			else {
				response.addCookie(new Cookie("gatheringView", "["+gathering_id+"]"));
			}
		
		mav.setViewName("/gathering/view");
		mav.addObject("dto", gatheringService.view(gathering_id, updateViewCount));
		return mav;
	}
	

}
