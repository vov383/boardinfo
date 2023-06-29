package com.example.boardinfo.service.game;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import org.json.simple.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface GameRatingService {

    public int addGameRating(HashMap<String, Object> rating);public Map<String, Object> getStatistic(int gnum, String user_id);
    public GameRatingDTO getUserRating(int gnum, String userid);
    public int updateGameRating(HashMap rating);
    public int deleteGameRating(int gnum, String userid);
    public JSONObject getRatingJsonData(int gnum);
    public JSONObject getWeightJsonData(int gnum);
    public JSONObject getPlayerJsonData(int gnum);
    public List<GameRatingDTO> getTopRatings(int gnum, int number, String user_id);
    public int likeIt(int gnum, String writer_id, String user_id);
    public int unLikeIt(int gnum, String writer_id, String user_id);

    Map<String, Object> getMoreRatings(int gnum, String user_id, int curPage, String sort);
}
