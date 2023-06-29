package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface TBoardService {
    Map<String, Object> list(TradeSearchDTO sDto);

    void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception;

    Map<String, Object> viewPost(int tb_num);

    void update(TBoardDTO dto);

    void delete(int tb_num);

    int countArticle(TradeSearchDTO sDto);

    void increaseViewCount(int tb_num, HttpSession session);

    List<String> getAttach(int tb_num);

    int deleteFile(Map<String, String> map);

    public List<TBoardDTO> getHomeList(Integer size);

    List<TBoardDTO> totalSearch(String gameKeyword);

    Map<String, Object> totalSearchMore(Map<String, Object> map);

    /*좋아요*/
    int goodCreate(TradeSearchDTO sDto, HttpSession session);

    int goodDelete(TradeSearchDTO sDto, HttpSession session);
}
