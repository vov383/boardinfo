package com.example.boardinfo.model.tboard.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

public interface TBoardDAO {	
	List<TBoardDTO> list(Map<String, Object> map);

	void insert(TBoardDTO dto);
	
	TBoardDTO viewPost(int tb_num);
	
	void update(TBoardDTO dto);
	void delete(int tb_num);

	int countArticle(Map<String, Object> map);

	void increaseViewcnt(int tb_num);

	void increaseRecnt(int tb_num);

	List<String> getAttach(int tb_num);

	void deleteFile(String fileName);

    void fileAttach(TBAttachDTO f_dto);

    void insertWithAddress(TBoardDTO dto);

}
