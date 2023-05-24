package com.example.boardinfo.controller.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.boardinfo.model.member.dto.MemberDTO;
import com.example.boardinfo.service.member.MemberService;

@Controller
@RequestMapping("member/*")
public class MemberController {
	
	@Inject
	MemberService memberService;
		
		//회원리스트
		@RequestMapping("member_list.do")
		public String memberList(Model model) {
			List<MemberDTO> list=memberService.list();
			model.addAttribute("list", list);
			return "member/member_list";
		}
		
		//회원등록 창이동
		@RequestMapping("member_join.do")
		public String join() {
			return "member/join";
		}
		
		//회원로그인 창이동
		@RequestMapping("member_login.do")
		public String login() {
			return "member/login";
		}	
		
		//회원입력
		@RequestMapping("member_insert.do")
		public String insertMember(@ModelAttribute MemberDTO dto) {
			memberService.insertMember(dto);
			return "home";
		}
		
		@RequestMapping("login_check.do")
		public ModelAndView login_check(MemberDTO dto, HttpSession session) {
			//로그인 성공 true, 실패 false
			boolean result=memberService.loginCheck(dto, session);
			ModelAndView mav=new ModelAndView();
			if(result) {//로그인 성공
				mav.setViewName("home");
			}else {
				mav.setViewName("member/login");//뷰이름
				mav.addObject("message", "error");//뷰에 전달할 값
			}
			return mav;
		}
		
		@RequestMapping("logout.do")
		public ModelAndView logout(HttpSession session, ModelAndView mav) {
			//세션초기화
			memberService.logout(session);
			//login.jsp로 이동
			mav.setViewName("member/login");
			mav.addObject("message", "logout");
			return mav;
		}
		
		@RequestMapping("check_id.do")
		@ResponseBody
		public String checkId(@RequestParam("userid") String userid) {
			boolean isDuplicate = memberService.checkDuplicateId(userid);
		    	if (isDuplicate) {
		    		return "duplicate";
		    	} else 
		    	{
		    		return "available";
		    	}
		}
		
		
		
	
}
