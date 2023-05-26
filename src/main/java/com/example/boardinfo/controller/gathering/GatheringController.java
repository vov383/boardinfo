package com.example.boardinfo.controller.gathering;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import com.example.boardinfo.util.Pager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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


	//로그인필요
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
	public ModelAndView list(HttpServletRequest request, ModelAndView mav,
			@RequestParam(value="from", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate from,
			@RequestParam(value="to", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate to,
			@RequestParam(value="curPage", required=false, defaultValue="1") int curPage,
			@RequestParam(value="address1", required=false) String[] address1List
			) {

		boolean showAvailable = false;

		if(request.getParameter("showAvailable")!=null) showAvailable = true;

		if(from!=null && to!=null) {
			if(from.isAfter(to)) {
				from=to;
			}
		}
		
		String[] koreanAddress1 = {"서울", "부산", "대구", "인천", "광주", "대전", "울산",
		"경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"
		};

		List<String> koreanAddress1List = Stream.of(koreanAddress1).collect(Collectors.toList());
		List<GatheringDTO> list = null;

		//선택된 지역이 있다면 리스트에서 빼주기
		if(address1List != null){
			//선택된 지역 삭제
			for(String address1 : address1List){
			koreanAddress1List.remove(address1);
			}
		}

		//선택된 지역이 없다면 빼주지 x
		else {
			String[] all = {"전체"};
			address1List = all;
		}

		logger.info("address1List : " + address1List.toString());
		int count = gatheringService.countList(showAvailable, address1List, from, to);
		Pager pager = new Pager(count, curPage, 15);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		list = gatheringService.list(showAvailable, address1List, from, to, start, end);
		mav.addObject("address1List", address1List);
		mav.addObject("list", list);
		mav.addObject("showAvailable", showAvailable);
		mav.addObject("koreanAddress1List", koreanAddress1List);
		mav.addObject("from", from);
		mav.addObject("to",to);
		mav.addObject("curPage", curPage);
		mav.addObject("page", pager);
		mav.setViewName("/gathering/list");
		return mav;
	}
	
	@RequestMapping("view/{gathering_id}")
	public ModelAndView view(@PathVariable int gathering_id, ModelAndView mav,
			@CookieValue(value="gatheringView", required=false) Cookie cookie,
			HttpServletResponse response
			) {
		
		boolean updateViewCount = true;

		/* 일단 제외시켜놨음~~~ 커뮤니티 특성상 굳이 조회수 증가를 막을 필요가 있을까 싶음
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

		 */
		
		mav.setViewName("/gathering/view");
		mav.addObject("dto", gatheringService.view(gathering_id, updateViewCount));
		return mav;
	}


	//로그인필요-해당회원인지 확인해야 함
	@RequestMapping("edit/{gathering_id}")
	public ModelAndView edit(@PathVariable int gathering_id, ModelAndView mav){
		mav.setViewName("/gathering/editForm");
		GatheringDTO dto = gatheringService.view(gathering_id, false);
		mav.addObject("dto", dto);
		System.out.println(dto.toString());
		return mav;
	}



	//로그인필요
	@ResponseBody
	@RequestMapping ("/addReply.do")
	public boolean addReply(@ModelAttribute GatheringReplyDTO dto, HttpSession session){
		//dto.setCreator_id((String)session.getAttribute("userid"));
		dto.setCreator_id("kim123");
		boolean result = gatheringService.addReply(dto);

		return result;
	}


	@ResponseBody
	@RequestMapping ("getReplies")
	public Map<String, Object> getReplies(@RequestParam int gathering_id){
		List<GatheringReplyDTO> list = gatheringService.getReplies(gathering_id);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		return map;
	}


}
