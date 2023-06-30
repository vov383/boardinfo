package com.example.boardinfo.model.admin.dao;

import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.awt.image.ImageProducer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AdminDAOImpl implements AdminDAO{

    //로깅
    private static final Logger logger
            = LoggerFactory.getLogger(AdminDAOImpl.class);

    @Inject
    SqlSession sqlSession;

    @Override
    public List<AdminDTO> getAdminList() {
        return sqlSession.selectList("admin.getAdminList");
    }

    @Override
    public boolean loginCheck(AdminDTO aDto) {
        String name = sqlSession.selectOne("admin.login_check", aDto);

        //조건식 ? true 일때의 값 : false 일 때의 값
        return name != null;
    }

    @Override
    public boolean checkPw(String admin_id, String passwd) {
        boolean result = false;

        Map<String,String> map=new HashMap<>();
        map.put("admin_id", admin_id);
        map.put("passwd", passwd);
        int count=sqlSession.selectOne("admin.checkPw", map);
        //비번이 맞으면(1), 틀리면(0) 리턴
        if(count==1) {
            result=true;
        }
        return result;
    }

    @Override
    public AdminDTO getDelValue(String admin_id) {
        return sqlSession.selectOne("admin.getDelValue",admin_id);
    }

    @Override
    public AdminDTO selectAdminByid(String admin_id) {
        return sqlSession.selectOne("admin.selectMemberById",admin_id);
    }

    @Override
    public AdminDTO selectAdminByNick(String nickname) {
        return sqlSession.selectOne("admin.selectAdminByNick", nickname);
    }
    @Override
    public void insertAdmin(AdminDTO aDto) {
        sqlSession.insert("admin.insertAdmin", aDto);
    }
    @Override
    public AdminDTO getAdminObject(String admin_id) {
        return sqlSession.selectOne("admin.getAdminDto", admin_id);
    }
    @Override
    public AdminDTO updateAdmin(AdminDTO aDto) {
        AdminDTO editedDto = sqlSession.selectOne("admin.updateAdmin",aDto);
        return editedDto;
    }

    @Override
    public void deleteAdmin(String admin_id) {
        sqlSession.update("admin.deleteAdmin",admin_id);
    }

    @Override
    public void memberWarn(String userid) {

    }

    @Override
    public void memberBlock(String userid) {

    }

    @Override
    public List<GameRatingDTO> gameRatinglist(String userid) {
        return sqlSession.selectList("admin.gameRatinglist", userid);
    }

    @Override
    public void deleteGameAdmin(int gnum, String admin_id) {
        sqlSession.delete("admin.deleteGameAdmin", gnum);
    }

    @Override
    public void deleteGameArtist(int gnum) {
        Map<String,Object> map=new HashMap<>();
        map.put("gnum", gnum);
        map.put("filter", "artist");
        sqlSession.delete("admin.deleteGameMappingTables", map);
    }

    @Override
    public void deleteGameCategory(int gnum) {
        Map<String,Object> map=new HashMap<>();
        map.put("gnum", gnum);
        map.put("filter", "category");
        sqlSession.delete("admin.deleteGameMappingTables", map);
    }

    @Override
    public void deleteGameDesigner(int gnum) {
        Map<String,Object> map=new HashMap<>();
        map.put("gnum", gnum);
        map.put("filter", "designer");
        sqlSession.delete("admin.deleteGameMappingTables", map);
    }

    @Override
    public void deleteGameMechanic(int gnum) {
        Map<String,Object> map=new HashMap<>();
        map.put("gnum", gnum);
        map.put("filter", "mechanic");
        sqlSession.delete("admin.deleteGameMappingTables", map);
    }

    @Override
    public void deleteGamePublisher(int gnum) {
        Map<String,Object> map=new HashMap<>();
        map.put("gnum", gnum);
        map.put("filter", "publisher");
        sqlSession.delete("admin.deleteGameMappingTables", map);
    }

    @Override
    public void deleteGameEx(int gnum) {
        sqlSession.delete("admin.deleteGameEx", gnum);
    }

    @Override
    public void deleteGameRe(int gnum) {
        sqlSession.delete("admin.deleteGameRe", gnum);
    }
}
