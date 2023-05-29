package com.example.boardinfo.model.game.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.GameDTO;

public interface GameDAO {

	int countList();
	List<GameDTO> gamelist(Map<String, Object> map);
	void gameinsert(GameDTO dto);
	void increaseViewcnt(int gnum) throws Exception;
	GameDTO view(int gnum) throws Exception;
    List<GameDTO> getAutoGame(String input);
    void addAttach(String fullName);
    void delteFile(String fileName);
	List<GameDTO> filteredGamelist(Map<String, Object> map);
	int countList(Map<String, Object> map);
}
