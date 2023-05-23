package com.example.boardinfo.service.tboard;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
 
public interface TBoardService {
public List<TBoardDTO> list(String select_category, String search_option, String keyword, int start, int end);
	
	public void insert(TBoardDTO dto);


	public TBoardDTO viewPost(int tb_num);
	
	public void update(TBoardDTO dto);
	public void delete(int tb_num);

	public int countArticle(String select_category, String search_option, String keyword);

	public void increaseViewCount(int tb_num, HttpSession session);
	public void increaseRecnt(int tb_num);

	public List<String> getAttach(int tb_num);

	public void fileAttach(TBAttachDTO f_dto);

	public void deleteFile(String fileName);



}
