package com.example.boardinfo.service.tboard;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
 
public interface TBoardService {
List<TBoardDTO> list(String select_category, String search_option, String keyword, int start, int end);
	
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
