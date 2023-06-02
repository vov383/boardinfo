package com.example.boardinfo.model.game.dao.gameRating;

import java.util.HashMap;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;

public interface GameRatingDAO {
    public int addGameRating(HashMap<String,Object> dto);
    public int deleteGameRating(String userid, int gnum);
    public int updateGameRating(GameRatingDTO dto);
    public HashMap<String, Object> getStatistic(int gnum);

}
