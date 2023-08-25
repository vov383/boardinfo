package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
import com.example.boardinfo.util.Pager;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TBoardServiceImpl implements TBoardService {

    //로깅
    private static final Logger logger = LoggerFactory.getLogger(TBoardServiceImpl.class);
    @Inject
    TBoardDAO tboardDao;

    @Override
    public int countArticle(TradeSearchDTO sDto) {
        return tboardDao.countArticle(sDto);
    }

    @Override
    public Map<String, Object> list(TradeSearchDTO sDto) {

        int count = tboardDao.countArticle(sDto);
        Pager pager = new Pager(count, sDto.getCurPage(), 12);
        sDto.setStart(pager.getPageBegin());
        sDto.setEnd(pager.getPageEnd());

        List<TBoardDTO> list = tboardDao.list(sDto);
        Map<String, Object> map = new HashMap<>();
        sDto.setKeyword(sDto.getKeyword().substring(1, sDto.getKeyword().length() - 1));/*keyword에서 맨앞%, 맨뒤% 제거*/
        map.put("count", count);
        map.put("sDto", sDto);
        map.put("list", list);
//		map.put("fList", fList);
        map.put("pager", pager);
        return map;
    }

    @Transactional
    @Override
    public void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception {

        /*spring HtmlUtils를 활용해서 특수문자 처리*/
        String title = HtmlUtils.htmlEscape(dto.getTitle());
        String description = HtmlUtils.htmlEscape(dto.getDescription());
        String price = HtmlUtils.htmlEscape(dto.getPrice());
        dto.setTitle(title);
        dto.setDescription(description);
        dto.setPrice(price);

        int result = tboardDao.insert(dto);
        if (result == 1) {/*insert에 성공하면*/

            for (int i = 0; i < files.length; i++) {
                String fileName = files[i].getOriginalFilename();
                byte[] fileData = files[i].getBytes();
                /* 이미지를 업로드 안했을 경우 fileName이 ""라서 break로 반복문 탈출! */
                if (fileName == null || fileName.equals("")) {
                    break;
                }
                //파일 업로드
                /* UploadFileUtils 는 이미지파일이면 썸네일 파일 명을 리턴함 */
                String uploadedFileName = UploadFileUtils.uploadFile(uploadPath, fileName, fileData);
                logger.info("uploadedFileName :" + uploadedFileName);
                TBAttachDTO fDto = new TBAttachDTO();
                fDto.setFullName(uploadedFileName);
                fDto.setFileData(fileData);
                fDto.setFormatName(uploadedFileName.substring(uploadedFileName.lastIndexOf(".") + 1));
                fDto.setCreate_user(dto.getCreate_user());
                int result2 = tboardDao.fileAttach(fDto);
            }
        }

    }

    @Override
    public Map<String, Object> viewPost(String tb_num) {
        TBoardDTO dto = tboardDao.viewPost(tb_num);
        Map<String, Object> map = new HashMap<>();
        map.put("dto", dto);
        return map;
    }

    @Override
    public void update(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception {
        /*spring HtmlUtils를 활용해서 특수문자 처리*/
        String title = HtmlUtils.htmlEscape(dto.getTitle());
        String description = HtmlUtils.htmlEscape(dto.getDescription());
        String price = HtmlUtils.htmlEscape(dto.getPrice());
        dto.setTitle(title);
        dto.setDescription(description);
        dto.setPrice(price);

        int result = tboardDao.update(dto);
        if (result == 1) {/*update에 성공하면*/
            //기존 tb_num에 해당하는 tb_files 에서 첨부파일 row 삭제처리
            int fileRowDel = tboardDao.deleteFile(dto.getTb_num());
            if (fileRowDel == 1) {
                for (int i = 0; i < files.length; i++) {
                    String fileName = files[i].getOriginalFilename();
                    byte[] fileData = files[i].getBytes();
                    /* 이미지를 업로드 안했을 경우 fileName이 ""라서 break로 반복문 탈출! */
                    if (fileName == null || fileName.equals("")) {
                        break;
                    }
                    //파일 업로드
                    /* UploadFileUtils 는 이미지파일이면 썸네일 파일 명을 리턴함 */
                    String uploadedFileName = null;
                    try {
                        uploadedFileName = UploadFileUtils.uploadFile(uploadPath, fileName, fileData);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    logger.info("uploadedFileName :" + uploadedFileName);
                    TBAttachDTO fDto = new TBAttachDTO();
                    fDto.setFullName(uploadedFileName);
                    fDto.setFileData(fileData);
                    fDto.setFormatName(uploadedFileName.substring(uploadedFileName.lastIndexOf(".") + 1));
                    fDto.setCreate_user(dto.getCreate_user());
                    int result2 = tboardDao.fileAttach(fDto);
                }

            }
        }
    }


    @Override
    public void increaseViewCount(String tb_num, HttpSession session) {
        long update_time = 0;
        if (session.getAttribute("update_time_" + tb_num) != null) {
            //최근에 조회수 올린 시간
            update_time = (long) session.getAttribute("update_time_" + tb_num);
        }
        long current_time = System.currentTimeMillis();
        //일정 시간(5초)이 경과하면 조회수 증가 처리
        if (current_time - update_time > 5 * 1000) {//24*60*60*1000(하루)
            //조회수 증가 처리
            tboardDao.increaseViewcnt(tb_num);
            //세션은 service까지 가져오면 됨.. dao로 안 가져가도 됨

            //조회수 올린 시간 저장
            session.setAttribute("update_time_" + tb_num, current_time);
        }
    }


    @Override
    public List<String> getAttach(String tb_num) {
        return tboardDao.getAttach(tb_num);
    }

    @Override
    public int deleteFile(String tb_num) {
        return tboardDao.deleteFile(tb_num);
    }

    @Override
    public List<TBoardDTO> getHomeList(Integer size) {
        List<TBoardDTO> list = tboardDao.getHomeList(size);
        return list;

    }

    @Override
    public List<TBoardDTO> totalSearch(String gameKeyword) {
        Map<String, Object> map = new HashMap<>();
        map.put("gameKeyword", gameKeyword);
        map.put("filter", "none");
        return tboardDao.totalSearch(map);
    }

    @Override
    public Map<String, Object> totalSearchMore(Map<String, Object> map) {
        int curPage = Integer.parseInt(String.valueOf(map.get("curPage")));

        int count = tboardDao.totalSearchCount(map);

        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();

        map.put("start", start);
        map.put("end", end);


        List<TBoardDTO> list = tboardDao.totalSearch(map);
        map.put("list", list);
        map.put("count", count);
        map.put("pager", pager);

        return map;
    }

    /*중고거래 좋아요 추가*/
    @Override
    public Map<String, String> addLike(HttpSession session, String tb_num) {
        Map<String, String> response = new HashMap<>();
        String userid = (String) session.getAttribute("userid");
        String goodkey = userid + tb_num;

        /*세션에 userid 가 없으면 일단 바로 response 리턴*/
        if (session.getAttribute("userid") == null) {
            response.put("status", "fail");
            response.put("message", "로그인 후 이용하세요");
            return response;
        } else {/*userid 있으면*/
            /*updateTime 구하는 함수*/
            long checkTime = checkUpdateTime(session, tb_num);

            /*updateTime 5초가 안지났으면*/
            if (checkTime < 5 * 1000) {
                response.put("status", "fail");
                response.put("message", "좋아요 버튼은 5초에 한번만 클릭할 수 있습니다. 잠시 후에 다시 사용하세요");
                return response;
            }

            /*해당 글에 이미 좋아요가 있는지 여부 체크*/
            boolean checked = checkLike(goodkey);

            if (!checked) {
                /*기존에 안 누른 사람이니까 좋아요 추가 로직*/
                //좋아요 증가 처리

                Map<String, Object> map = new HashMap<>();
                map.put("userid", userid);
                map.put("tb_num", tb_num);
                map.put("goodkey", goodkey);
                /*결과가 1이면 true, 0아니면 false*/
                boolean result = (tboardDao.addLike(map) == 1) ? true : false;
                if (result) {
                    //조회수 올린 시간 저장
                    session.setAttribute("update_time_" + tb_num, System.currentTimeMillis());

                    response.put("status", "likeCheck");
                    response.put("message", "좋아요 등록 성공");
                    return response;


                } else {
                    response.put("status", "fail");
                    response.put("message", "좋아요 등록 실패");
                    return response;
                }

            } else {
                /*기존 좋아요에 있으니까 삭제로직*/
                boolean result = deleteLike(session, tb_num);
                if (result) {
                    response.put("status", "likeDelete");
                    response.put("message", "좋아요 취소 성공");
                    return response;
                } else {
                    response.put("status", "fail");
                    response.put("message", "좋아요 취소 실패");
                    return response;
                }
            }
        }
    }

    /*중고거래 좋아요 체크*/
    @Override
    public boolean checkLike(String goodkey) {
        boolean result = false;
        int checked = tboardDao.checkLike(goodkey);
        if (checked == 1) {
            return result = true;
        } else {
            return result;
        }

    }

    /*좋아요 세션 시간 체크*/
    @Override
    public long checkUpdateTime(HttpSession session, String tb_num) {
        long update_time = 0;
        //최근에 좋아요 누른 시간
        update_time = (long) session.getAttribute("update_time_" + tb_num);

        long current_time = System.currentTimeMillis();

        return (current_time - update_time); /*밀리세컨 단위. 하면 초단위 * 1000 한 값*/
    }

    /*중고거래 좋아요 삭제*/
    @Override
    public boolean deleteLike(HttpSession session, String tb_num) {
        /*기존에 누른 사람이니까 좋아요 취소 로직*/
        /*결과가 1이면 true, 0아니면 false*/
        boolean result = false;
        String goodkey = (String) session.getAttribute("userid") + tb_num;

        int deleted = tboardDao.deleteLike(goodkey);
        if (deleted == 1) {
            session.setAttribute("update_time_" + tb_num, System.currentTimeMillis());
            return result = true;
        }
        return result;
    }

    @Override
    public void delete(String tbNum) {
        tboardDao.delete(tbNum);}

}
