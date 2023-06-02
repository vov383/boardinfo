package com.example.boardinfo.model.game.dao.gameRating;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

@Repository
public class GameRatingDAOImpl implements GameRatingDAO  {

    @Inject
    SqlSession session;

    @Override
    public int addGameRating(HashMap<String, Object> dto) {
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

	@Override
	public HashMap<String, Object> getStatistic(int gnum) {
		
		HashMap<String, Object> statisticMap = session.selectOne("gameRating.avgRatingAndWeight", gnum);
		HashMap<String, Integer> tmpMap = session.selectOne("gameRating.getOptimumPlayers", gnum);
		
		
		ArrayList<Integer> bestPlayers = new ArrayList<>();
		ArrayList<Integer> goodPlayers = new ArrayList<>();
		
		for(int i=1; i<=5; i++) {
			if(Integer.parseInt(String.valueOf(tmpMap.get("BEST" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("GOOD" + i))) &&
					Integer.parseInt(String.valueOf(tmpMap.get("BEST" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("BAD" + i)))){
						bestPlayers.add(i);
					}
		}
		
		if(bestPlayers.size() == 0) {
			for(int i=1; i<=5; i++) {
				if(Integer.parseInt(String.valueOf(tmpMap.get("GOOD" + i))) > Integer.parseInt(String.valueOf(tmpMap.get("BAD" + i)))){
							goodPlayers.add(i);
						}
			}
		}
		

		if(statisticMap!=null) {
			statisticMap.put("bestPlayers", bestPlayers);
			statisticMap.put("goodPlayers", goodPlayers);
			
		}
		return statisticMap;
	}

    
    
    
}
