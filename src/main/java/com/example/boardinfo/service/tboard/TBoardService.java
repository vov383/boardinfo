package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface TBoardService {
    Map<String, Object> list(TradeSearchDTO sDto);

    void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception;

    Map<String, Object> viewPost(String tb_num);

    void update(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws IOException, Exception;



    int countArticle(TradeSearchDTO sDto);

    void increaseViewCount(String tb_num, HttpSession session);

    List<String> getAttach(String tb_num);


    int deleteFile(String tb_num);

    public List<TBoardDTO> getHomeList(Integer size);

    List<TBoardDTO> totalSearch(String gameKeyword);

    Map<String, Object> totalSearchMore(Map<String, Object> map);

    /*중고거래 좋아요 체크*/
    boolean checkLike(String goodkey);

    long checkUpdateTime(HttpSession sessoin, String tb_num);

    /*좋아요*/
    Map<String, String> addLike(HttpSession session, String tb_num);


    /*중고거래 좋아요 삭제*/
    boolean deleteLike(HttpSession session, String tb_num);

    void delete(String tbNum);
}
