package com.example.boardinfo.service.game;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;

public interface GameRatingService {

    public int addGameRating(GameRatingDTO dto);
    public int deleteGameRating(String userid, int gnum);
    public int updateGameRating(GameRatingDTO dto);



}
