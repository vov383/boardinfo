package com.example.boardinfo.service.admin;

import com.example.boardinfo.model.admin.dao.AdminDAO;
import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.model.member.dto.MemberDTO;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    //로깅
    private static final Logger logger
            = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Inject
    AdminDAO adminDao;
    @Inject
    MemberDAO memberDao;

    @Override
    public List<AdminDTO> getAdminList() {
        return adminDao.getAdminList();
    }

    @Override
    public List<MemberDTO> getMemberlist() {
        return null;
    }


    /*admin id 로그인 체크*/
    @Override
    public boolean loginCheck(AdminDTO aDto, HttpSession session) {
        boolean result = adminDao.loginCheck(aDto);
        if (result) {//로그인 성공
            //세션변수에 값 저장
            AdminDTO aDto2 = adminDao.getAdminObject(aDto.getAdmin_id());
            session.setAttribute("admin_id", aDto2.getAdmin_id());
            session.setAttribute("nickname", aDto2.getNickname());
//            logger.info("admin_id 세션 : "+(String)session.getAttribute("admin_id"));
//            logger.info("nickname 세션 : "+(String)session.getAttribute("nickname"));
        }
        return result;
    }
    @Override
    public boolean getDelValue(String admin_id) {
        AdminDTO delMember = adminDao.getDelValue(admin_id);
        if (delMember != null && "y".equals(delMember.getDel())) {
            return true; // 탈퇴한 회원인 경우
        }
        return false; // 탈퇴하지 않은 회원인 경우
    }

    @Override
    public void logout(HttpSession session) {
        // 세션 초기화
        session.invalidate();
    }

    @Override
    public boolean checkDuplicateId(String admin_id) {
        AdminDTO existingAdmin = adminDao.selectAdminByid(admin_id);
        MemberDTO existingMember = memberDao.selectMemberById(admin_id);

        /* admin과 member id 모두 null이면 available 이고, 하나라도 값이 있으면 isDuplicate true */
        if (existingAdmin != null || existingMember != null) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean checkDuplicateNick(String nickname) {
        AdminDTO existingAdmin = adminDao.selectAdminByNick(nickname);
        MemberDTO existingMember = memberDao.selectMemberByNick(nickname);

        /*모두 null이면 available 이고 하나라도 값이 있으면 duplicate*/
        if (existingAdmin != null || existingMember != null) {
            return true;
        } else {
            return false;
        }
    }
    @Override
    public boolean checkPw(String admin_id, String passwd) {
        return adminDao.checkPw(admin_id, passwd);
    }

    @Override
    public void insertAdmin(AdminDTO aDto) {

    }
    @Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
    String uploadPath;
    /*admin id C*/
    @Override
    public void insertAdmin(AdminDTO aDto, HttpServletResponse response, MultipartFile profile_img) {

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
                String uploadedFileName = UploadFileUtils.uploadFile(uploadPath, fileName, bytes);
                aDto.setProfile(uploadedFileName);

                adminDao.insertAdmin(aDto);
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
    }



    /*admin id U*/
    @Override
    public void updateAdmin(AdminDTO aDto) {

    }

    @Override
    public void deleteAdmin(String admin_id) {

    }

    @Override
    public AdminDTO viewMember(String admin_id) {
        return null;
    }

    @Override
    public void memberWarn(String userid) {

    }

    @Override
    public void memberBlock(String userid) {

    }

    @Override
    public void moveToAdminDashboard() {

    }

    @Override
    public void gameStatistics() {

    }

    @Override
    public void memberStatistics() {

    }

    @Override
    public void reviewStatistics() {

    }

    @Override
    public Object viewAdmin(String admin_id) {
        return null;
    }

}