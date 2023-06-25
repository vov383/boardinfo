package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TBoardService {
    Map<String, Object> list(String select_category, String search_option, String keyword, int curPage);

    void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception;


    Map<String, Object> viewPost(int tb_num);

    void update(TBoardDTO dto);

    void delete(int tb_num);

    int countArticle(String select_category, String search_option, String keyword);

    void increaseViewCount(int tb_num, HttpSession session);

    void increaseRecnt(int tb_num);

    List<String> getAttach(int tb_num);

    void deleteFile(String fileName);

    public List<TBoardDTO> getHomeList(Integer size);

    List<TBoardDTO> totalSearch(String gameKeyword);

    Map<String, Object> totalSearchMore(Map<String, Object> map);
}
