package com.example.boardinfo.controller.gathering;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import com.example.boardinfo.service.chat.ChatService;
import com.example.boardinfo.service.gathering.GatheringService;
import com.example.boardinfo.service.member.MemberService;
import com.example.boardinfo.util.Pager;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Controller
@RequestMapping("gathering/*")

public class GatheringController {


	@Inject
	GatheringService gatheringService;

	@Inject
	ChatService chatService;

	@Inject
	MemberService memberService;


	private static final Logger logger =
			LoggerFactory.getLogger(GatheringController.class);


	@GetMapping("/add.do")
	public String addForm() {
		return "gathering/addForm";
	}


	@PostMapping("/add.do")
	public String add(@ModelAttribute GatheringDTO dto, HttpSession session) {
		String user_id = (String)session.getAttribute("userid");
		dto.setWriter_id(user_id);

		//에러처리 해야함
		int new_gathering_id = gatheringService.addPost(dto);
		return "redirect:/gathering/view/" + new_gathering_id;
	}


	@RequestMapping("/delete.do")
	public String delete(@RequestParam int gathering_id, HttpSession session,
						 RedirectAttributes redirectAttributes) {
		String user_id = (String)session.getAttribute("userid");
		String message = gatheringService.deletePost(gathering_id, user_id);
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/gathering/list.do";
	}

	@RequestMapping("/locationSearch.do")
	public String locationSearch(){
		return "gathering/setLocation";
	}	
	

