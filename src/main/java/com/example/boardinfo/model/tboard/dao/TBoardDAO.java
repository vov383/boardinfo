package com.example.boardinfo.model.tboard.dao;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;

import java.util.List;
import java.util.Map;

public interface TBoardDAO {	
	List<TBoardDTO> list(TradeSearchDTO sDto);

	int insert(TBoardDTO dto);
	
	TBoardDTO viewPost(int tb_num);
	
	void update(TBoardDTO dto);
	void delete(int tb_num);

	int countArticle(TradeSearchDTO sDto);

	void increaseViewcnt(int tb_num);


	List<String> getAttach(int tb_num);

	int deleteFile(Map<String, String> map);

    int fileAttach(TBAttachDTO fDto);

	/*mypageDao로 옮김*/

    public List<TBoardDTO> getHomeList(Integer size);

    List<TBoardDTO> totalSearch(Map<String, Object> map);

    int totalSearchCount(Map<String, Object> map);


    int addLike(Map<String, Object> map);

	int deleteLike(String goodkey);

    int checkLike(String goodkey);
}

