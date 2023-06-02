package com.example.boardinfo.service.game;

import com.example.boardinfo.model.game.dao.gameRating.GameRatingDAO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;

@Service
public class GameRatingServiceImpl implements GameRatingService{

    @Inject
    GameRatingDAO gameRatingDAO;

    @Override
    public int addGameRating(GameRatingDTO dto) {
        System.out.println("dao가자");
        return gameRatingDAO.addGameRating(dto);
    }

    @Override
    public int deleteGameRating(String userid, int gnum) {
        return 0;
    }

    @Override
    public int updateGameRating(GameRatingDTO dto) {
        return 0;
    }
}
