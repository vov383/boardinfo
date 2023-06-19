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
    //회원 상세정보
    @RequestMapping("admin_view.do")
    public String view(@RequestParam String admin_id, Model model) {
        //모델에 자료 저장
        model.addAttribute("dto", adminService.viewAdmin(admin_id));
        return "admin/view";
    }
    //회원 상세정보 수정
//    @RequestMapping("update.do")
//    public String update(AdminDTO aDto, HttpServletRequest request, HttpServletResponse response,
//                         @RequestParam MultipartFile profile_img) {
//        OutputStream out = null;
//        response.setCharacterEncoding("utf-8");
//        response.setContentType("text/html; charset=utf-8");
//
//        try {
//            //업로드한 파일 이름
//            String fileName=profile_img.getOriginalFilename();
//            //파일을 바이트 배열로 변환
//            byte[] bytes=profile_img.getBytes();
//            out = new FileOutputStream(new File(uploadPath+"/"+fileName));
//            //서버로 업로드
//            out.write(bytes);
//
//            aDto.setProfile(fileName);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if(out != null) {
//                    out.close();
//                }
//            } catch (Exception e2) {
//                e2.printStackTrace();
//            }
//        }
//        adminService.updateAdmin(aDto);
//        HttpSession session = request.getSession();
//        session.setAttribute("name",aDto.getName());
//        return "home";
//    }
//
//    //회원 삭제 (del='n'  ->  del='y')로 변경 후 보이지 않게 처리
//    @RequestMapping("delete.do")
//    public String delete(@RequestParam("userid") String userid,HttpSession session ) {
//        memberService.deleteMember(userid, session);
//
//        return "home";
//    }
}
