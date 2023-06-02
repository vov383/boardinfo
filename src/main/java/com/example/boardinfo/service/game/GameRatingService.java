package com.example.boardinfo.service.game;

import java.util.HashMap;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;

public interface GameRatingService {

    public int addGameRating(HashMap<String, Object> rating);
    public int deleteGameRating(String userid, int gnum);
    public int updateGameRating(GameRatingDTO dto);



}
