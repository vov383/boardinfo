package com.example.boardinfo.controller.member;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
		public String logout(HttpSession session) {
			//세션초기화
			memberService.logout(session);
			return "redirect:/?=message=logout";
		}
		
		//아이디 중복확인 
		@RequestMapping("check_id.do")
		@ResponseBody
		public String checkId(@RequestParam String userid) {
			boolean isDuplicate = memberService.checkDuplicateId(userid);
		    	if (isDuplicate) {
		    		return "duplicate";
		    	} else 
		    	{
		    		return "available";
		    	}
		}
		//닉네임 중복확인 
		@RequestMapping("check_nick.do")
		@ResponseBody
		public String check_nick(@RequestParam String nickname) {
			boolean isDuplicate = memberService.checkDuplicateNick(nickname);
		    	if (isDuplicate) {
		    		return "duplicate";
		    	} else 
		    	{
		    		return "available";
		    	}
		}
		//회원 상세정보 
		@RequestMapping("member_view.do")
		public String view(@RequestParam String userid, Model model) {
			//모델에 자료 저장
			model.addAttribute("dto", memberService.viewMember(userid));
			return "member/view";
		}
		//회원 상세정보 페이지 비밀번호 체크
		@RequestMapping("pass_check.do")
		public String checkPw(MemberDTO dto, Model model) {
			//비밀번호 체크
			boolean result=memberService.checkPw(dto.getUserid(), dto.getPasswd());
			if(result) {//비번이 맞으면
				model.addAttribute("dto", memberService.viewMember(dto.getUserid()));
				return "member/edit";
			}else {//비번이 틀리면
				model.addAttribute("dto", dto);
				model.addAttribute("message", "비밀번호를 확인하세요.");
				return "member/view";
			}
		}
		
		
		
	
}
