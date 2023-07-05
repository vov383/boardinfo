package com.example.boardinfo.service.admin;

import com.example.boardinfo.model.admin.dao.AdminDAO;
import com.example.boardinfo.model.admin.dto.AdminDTO;
import com.example.boardinfo.model.game.dao.GameDAO;
import com.example.boardinfo.model.game.dao.artist.ArtistDAO;
import com.example.boardinfo.model.game.dao.category.CategoryDAO;
import com.example.boardinfo.model.game.dao.designer.DesignerDAO;
import com.example.boardinfo.model.game.dao.mechanic.MechanicDAO;
import com.example.boardinfo.model.game.dao.publisher.PublisherDAO;
import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.model.member.dto.MemberDTO;
import com.example.boardinfo.model.mypage.dto.MyReplyDTO;
import com.example.boardinfo.util.GameUtils;
import com.example.boardinfo.util.Pager;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {
    //로깅
    private static final Logger logger
            = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Inject
    AdminDAO adminDao;
    @Inject
    MemberDAO memberDao;
    @Inject
    GameDAO gameDao;
    @Inject
    ArtistDAO artistDao;
    @Inject
    CategoryDAO categoryDao;
    @Inject
    DesignerDAO designerDao;
    @Inject
    MechanicDAO mechanicDao;
    @Inject
    PublisherDAO publisherDao;

    @Override
    public List<AdminDTO> getAdminList() {
        return adminDao.getAdminList();
    }

    @Override
    public List<MemberDTO> getMemberlist() {
        return memberDao.list();
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
        adminDao.insertAdmin(aDto);
    }
    @Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
    String uploadPath;
    /*admin C*/
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
    /*admin R*/
    @Override
    public AdminDTO viewAdmin(String admin_id) {
        return adminDao.selectAdminByid(admin_id);
    }

    /*admin U*/
    @Override
    public void updateAdmin(AdminDTO aDto, HttpSession session) {
        AdminDTO editedDto = adminDao.updateAdmin(aDto);
        /*세션에 nickname 수정*/
        String nickname = editedDto.getNickname();
        session.setAttribute("nickname", nickname);
    }

    @Override
    public void updateAdmin(AdminDTO aDto, HttpServletResponse response, MultipartFile profile_img, HttpSession session) {
        OutputStream out = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        try {
            //업로드한 파일 이름
            String fileName=profile_img.getOriginalFilename();
            //파일을 바이트 배열로 변환
            byte[] bytes=profile_img.getBytes();

            /*uid 적용한 파일명과 경로가 db에 저장되어야함
             * uploadPath는 insert와 같은 @Resource(name = "uploadPath"), servlet-context에 설정된 id값과 맞춤*/

            String uploadedFileName = UploadFileUtils.uploadFile(uploadPath, fileName, bytes);
            aDto.setProfile(uploadedFileName);

            AdminDTO editedDto = adminDao.updateAdmin(aDto);
            /*세션에 nickname 수정*/
            String nickname = editedDto.getNickname();
            session.setAttribute("nickname", nickname);
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
    /*admin D*/
    @Override
    public void deleteAdmin(String admin_id, HttpSession session) {
        adminDao.deleteAdmin(admin_id);
        /*세션 초기화*/
        session.invalidate();
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
    public List<GameRatingDTO> gameRatinglist(String userid) {
        return adminDao.gameRatinglist(userid);
    }


    @Override
    public Map<String, Object> confirmList(int curPage, String sort) {
        Map<String, Object> map = new HashMap<>();
        if(sort.indexOf("mia") != -1){
            map.put("sort", sort);
            List<ArtistDTO> alist = artistDao.confirmList(map);
            List<CategoryDTO> clist = categoryDao.confirmList(map);
            List<DesignerDTO> dlist = designerDao.confirmList(map);
            List<MechanicDTO> mlist = mechanicDao.confirmList(map);
            List<PublisherDTO> plist = publisherDao.confirmList(map);

            map.put("alist", alist);
            map.put("clist", clist);
            map.put("dlist", dlist);
            map.put("mlist", mlist);
            map.put("plist", plist);

        }else{
            int count = gameDao.confirmListCount(sort);

            Pager pager = new Pager(count, curPage, 10);
            int start = pager.getPageBegin();
            int end = pager.getPageEnd();

            map.put("start",start);
            map.put("end",end);
            map.put("curPage", curPage);
            map.put("sort", sort);

            List<GameDTO> list = gameDao.confirmList(map);

            map.put("count", count);
            map.put("pager",pager);
            map.put("list",list);
        }
        return map;
    }

    @Override
    public void deleteitem(String filter, int num) {
        switch (filter){
            case "artist":
                artistDao.deleteitem(num);
                break;
            case "gamecategory":
                categoryDao.deleteitem(num);
                break;
            case "designer":
                designerDao.deleteitem(num);
                break;
            case "mechanic":
                mechanicDao.deleteitem(num);
                break;
            case "publisher":
                publisherDao.deleteitem(num);
                break;
        }
    }

    @Override
    public void denyGame(int gnum, String userid) {
        gameDao.denyGame(gnum,userid);
    }

    @Transactional
    @Override
    public void deleteGameAdmin(int gnum, String admin_id) {
        adminDao.deleteGameAdmin(gnum,admin_id);
        /*매퍼테이블만 삭제*/
        adminDao.deleteGameArtist(gnum);
        adminDao.deleteGameCategory(gnum);
        adminDao.deleteGameDesigner(gnum);
        adminDao.deleteGameMechanic(gnum);
        adminDao.deleteGamePublisher(gnum);
        /*해당게임 들어있는것 삭제*/
        adminDao.deleteGameEx(gnum);
        adminDao.deleteGameRe(gnum);

    }



    @Transactional
    @Override
    public void allowGame(GameDTO dto) {

            //게임테이블에 update
            gameDao.gameAllow(dto);
            int gnum = dto.getGnum();
            String userid = dto.getUpdate_user();

            //카테고리테이블 update
            //dto의 값을 배열로 쪼갬
            String[] gamecategories = GameUtils.checkNullnSplit(dto.getGamecategory());

            for(String str : gamecategories) {
                //해당 번호의 게임에 해당 카테고리가 존재하느냐
                int check_game_category = categoryDao.check_category(str,gnum);

                if (check_game_category == 0) { // 해당 카테고리가 해당번호의 게임에 없다면
                    //해당 카테고리가 db에 존재하느냐
                    int cnum = categoryDao.check_category(str);
                    if (cnum == 0) { //해당 카테고리가 db에 존재하지 않는다면
                        categoryDao.insert_category(str,userid);
                        categoryDao.insert_category_mapping();
                    }else { //해당 카테고리가 db에 존재하면
                        categoryDao.insert_category_mapping(gnum,cnum);
                    }
                }
            }

            //아티스트테이블 update
            //dto의 값을 배열로 쪼갬
            String[] artists = GameUtils.checkNullnSplit(dto.getArtist());

            for(String str : artists) {
                //해당 번호의 게임에 해당 아티스트가 존재하느냐
                int check_artist = artistDao.check_artist(str,gnum);

                if (check_artist == 0) { // 해당 아티스트가 해당번호의 게임에 없다면
                    //해당 아티슽츠가 db에 존재하느냐
                    int anum = artistDao.check_artist(str);
                    if(anum == 0) { //해당 아티스트가 해당번호의 게임에 없다면
                        artistDao.insert_artist(str,userid);
                        artistDao.insert_artist_mapping();
                    }else { // db에 존재하는 아티스트라면
                        artistDao.insert_artist_mapping(gnum,anum);
                    }
                }
            }

            //메카닉테이블 update
            //dto의 값을 배열로 쪼갬
            String[] mechanics = GameUtils.checkNullnSplit(dto.getMechanic());

            for(String str : mechanics) {
                //해당 번호의 게임에 해당 메카닉이 존재하느냐
                int check_mechanic = mechanicDao.check_mechanic(str,gnum);

                if (check_mechanic == 0) { // 해당 매카니즘이 해당번호의 게임에 없다면
                    //해당 메카닉이 db에 존재하느냐
                    int mnum = mechanicDao.check_mechanic(str);
                    if(mnum == 0){ //해당 메카닉이 db에 존재하지 않는다면
                        mechanicDao.insert_mechanic(str,userid);
                        mechanicDao.insert_mechanic_mapping();
                    }else { //해당 메카닉이 db에 존재하면
                        mechanicDao.insert_mechanic_mapping(gnum,mnum);
                    }
                }
            }

            //퍼블리셔테이블 update
            //dto의 값을 배열로 쪼갬
            String[] publishers = GameUtils.checkNullnSplit(dto.getPublisher());

            for(String str : publishers) {
                //해당 번호의 게임에 해당 퍼블리셔가 존재하느냐
                int check_publisher = publisherDao.check_publisher(str,gnum);

                if (check_publisher == 0) { // 해당 제작자가 해당번호의 게임에 없다면
                    //해당 제작자가 db에 존재하느냐
                    int pnum = publisherDao.check_publisher(str);
                    if(pnum == 0){ //해당 제작자가 db에 존재하지 않는다면
                        publisherDao.insert_publisher(str, userid);
                        publisherDao.insert_publisher_mapping();
                    }else { // 해당 제작자가 db에 존재하면
                        publisherDao.insert_publisher_mapping(gnum,pnum);
                    }
                }
            }

            //디자이너테이블 update
            //dto의 값을 배열로 쪼갬
            String[] designers = GameUtils.checkNullnSplit(dto.getDesigner());

            for(String str : designers) {
                //해당 번호의 게임에 해당 디자이너가 존재하느냐
                int check_designer = designerDao.check_designer(str,gnum);

                if (check_designer == 0) { // 해당 디자이너가 해당번호의 게임에 없다면
                    //해당 디자이너가 db에 존재하느냐
                    int dnum = designerDao.check_designer(str);
                    if(dnum == 0){ //해당 디자이너가 db에 존재하지 않는다면
                        designerDao.insert_designer(str, userid);
                        designerDao.insert_designer_mapping();
                    }else { //해당 디자이너가 db에 존재하면
                        designerDao.insert_designer_mapping(gnum,dnum);
                    }

                }
            }

            //확장게임 테이블에 update
            String expansion = dto.getExpansion();
            if(expansion != null && expansion != "") {
                //확장게임 배열
                String[] expansions = dto.getExpansion().split(",");
                for (String str : expansions) {
                    int exnum = gameDao.getExnum(gnum, str);
                    if (exnum == 0) {
                        gameDao.insert_expansion(gnum, str, userid);
                    }
                }
            }

            //재구현게임 테이블에 update
            String reimplement = dto.getReimplement();
            if(reimplement != null && expansion != "") {
                //재구현게임 배열
                String[] reimplements = dto.getReimplement().split(",");
                for (String str : reimplements) {
                    int renum = gameDao.getRenum(gnum, str);
                    if (renum == 0) {
                        gameDao.insert_reimplement(gnum, str, userid);
                    }
                }
            }

    }

    /*어드민 회원 목록 모듈*/
    @Override
    public Map<String, Object> getMemberList(int curPage) {
        int count = adminDao.getMemberCount();
        Pager pager = new Pager(count, curPage, 10);

        int start = pager.getPageBegin();
        int end = pager.getPageEnd();

        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);
        List<MemberDTO> memberList = adminDao.getMemberTabbed(map);
        return null;
    }

    @Override
    public Map<String, Object> getAdminTabList() {
        List<AdminDTO> adminDtos = adminDao.getAdminList();
        Map<String, Object> map = new HashMap<>();
        map.put("adminDtos", adminDtos);
        return map;
    }

    @Override
    public Map<String, Object> getAllReListTab(int curPage) {
        int count = adminDao.getAllReCount();
        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();
        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);
        List<MyReplyDTO> replyDtos = adminDao.getAllReplies(map);
        map.put("pager", pager);
        map.put("replyDtos", replyDtos);
        return map;
    }

}