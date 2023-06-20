package com.example.boardinfo.controller.admin;

import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.service.admin.AdminService;
import com.example.boardinfo.service.member.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("admin/*")
public class AdminController {

    @Inject
    AdminService adminService;

    @Inject
    MemberService memberService;
    //로깅
    private static final Logger logger
            = LoggerFactory.getLogger(AdminController.class);

    /*관리자 목록*/
    @RequestMapping("admin_list.do")
    public String adminList(Model model) {
        List<AdminDTO> list=adminService.getAdminList();
        model.addAttribute("list", list);
        return "admin/admin_list";
    }
    
    /*관리자 계정 등록창 이동*/
    @RequestMapping("admin_join.do")
    public String join() {
        return "admin/join";
    }

    /*관리자 로그인 창이동*/
    @RequestMapping("admin_login.do")
    public String login() {
        return "admin/login";
    }
    
    /*관리자 로그인*/
    @RequestMapping("login_check.do")
    public ModelAndView admin_login_check(AdminDTO aDto, HttpSession session) {
        //로그인 성공 true, 실패 false
        boolean result = adminService.loginCheck(aDto, session);
        boolean getDelValue = adminService.getDelValue(aDto.getAdmin_id()); // 회원 탈퇴 여부 확인
        ModelAndView mav = new ModelAndView();
        if (result) { //로그인 성공
            mav.setViewName("home");
        } else {
            mav.setViewName("admin/login");//뷰이름
            if (getDelValue) {
                mav.addObject("message", "del"); // 탈퇴한 회원 메시지
            } else {
                mav.addObject("message", "error"); // 로그인 실패 메시지

            }
        }
        return mav;
    }

    /*관리자 로그아웃*/
    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
        //세션초기화
        adminService.logout(session);
        return "redirect:/?=message=logout";
    }

    //관리자 join에서 아이디 중복확인
    @RequestMapping("check_id.do")
    @ResponseBody
    public String checkId(@RequestParam String admin_id) {
        boolean isDuplicate = adminService.checkDuplicateId(admin_id);
        if (isDuplicate) {
            return "duplicate"; //중복o
        } else {
            return "available"; //중복x
        }
    }
    //닉네임 중복확인
    @RequestMapping("check_nick.do")
    @ResponseBody
    public String check_nick(@RequestParam String nickname) {
        boolean isDuplicate = adminService.checkDuplicateNick(nickname);
        if (isDuplicate) {
            return "duplicate"; //중복o
        } else
        {
            return "available"; //중복x
        }
    }
    /*관리자 계정 생성*/
    @RequestMapping("admin_insert.do")
    public String insertAdmin(@ModelAttribute AdminDTO aDto, HttpServletResponse response, @RequestParam(value="profile_img", required=false) MultipartFile profile_img) {
        if(profile_img.isEmpty()){
            /*이미지 없이 insert*/
            adminService.insertAdmin(aDto);
        }else{
            /*프로필 이미지와 함께 insert*/
            adminService.insertAdmin(aDto, response, profile_img);
        }

        return "home";

    }
    /*관리자 상세정보*/
    @RequestMapping("admin_view.do")
    public ModelAndView view(@RequestParam String admin_id) {
        ModelAndView mav = new ModelAndView();
        //모델에 자료 저장
        mav.setViewName("admin/admin_view");
        AdminDTO dto = adminService.viewAdmin(admin_id);
        mav.addObject("dto", dto);
        return mav;
    }
    @RequestMapping("pass_check.do")
    public String checkPw(AdminDTO dto, Model model) {
        //비밀번호 체크
        boolean result=adminService.checkPw(dto.getAdmin_id(), dto.getPasswd());
        if(result) {//비번이 맞으면
            model.addAttribute("dto", adminService.viewAdmin(dto.getAdmin_id()));
            return "admin/edit";
        }else {//비번이 틀리면
            model.addAttribute("dto", dto);
            model.addAttribute("message", "비밀번호를 확인하세요.");
            return "admin/admin_view";
        }
    }
    //회원 상세정보 수정
    @RequestMapping("update.do")
    public String update(AdminDTO aDto, HttpServletRequest request, HttpServletResponse response,
                         @RequestParam MultipartFile profile_img,
                         HttpSession session) {
        if(profile_img.isEmpty()){
            /*이미지 없이 insert*/
            adminService.updateAdmin(aDto, session);

        }else{
            /*프로필 이미지와 함께 insert*/
            adminService.updateAdmin(aDto, response, profile_img, session);
        }
        return "home";
    }

    //회원 삭제 (del='n'  ->  del='y')로 변경 후 보이지 않게 처리
    @RequestMapping("delete.do")
    public String delete(@RequestParam("admin_id") String admin_id,HttpSession session ) {
        adminService.deleteAdmin(admin_id, session);

        return "home";
    }
}
