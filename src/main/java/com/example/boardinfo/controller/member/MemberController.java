package com.example.boardinfo.controller.member;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;
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
		@Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
		String uploadPath;
		@RequestMapping("member_insert.do")
		public String insertMember(@ModelAttribute MemberDTO dto, HttpServletResponse response,

		                     @RequestParam MultipartFile profile_img) {
		      OutputStream out = null;
		      response.setCharacterEncoding("utf-8");
		      response.setContentType("text/html; charset=utf-8");
	
		      try {
		         //업로드한 파일 이름
		         String fileName=profile_img.getOriginalFilename();
		         //파일을 바이트 배열로 변환
		         byte[] bytes=profile_img.getBytes();
		         out = new FileOutputStream(new File(uploadPath+"/"+fileName));
		         //서버로 업로드
		         out.write(bytes);
	
		         dto.setProfile(fileName);
	
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         try {
		            if(out != null) {
		               out.close();
		            }
		         } catch (Exception e2) {
		            e2.printStackTrace();
		         }
		      }
		   memberService.insertMember(dto);
		   return "home";

		}
		
		@RequestMapping("login_check.do")
		public ModelAndView login_check(MemberDTO dto, HttpSession session) {
		    //로그인 성공 true, 실패 false
		    boolean result = memberService.loginCheck(dto, session);
		    boolean getDelValue = memberService.getDelValue(dto.getUserid()); // 회원 탈퇴 여부 확인
		    ModelAndView mav = new ModelAndView();
		    if (result) { //로그인 성공
		        mav.setViewName("home");
		    } else {
		    		mav.setViewName("member/login");//뷰이름
		        if (getDelValue) {
		            mav.addObject("message", "del"); // 탈퇴한 회원 메시지
		        } else {
		            mav.addObject("message", "error"); // 로그인 실패 메시지
		           
		        }
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
		    		return "duplicate"; //중복o
		    	} else 
		    	{
		    		return "available"; //중복x
		    	}
		}
		//닉네임 중복확인 
		@RequestMapping("check_nick.do")
		@ResponseBody
		public String check_nick(@RequestParam String nickname) {
			boolean isDuplicate = memberService.checkDuplicateNick(nickname);
		    	if (isDuplicate) {
		    		return "duplicate"; //중복o
		    	} else 
		    	{
		    		return "available"; //중복x
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
		
		//회원 상세정보 수정		
		@RequestMapping("update.do")
		public String update(MemberDTO dto, HttpServletRequest request,HttpServletResponse response,
                @RequestParam MultipartFile profile_img) {
			OutputStream out = null;
		      response.setCharacterEncoding("utf-8");
		      response.setContentType("text/html; charset=utf-8");
	
		      try {
		         //업로드한 파일 이름
		         String fileName=profile_img.getOriginalFilename();
		         //파일을 바이트 배열로 변환
		         byte[] bytes=profile_img.getBytes();
		         out = new FileOutputStream(new File(uploadPath+"/"+fileName));
		         //서버로 업로드
		         out.write(bytes);
	
		         dto.setProfile(fileName);
	
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         try {
		            if(out != null) {
		               out.close();
		            }
		         } catch (Exception e2) {
		            e2.printStackTrace();
		         }
		      }
				memberService.updateMember(dto);
				HttpSession session = request.getSession();
				session.setAttribute("name",dto.getName());
				return "home";
		}
		
		//회원 삭제 (del='n'  ->  del='y')로 변경 후 보이지 않게 처리
		@RequestMapping("delete.do")
		public String delete(@RequestParam("userid") String userid,HttpSession session ) {
				memberService.deleteMember(userid, session);
				
				return "home";
		}
		
		
		
	
}
