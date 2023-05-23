package com.example.boardinfo.model.game.dao;

import java.util.List;

import com.example.boardinfo.model.game.dto.GameDTO;

public interface GameDAO {

	public List<GameDTO> gamelist();
	public void gameinsert(GameDTO dto);
	public void increaseViewcnt(int gnum) throws Exception;
	public Object view(int gnum) throws Exception;
    public List<GameDTO> getAutoGame(String input);
}
