package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface TBoardService {
    Map<String, Object> list(String select_category, String search_option, String keyword, int curPage);

    void insert(TBoardDTO dto);


    TBoardDTO viewPost(int tb_num);

    void update(TBoardDTO dto);

    void delete(int tb_num);

    int countArticle(String select_category, String search_option, String keyword);

    void increaseViewCount(int tb_num, HttpSession session);

    void increaseRecnt(int tb_num);

    List<String> getAttach(int tb_num);

    void fileAttach(TBAttachDTO f_dto);

    void deleteFile(String fileName);


}
