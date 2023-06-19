package com.example.boardinfo.model.admin.dao;

import com.example.boardinfo.model.admin.dto.AdminDTO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
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
    public void insertAdmin(AdminDTO aDto) {
        sqlSession.insert("admin.insertAdmin", aDto);
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
    public AdminDTO getAdminObject(String admin_id) {
        return sqlSession.selectOne("admin.getAdminDto", admin_id);
    }
    @Override
    public void updateAdmin(AdminDTO aDto) {
        sqlSession.selectOne("admin.updateAdmin",aDto);
    }

    @Override
    public void deleteAdmin(String admin_id) {
        sqlSession.update("admin.deleteMember",admin_id);
    }

    @Override
    public void memberWarn(String userid) {

    }

    @Override
    public void memberBlock(String userid) {

    }




}
