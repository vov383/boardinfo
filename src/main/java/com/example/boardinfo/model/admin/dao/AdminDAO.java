package com.example.boardinfo.model.admin.dao;

import com.example.boardinfo.model.admin.dto.AdminDTO;

import java.util.List;

public interface AdminDAO {

    List<AdminDTO> getAdminList();
    boolean loginCheck(AdminDTO aDto);
    boolean checkPw(String admin_id, String passwd);
    AdminDTO getDelValue(String admin_id);

    AdminDTO selectAdminByid(String admin_id);

    AdminDTO selectAdminByNick(String nickname);
    void insertAdmin(AdminDTO aDto);
    AdminDTO getAdminObject(String admin_id);
    AdminDTO updateAdmin(AdminDTO aDto);
    void deleteAdmin(String admin_id);

    /*member*/
    void memberWarn(String userid);

    void memberBlock(String userid);

    /*게임 정보 통계*/

    /*회원 활동 통계*/

    /**/

}
