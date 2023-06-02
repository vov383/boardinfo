package com.example.boardinfo.model.game.dao.gameRating;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;

@Repository
public class GameRatingDAOImpl implements GameRatingDAO  {

    @Inject
    SqlSession session;

    @Override
    public int addGameRating(GameRatingDTO dto) {
        System.out.println("dao들어옴");
        return session.insert("gameRating.add", dto);
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
