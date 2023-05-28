package com.example.boardinfo.model.game.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.GameDTO;

public interface GameDAO {

	List<GameDTO> gamelist();
	void gameinsert(GameDTO dto);
	void increaseViewcnt(int gnum) throws Exception;
	GameDTO view(int gnum) throws Exception;
    List<GameDTO> getAutoGame(String input);
    void addAttach(String fullName);
    void delteFile(String fileName);
	List<GameDTO> gamelist(Map<String, Object> map);
}
