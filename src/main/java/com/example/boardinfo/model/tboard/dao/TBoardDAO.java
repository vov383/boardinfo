package com.example.boardinfo.model.tboard.dao;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

import java.util.List;
import java.util.Map;

public interface TBoardDAO {	
	List<TBoardDTO> list(Map<String, Object> map);

	int insert(TBoardDTO dto);
	
	TBoardDTO viewPost(int tb_num);
	
	void update(TBoardDTO dto);
	void delete(int tb_num);

	int countArticle(Map<String, Object> map);

	void increaseViewcnt(int tb_num);

	void increaseRecnt(int tb_num);

	List<String> getAttach(int tb_num);

	void deleteFile(String fileName);

    int fileAttach(TBAttachDTO fDto);


    List<TBoardDTO> getTbListByUserid(String userid);

    public List<TBoardDTO> getHomeList(Integer size);

    List<TBoardDTO> totalSearch(Map<String, Object> map);

    int totalSearchCount(Map<String, Object> map);
}

