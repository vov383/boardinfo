package com.example.boardinfo.model.game.dao.gameRating;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.game.dto.gameRating.RatingStatisticDTO;

public interface GameRatingDAO {
    public int addGameRating(HashMap<String,Object> dto);
    public int deleteGameRating(int gnum, String userid);
    public int updateGameRating(HashMap dto);
    public HashMap<String, Object> getStatistic(int gnum, String user_id);
    public GameRatingDTO getUserRating(int gnum, String userid);
    public List<RatingStatisticDTO> getRatingStatistic(int gnum);
    public List<RatingStatisticDTO> getWeightStatistic(int gnum);
    public Map<String, Integer> getPlayerStatistic(int gnum);
    public List<GameRatingDTO> getTopRatings(int gnum, int number, String user_id);
    public int likeIt(int gnum, String writer_id, String user_id);
    public int unLikeIt(int gnum, String writer_id, String user_id);

    //gnum에 해당하는 평점난이도 가져오기
    Map<String, Object> getRateWeight(int gnum);
}
