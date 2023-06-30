package com.example.boardinfo.model.game.dao.gameRating;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.game.dto.gameRating.RatingStatisticDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class GameRatingDAOImpl implements GameRatingDAO  {

    @Inject
    SqlSession session;

    @Override
    public int addGameRating(HashMap<String, Object> dto) {
        return session.insert("gameRating.add", dto);
    }

    @Override
    public int deleteGameRating(int gnum, String userid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("user_id", userid);
        return session.delete("gameRating.delete", map);
    }

    @Override
    public int updateGameRating(HashMap dto) {
		return session.update("gameRating.update", dto);
    }

	@Override
	public HashMap<String, Object> getStatistic(int gnum, String user_id) {
		
		HashMap<String, Object> statisticMap = session.selectOne("gameRating.avgRatingAndWeight", gnum);
		HashMap<String, Integer> tmpMap = session.selectOne("gameRating.getOptimumPlayers", gnum);
		
		
		ArrayList<String> bestPlayers = new ArrayList<>();
		ArrayList<String> goodPlayers = new ArrayList<>();
		
		for(int i=1; i<=5; i++) {
			if(Integer.parseInt(String.valueOf(tmpMap.get("BEST" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("GOOD" + i))) &&
					Integer.parseInt(String.valueOf(tmpMap.get("BEST" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("BAD" + i)))){
						if(i==5){
							bestPlayers.add(i+"↑");
						}
						else{
							bestPlayers.add(i+"");
						}
					}
		}
		
		if(bestPlayers.size() == 0) {
			for(int i=1; i<=5; i++) {
				if(Integer.parseInt(String.valueOf(tmpMap.get("GOOD" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("BAD" + i)))){
					if(i==5){
						goodPlayers.add(i+"↑");
					}
					else{
						goodPlayers.add(i+"");
					}
						}
			}
		}

		String result = "";

		if(statisticMap!=null) {
			if(bestPlayers.size() >= 1){
				result = "베스트 " + String.join(", ", bestPlayers) + "인";
			}
			else if(goodPlayers.size()>=1){
				result = "추천 " + String.join(", ", goodPlayers) + "인";
			}

			statisticMap.put("recommendPlayers", result);

			if(user_id != null){
				Map<String, Object> map = new HashMap<>();
				map.put("gnum", gnum);
				map.put("user_id", user_id);
				Float userRating = session.selectOne("gameRating.getUserRatingPoint", map);
				statisticMap.put("userRating", userRating);
			}

		}

		return statisticMap;
	}


	@Override
	public GameRatingDTO getUserRating(int gnum, String user_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("user_id", user_id);
		return session.selectOne("gameRating.getUserRating", map);
	}


	@Override
	public List<RatingStatisticDTO> getRatingStatistic(int gnum) {
		return session.selectList("gameRating.getRatingStatistic", gnum);
	}

	@Override
	public List<RatingStatisticDTO> getWeightStatistic(int gnum) {
		return session.selectList("gameRating.getWeightStatistic", gnum);
	}

	@Override
	public Map<String, Integer> getPlayerStatistic(int gnum) {
		return session.selectOne("gameRating.getOptimumPlayers", gnum);
	}

	@Override
	public List<GameRatingDTO> getTopRatings(int gnum, int number, String user_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("number", number);
		map.put("user_id", user_id);
		return session.selectList("gameRating.getTopRatings", map);
	}

	@Override
	public int likeIt(int gnum, String writer_id, String user_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("writer_id", writer_id);
		map.put("user_id", user_id);
		return session.insert("gameRating.likeIt", map);
	}

	@Override
	public int unLikeIt(int gnum, String writer_id, String user_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("writer_id", writer_id);
		map.put("user_id", user_id);
		return session.delete("gameRating.unLikeIt", map);
	}

	@Override
	public Map<String, Object> getRateWeight(int gnum) {
		Map<String, Object> statisticMap = session.selectOne("gameRating.avgRatingAndWeight", gnum);

		return statisticMap;
	}

	/*mypageDao로 옮김*/


	@Override
	public int getMoreRatingsCount(Map<String, Object> map) {
		return session.selectOne("gameRating.getMoreRatingsCount",map);
	}

	@Override
	public List<GameDTO> getMoreRatings(Map<String, Object> map) {
		return session.selectList("getMoreRatings", map);
	}
}
