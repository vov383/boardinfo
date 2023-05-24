package com.example.boardinfo.model.tboard.dao;

import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

public interface TBoardDAO {	
	public List<TBoardDTO> list(String select_category, 
			String search_option, String keyword, 
			int start, int end);
	
	public void insert(TBoardDTO dto);
	
	public TBoardDTO viewPost(int tb_num);
	
	public void update(TBoardDTO dto);
	public void delete(int tb_num);

	public int countArticle(String select_category,
			String search_option, String keyword);

	public void increaseViewcnt(int tb_num);

	public void increaseRecnt(int tb_num);

	public List<String> getAttach(int tb_num);

	public void deleteFile(String fileName);

    void fileAttach(TBAttachDTO f_dto);
}
