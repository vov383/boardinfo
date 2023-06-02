package com.example.boardinfo.model.game.dao.gameRating;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;

public interface GameRatingDAO {
    public int addGameRating(GameRatingDTO dto);
    public int deleteGameRating(String userid, int gnum);
    public int updateGameRating(GameRatingDTO dto);

}
