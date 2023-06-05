package com.example.boardinfo.model.game.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.GameDTO;

public interface GameDAO {

	int countList();
	List<GameDTO> gamelist(Map<String, Object> map);
	void gameinsert(GameDTO dto);
	void increaseViewcnt(int gnum) throws Exception;
	GameDTO view(int gnum);
    List<GameDTO> getAutoGame(String input);
    void addAttach(String fullName, String userid);
    void delteFile(String fileName);
	List<GameDTO> filteredGamelist(Map<String, Object> map);
	int countList(Map<String, Object> map);
    void gameupdate(GameDTO dto);
    void insert_exnum(int exnum, String userid);
	void insert_renum(int renum, String userid);
}
