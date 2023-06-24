package com.example.boardinfo.controller.member;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;


import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.service.chat.ChatService;
import com.google.gson.Gson;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.boardinfo.model.member.dto.MemberDTO;
import com.example.boardinfo.service.member.MemberService;

@Controller
@RequestMapping("member/*")
public class MemberController {

	@Inject
	MemberService memberService;

	@Inject
	ChatService chatService;

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

	//회원아이디찾기 창이동
	@RequestMapping("findidmove.do")
	public String findidmove() {
		return "member/findid";
	}

	// 아이디 찾기
	@RequestMapping("userSearch")
	@ResponseBody
	public String userIdSearch(@RequestParam("name") String name, @RequestParam("hp") String hp){
		String result = memberService.get_searchId(name, hp);
		return result;
	}

	//회원비밀번호찾기 창이동
	@RequestMapping("findpwmove.do")
	public String findpwmove() {
		return "member/findpw";
	}
	
	//비밀번호 찾기(id , email 체크)
	@RequestMapping("findPwCheck")
	@ResponseBody
	public String findPwCheck(@RequestParam("userid") String userid, @RequestParam("email") String email){
		String result = memberService.get_PwCheck(userid, email);
		return result;
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
	public ModelAndView login_check(MemberDTO dto, HttpSession session, boolean rememberId) {
		//로그인 성공 true, 실패 false
		boolean result = memberService.loginCheck(dto, session);
		boolean getDelValue = memberService.getDelValue(dto.getUserid()); // 회원 탈퇴 여부 확인

		ModelAndView mav = new ModelAndView();
		if (result) { //로그인 성공

			//활성화된 채팅정보 저장
			List<Integer> activeChats = chatService.getMyActiveChats(dto.getUserid());
			Gson gson = new Gson();
			session.setAttribute("activeChats", gson.toJson(activeChats));

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
	
	
	//비밀번호 찾기(이메일 전송)
	@Resource(name = "mailSender") 
	JavaMailSender mailSender;
	@RequestMapping("find_pass.do")
	 public ModelAndView find_pass(HttpServletRequest request, String userid, String email,
             HttpServletResponse response_email) throws IOException{
         
         //랜덤한 난수 (인증번호)를 생성해서 이메일로 보내고 그 인증번호를 입력하면 비밀번호를 변경할 수 있는 페이지로 이동시킴
         
         Random r = new Random();
         int dice = r.nextInt(157211)+48271;
         
         String setfrom = "xod13579@gmail.com";
         String tomail = request.getParameter("email");    //받는 사람의 이메일
         String title = "비밀번호 찾기 인증 이메일 입니다.";    //제목
         String content =
         
                 System.getProperty("line.separator")+
                 
                 System.getProperty("line.separator")+
                         
                 "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
                 
                 +System.getProperty("line.separator")+
                 
                 System.getProperty("line.separator")+
         
                 "비밀번호 찾기 인증번호는 " +dice+ " 입니다. "
                 
                 +System.getProperty("line.separator")+
                 
                 System.getProperty("line.separator")+
                 
                 "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
         
         try {

             
			MimeMessage message =  mailSender.createMimeMessage();
             MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

             messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
             messageHelper.setTo(tomail); // 받는사람 이메일
             messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
             messageHelper.setText(content); // 메일 내용
             
            mailSender.send(message);
     
         } catch (Exception e) {
             System.out.println(e);
         }
         
         
         ModelAndView mv = new ModelAndView();    //ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
         mv.setViewName("/member/pass_email");     //뷰의이름
         mv.addObject("dice", dice);
         mv.addObject("email", email);
         
         System.out.println("mv : "+mv);

         response_email.setContentType("text/html; charset=UTF-8");
         PrintWriter out_email = response_email.getWriter();
         out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
         out_email.flush();
         
         
         return mv;
         
     }
	//인증번호 페이지넘김
	@RequestMapping("pass_num/{dice}/{email:.+}")
    public ModelAndView pass_num(String pass_num, @PathVariable("dice") String dice, @PathVariable("email") String email, HttpServletResponse response_equals) throws IOException{
    
    System.out.println("마지막 : pass_num : "+pass_num);
    System.out.println("마지막 : email : "+email);
    System.out.println("마지막 : dice : "+dice);
    
    ModelAndView mv = new ModelAndView();
    
    mv.setViewName("/member/pass_change");
    
    mv.addObject("email",email);
    
    if (pass_num.equals(dice)) {
        
        //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 비밀번호 변경창으로 이동시킨다
    
        mv.setViewName("/member/pass_change");
        
        mv.addObject("email",email);
        
        //만약 인증번호가 같다면 이메일을 비밀번호 변경 페이지로 넘기고, 활용할 수 있도록 한다.
        
        response_equals.setContentType("text/html; charset=UTF-8");
        PrintWriter out_equals = response_equals.getWriter();
        out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
        out_equals.flush();

        return mv;	
    }else if (pass_num != dice) {
        
        
        ModelAndView mv2 = new ModelAndView(); 
        
        mv2.setViewName("/member/pass_email");
        
        response_equals.setContentType("text/html; charset=UTF-8");
        PrintWriter out_equals = response_equals.getWriter();
        out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
        out_equals.flush();
        

        return mv2;
        
    }    

    return mv;
    
}
	//변경할 비밀번호를 입력한 후에 확인 버튼을 누르면 넘어오는 컨트롤러
    @RequestMapping("pass_change/{email:.+}")
    public ModelAndView pass_change(@PathVariable String email, HttpServletRequest request, MemberDTO dto, HttpServletResponse pass) throws Exception{
    	
    	 String passwd = request.getParameter("new_pw");
         String email2 = email;
    	 
    	    dto.setEmail(email2);
    	    dto.setPasswd(passwd);
    	  //값을 여러개 담아야 하므로 해쉬맵을 사용해서 값을 저장함
            
            Map<String, Object> map = new HashMap<>();
            
            map.put("email", dto.getEmail());
            map.put("passwd", dto.getPasswd());
            
            memberService.pass_change(map,dto);
            
            ModelAndView mv = new ModelAndView();
    	    mv.setViewName("home");
    	    return mv;
    }
	/*마이페이지로 이동*/
	@GetMapping("mypage/{userid}")
	public ModelAndView moveToMyPage(@PathVariable(value="userid") String userid, ModelAndView mav) throws Exception{
		try {
			MemberDTO dto = memberService.viewMember(userid);
			Map<String, Object> map = new HashMap<>();
			map.put("dto", dto);

			mav.setViewName("member/mypage");
//			logger.info("@@@mav =>>"+mav+"@@@@@@@@@");

			mav.addObject("map", map);
//			logger.info("@@@mav =>>"+mav+"@@@@@@@@@");
			return mav;
		}catch (Exception e){
			e.printStackTrace();
			return new ModelAndView("home");

		}

	}

}





