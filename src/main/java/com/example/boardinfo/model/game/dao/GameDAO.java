package com.example.boardinfo.model.game.dao;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.GameDTO;

public interface GameDAO {

	int countList();
	List<GameDTO> gamelist(Map<String, Object> map);
	void gameinsert(GameDTO dto, String dept);
	void increaseViewcnt(int gnum) throws Exception;
	GameDTO view(int gnum);
    List<GameDTO> getAutoGame(String input);
    void addAttach(String fullName, String userid);
    void delteFile(String fileName);
	List<GameDTO> filteredGamelist(Map<String, Object> map);
	int countList(Map<String, Object> map);
    void gameupdate(GameDTO dto, String dept);
    void insert_expansion(String expansion, String userid);
	void insert_reimplement(String reimplement, String userid);
	void insert_expansion(int gnum, String expansion, String userid);
	void insert_reimplement(int gnum, String reimplement, String userid);
    Map<String, Object> getExpansion(int gnum);
	Map<String, Object> getReimplement(int gnum);
	void deleteGame(int gnum, String userid);
	List<String> viewExpansion(int gnum);
	List<String> viewReimplement(int gnum);
	int getExnum(int gnum, String expansion);
	int getRenum(int gnum, String reimplement);

    int countExRe(Map<String, Object> map);

	List<GameDTO> ExReList(Map<String, Object> map);
    List<GameDTO> weeklyList(Map<String, Object> map);
	List<GameDTO> newbieList(Map<String, Object> map);
    List<GameDTO> totalSearch(Map<String, Object> map);
    int totalSearchCount(Map<String, Object> map);
    List<GameDTO> confirmList(Map<String, Object> map);
	int confirmListCount(String sort);
    List<String> attachlist(int gnum);
	void denyGame(int gnum, String userid);
	void gameAllow(GameDTO dto);
    int game_list_themeCount(Map<String, Object> map);
	List<GameDTO> game_list_theme(Map<String, Object> map);
}
