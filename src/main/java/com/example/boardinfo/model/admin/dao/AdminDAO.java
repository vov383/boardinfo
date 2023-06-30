package com.example.boardinfo.model.admin.dao;

import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;

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

    List<GameRatingDTO> gameRatinglist(String userid);

    void deleteGameAdmin(int gnum, String admin_id);
    void deleteGameArtist(int gnum);
    void deleteGameCategory(int gnum);
    void deleteGameDesigner(int gnum);
    void deleteGameMechanic(int gnum);
    void deleteGamePublisher(int gnum);
    void deleteGameEx(int gnum);
    void deleteGameRe(int gnum);


    /*게임 정보 통계*/

    /*회원 활동 통계*/

    /**/

}
