package com.example.boardinfo.service.admin;

import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.model.member.dto.MemberDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public interface AdminService {
    List<AdminDTO> getAdminList();
    List<MemberDTO> getMemberlist();

    void insertAdmin(AdminDTO aDto);
    void insertAdmin(AdminDTO aDto, HttpServletResponse response, MultipartFile profile_img);
    boolean loginCheck(AdminDTO aDto, HttpSession session);
    boolean checkPw(String admin_id, String passwd);
    void updateAdmin(AdminDTO aDto);
    void deleteAdmin(String admin_id);
    AdminDTO viewMember(String admin_id);

    /*member*/
    void memberWarn(String userid);

    void memberBlock(String userid);
    
    /*어드민 대시보드 보기*/
    void moveToAdminDashboard();

    /*게임 정보 통계*/
    void gameStatistics();
    /*회원 활동 통계*/
    void memberStatistics();
    /*리뷰 통계*/
    void reviewStatistics();

    boolean getDelValue(String admin_id);

    void logout(HttpSession session);

    boolean checkDuplicateId(String admin_id);

    boolean checkDuplicateNick(String nickname);

    Object viewAdmin(String adminId);


}