	@GetMapping("/list.do")
	public ModelAndView list(HttpServletRequest request, ModelAndView mav,
			@RequestParam(value="from", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate from,
			@RequestParam(value="to", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate to,
			@RequestParam(value="curPage", required=false, defaultValue="1") int curPage,
			@RequestParam(value="address1", required=false) String[] address1List,
			@RequestParam(value="option", required=false) String option,
			@RequestParam(value="keyword", required = false) String keyword) {

		boolean showAvailable = false;

		if(request.getParameter("showAvailable")!=null && request.getParameter("showAvailable").equals("y"))
			showAvailable = true;

		if(option==null) option = "all";

		if(from!=null && to!=null) {
			if(from.isAfter(to)) {
				from=to;
			}
		}
		
		String[] koreanAddress1 = {"서울", "부산", "대구", "인천", "광주", "대전", "울산",
		"경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"
		};


		List<String> koreanAddress1List = Stream.of(koreanAddress1).collect(Collectors.toList());
		int length = koreanAddress1List.size();

		List<GatheringDTO> list = null;

		//선택된 지역이 있다면 리스트에서 빼주기
		if(address1List != null){
			//선택된 지역 삭제
			for(String address1 : address1List){
			koreanAddress1List.remove(address1);
			}
		}

		boolean fold = false;
		if(koreanAddress1List.size() < length) fold = true;

		//선택된 지역이 없다면 빼주지 x
		else {
			String[] all = {"전체"};
			address1List = all;
		}

		int count = gatheringService.countList(showAvailable, address1List, from, to, option, keyword);
		Pager pager = new Pager(count, curPage, 15);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		list = gatheringService.list(showAvailable, address1List, from, to, start, end, option, keyword);
		mav.addObject("address1List", address1List);
		mav.addObject("list", list);
		mav.addObject("showAvailable", showAvailable);
		mav.addObject("koreanAddress1List", koreanAddress1List);
		mav.addObject("from", from);
		mav.addObject("to",to);
		mav.addObject("curPage", curPage);
		mav.addObject("page", pager);
		mav.addObject("option", option);
		mav.addObject("keyword", keyword);
		mav.addObject("fold", fold);
		mav.setViewName("/gathering/list");
		return mav;
	}


	@RequestMapping("view/{gathering_id}")
	public ModelAndView view(@PathVariable int gathering_id, ModelAndView mav,
			@CookieValue(value="gatheringView", required=false) Cookie cookie,
			HttpServletResponse response, HttpSession session,
			@RequestParam(value="from", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate from,
			@RequestParam(value="to", required = false) @DateTimeFormat(pattern="yyyy-MM-dd") LocalDate to,
			@RequestParam(value="curPage", required=false, defaultValue="1") int curPage,
			@RequestParam(value="address1", required=false) String[] address1List,
			 @RequestParam(value="option", required=false) String option,
			 @RequestParam(value="keyword", required = false) String keyword,
							 HttpServletRequest request
			) {

		boolean showAvailable = false;
		if(request.getParameter("showAvailable")!=null) showAvailable = true;
		if(option==null) option = "all";


		String user_id = null;
		if(session!=null) user_id=(String)session.getAttribute("userid");

		boolean updateViewCount = true;

		//다시 풀어놨음~~ 채팅때문에 접속이 빈번한 경우에 대비
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

		GatheringDTO dto = gatheringService.view(gathering_id, updateViewCount);

		if(dto!=null){
			mav.setViewName("/gathering/view");

			AttendeeType type = null;
			if(user_id!=null && !user_id.equals("")){
				type = gatheringService.checkIfAttendee(gathering_id, user_id);
			}
			mav.addObject("dto", dto);
			mav.addObject("type", type);

			mav.addObject("option", option);
			mav.addObject("keyword", keyword);
			mav.addObject("from", from);
			mav.addObject("to", to);
			mav.addObject("curPage", curPage);
			mav.addObject("address1List", address1List);
			mav.addObject("showAvailable", showAvailable);
		}

		else{
			mav.setViewName("redirect:/gathering/list.do");
		}


		return mav;
	}


	//해당회원인지 확인해야 함
	@RequestMapping("edit/{gathering_id}")
	public ModelAndView edit(@PathVariable int gathering_id, ModelAndView mav,
							 HttpSession session, HttpServletRequest request){

		GatheringDTO dto = gatheringService.view(gathering_id, false);


		String user_id = (String)session.getAttribute("userid");
		if(user_id != null && dto.getWriter_id()!=null && user_id.equals(dto.getWriter_id())){
			LocalDateTime post_date = dto.getPost_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			String formattedDateTime = post_date.format(formatter);
			mav.addObject("minDate", formattedDateTime);
			mav.addObject("dto", dto);
			mav.setViewName("gathering/editForm");
			return mav;
		}

		//다시 뒤로 보내주기
		else{
			System.out.println(request.getHeader("Referer"));
			if(request.getHeader("Referer")!=null){
				mav.setViewName("redirect:request.getHeader('Referer')");
				return mav;
			}
			else{
				mav.setViewName("redirect:/gathering/list.do");
				return mav;
			}
		}
	}


	@RequestMapping("/update.do")
	public String edit(@ModelAttribute GatheringDTO dto){
		gatheringService.update(dto);
		return "redirect:/gathering/view/" + dto.getGathering_id();
	}


	@ResponseBody
	@RequestMapping ("/addReply.do")
	public boolean addReply(@ModelAttribute GatheringReplyDTO dto, HttpSession session){
		dto.setCreator_id((String)session.getAttribute("userid"));
		boolean result = gatheringService.addReply(dto);
		return result;
	}


	@ResponseBody
	@RequestMapping ("/getReplies")
	public Map<String, Object> getReplies(@RequestParam int gathering_id){
		List<GatheringReplyDTO> list = gatheringService.getReplies(gathering_id);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		return map;
	}


	@ResponseBody
	@RequestMapping ("/addAttendee")
	public Map<String, String> addAttendee(@RequestParam int gathering_id, HttpSession session,
										   @RequestParam(value="answer", required=false) String answer
										   ){
		String user_id = (String)session.getAttribute("userid");
		String message = gatheringService.addAttendee(gathering_id, user_id, answer);
		Map<String, String> map = new HashMap<>();
		map.put("message", message);
		return map;
	}


	@ResponseBody
	@RequestMapping("/withdraw.do")
	public Map<String, String> withdrawAttendee(@RequestParam int gathering_id, HttpSession session){
		String user_id = (String)session.getAttribute("userid");
		String message = gatheringService.withDrawAttendee(gathering_id, user_id);
		Map<String, String> map = new HashMap<>();
		map.put("message", message);
		return map;
	}


	@ResponseBody
	@RequestMapping("/cancelApplication.do")
	public Map<String, String> cancelApplication(@RequestParam int gathering_id, HttpSession session) {
		String user_id = (String)session.getAttribute("userid");
		String message = gatheringService.cancelApplication(gathering_id, user_id);
		Map<String, String> map = new HashMap<>();
		map.put("message", message);
		return map;
	}



	@GetMapping("/chatRoom.do")
	public ModelAndView ChatRoomMain(@RequestParam (required = false) Integer gathering_id,
									 HttpSession session, ModelAndView mav){

		String user_id = (String) session.getAttribute("userid");

		//채팅방 목록 불러오기
		List<GatheringDTO> rlist = gatheringService.getAttendingChatroomList(user_id, gathering_id);
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


	@ResponseBody
	@GetMapping("/getNickname.do")
	public Map<String, String> getNickname(@RequestParam String user_id) {

		String nickname = memberService.getNickname(user_id);
		Map<String, String> map = new HashMap<>();
		map.put("nickname", nickname);
		return map;
	}


	@ResponseBody
	@GetMapping("/homeList")
	public Map<String, List<GatheringDTO>> getHomeList(
			@RequestParam(value="size", required=false) Integer size){

		if(size == null) size = 8;
		List<GatheringDTO> list = gatheringService.getHomeList(size);
		Map<String, List<GatheringDTO>> map = new HashMap<>();
		map.put("list", list);

		return map;
	}


	@ResponseBody
	@GetMapping("/editReply.do")
	public Map<String, Integer> editReply(@ModelAttribute GatheringReplyDTO dto, HttpSession session){
		//본인이 쓴 댓글이 맞다면 수정할 수 있게 함
		String writer = gatheringService.getReplyWriter(dto.getReply_id());
		String user_id = (String)session.getAttribute("userid");

		int num = 0;
		if(writer.equals(user_id)){
			dto.setUpdater_id(user_id);
			num = gatheringService.updateReply(dto);
		}

		Map<String, Integer> map = new HashMap<>();
		map.put("num", num);
		return map;
	}


	@ResponseBody
	@GetMapping("/deleteReply.do")
	public Map<String, Integer> deleteReply(@RequestParam int reply_id, HttpSession session){
		//본인이 쓴 댓글이 맞다면 삭제할 수 있게 함
		String writer = gatheringService.getReplyWriter(reply_id);
		String user_id = (String)session.getAttribute("userid");

		int num = 0;
		if(writer.equals(user_id)){
			GatheringReplyDTO dto = new GatheringReplyDTO();
			dto.setReply_id(reply_id);
			dto.setUpdater_id(user_id);
			num = gatheringService.deleteReply(dto);
		}

		Map<String, Integer> map = new HashMap<>();
		map.put("num", num);
		return map;
	}




}
