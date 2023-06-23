package com.example.boardinfo.service.game;

import com.example.boardinfo.model.game.dao.gameRating.GameRatingDAO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.game.dto.gameRating.RatingStatisticDTO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GameRatingServiceImpl implements GameRatingService{


    @Inject
    GameRatingDAO gameRatingDAO;

    @Override
    public int addGameRating(HashMap<String, Object> dto) {
        return gameRatingDAO.addGameRating(dto);
    }

    @Override
    public int updateGameRating(HashMap rating) {
        return gameRatingDAO.updateGameRating(rating);
    }

    @Override
    public int deleteGameRating(int gnum, String userid) {
        return gameRatingDAO.deleteGameRating(gnum, userid);
    }

    @Override
    public Map<String, Object> getStatistic(int gnum, String user_id) {
       return gameRatingDAO.getStatistic(gnum, user_id);
    }

    @Override
    public GameRatingDTO getUserRating(int gnum, String userid) {
        return gameRatingDAO.getUserRating(gnum, userid);
    }

    @Override
    public JSONObject getRatingJsonData(int gnum) {
        List<RatingStatisticDTO> items = gameRatingDAO.getRatingStatistic(gnum);

        JSONObject data = new JSONObject(); //리턴할 최종 객체
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();
        JSONArray title = new JSONArray();


        col1.put("label", "별점");
        col1.put("type", "string");
        col2.put("label", "인원");
        col2.put("type", "number");

        title.add(col1);
        title.add(col2);
        data.put("cols", title);

        //행 객체 구성
        JSONArray body = new JSONArray();

        for(double i=0.5; i<=5; i=i+0.5){
            JSONObject name = new JSONObject();
            if(i%1==0){
                name.put("v", i);
            }
            else{
                name.put("v", "");
            }

            JSONObject count = new JSONObject();

            for(RatingStatisticDTO item : items){
                if(item.getValue() == i){
                    count.put("v", item.getCount());
                    break;
                }
            }
            if(count.get("v") == null) {
                count.put("v", 0);
            }

            JSONArray row = new JSONArray();
            row.add(name);
            row.add(count);
            JSONObject cell = new JSONObject();
            cell.put("c", row);
            body.add(cell);
        }

        data.put("rows", body);
        return data;

        /* 구조는 이런 식으로 가야 함
        {
            "rows":[
            {"c":[{"v":},{"v":0.5값}]},
            {"c":[{"v":"1"},{"v":1값}]},
            {"c":[{"v":},{"v":1.5값}]},
            {"c":[{"v":"2"},{"v":2값}]},
            {"c":[{"v":},{"v":2.5값}]},
            {"c":[{"v":"3"},{"v":3값}]},
            {"c":[{"v":},{"v":3.5값}]},
            {"c":[{"v":"4"},{"v":4값}]},
            {"c":[{"v":},{"v":4.5값}]},
            {"c":[{"v":"5"},{"v":5값}]}
],

            "cols":[
            {"label":"별점","type":"string"},
            {"label":"별점값","type":"number"}
]
        }
         */

    }

    @Override
    public JSONObject getWeightJsonData(int gnum) {
        List<RatingStatisticDTO> items = gameRatingDAO.getWeightStatistic(gnum);
        JSONObject result = new JSONObject(); //리턴할 최종 객체
        JSONObject tot = new JSONObject();
        JSONObject data = new JSONObject();
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();
        JSONArray title = new JSONArray();

        col1.put("label", "난이도");
        col1.put("type", "string");
        col2.put("label", "인원");
        col2.put("type", "number");

        title.add(col1);
        title.add(col2);
        data.put("cols", title);

        //행 객체 구성
        JSONArray body = new JSONArray();

        int totNum = 0;

        for(double i=0.5; i<=5; i=i+0.5){
            JSONObject name = new JSONObject();
            if(i%1==0){
                name.put("v", i);
            }
            else{
                name.put("v", "");
            }

            JSONObject count = new JSONObject();

            for(RatingStatisticDTO item : items){
                if(item.getValue() == i){
                    count.put("v", item.getCount());
                    totNum += item.getCount();
                    break;
                }
            }
            if(count.get("v") == null) {
                count.put("v", 0);
            }

            JSONArray row = new JSONArray();
            row.add(name);
            row.add(count);
            JSONObject cell = new JSONObject();
            cell.put("c", row);
            body.add(cell);
        }

        tot.put("count", totNum);
        data.put("rows", body);

        result.put("tot", tot);
        result.put("data", data);
        return result;
    }


    @Override
    public JSONObject getPlayerJsonData(int gnum) {
        Map<String, Integer> items = gameRatingDAO.getPlayerStatistic(gnum);
        JSONObject result = new JSONObject(); //리턴할 최종 객체
        JSONObject data = new JSONObject();
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();
        JSONObject col3 = new JSONObject();
        JSONObject col4 = new JSONObject();

        JSONArray title = new JSONArray();

        col1.put("label", "난이도");
        col1.put("type", "string");
        col2.put("label", "베스트");
        col2.put("type", "number");
        col3.put("label", "추천");
        col3.put("type", "number");
        col4.put("label", "비추천");
        col4.put("type", "number");


        title.add(col1);
        title.add(col2);
        title.add(col3);
        title.add(col4);
        data.put("cols", title);

        //행 객체 구성
        JSONArray body = new JSONArray();


        for(int i=1; i<=5; i++){
            JSONObject name = new JSONObject();
            if(i==5) name.put("v", i+"인 이상");
            else name.put("v", i+"인");

            JSONObject best = new JSONObject();
            best.put("v", items.get("BEST"+i));
            JSONObject good = new JSONObject();
            good.put("v", items.get("GOOD"+i));
            JSONObject bad = new JSONObject();
            bad.put("v", items.get("BAD"+i));

            JSONArray row = new JSONArray();
            row.add(name);
            row.add(best);
            row.add(good);
            row.add(bad);
            JSONObject cell = new JSONObject();
            cell.put("c", row);
            body.add(cell);
        }

        data.put("rows", body);

        return data;
    }

    @Override
    public List<GameRatingDTO> getTopRatings(int gnum, int number, String user_id) {
        return gameRatingDAO.getTopRatings(gnum, number, user_id);
    }

    @Override
    public int likeIt(int gnum, String writer_id, String user_id) {
        return gameRatingDAO.likeIt(gnum, writer_id, user_id);
    }

    @Override
    public int unLikeIt(int gnum, String writer_id, String user_id) {
        return gameRatingDAO.unLikeIt(gnum, writer_id, user_id);
    }
}
