package com.example.boardinfo.model.game.dao;

import java.util.List;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.game.dto.GameDTO;

@Repository
public class GameDAOImpl implements GameDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<GameDTO> gamelist(){
		return sqlSession.selectList("game.gameList");
	}
	
	@Override
	public void gameinsert(GameDTO dto) {
		sqlSession.insert("game.gameInsert",dto);
	}
	
	public void increaseViewcnt(int gnum) throws Exception {
		sqlSession.update("game.increaseViewcnt", gnum);
	}
	
	public GameDTO view(int gnum) throws Exception {
		return sqlSession.selectOne("game.view", gnum);
	}

	public List<GameDTO> getAutoGame(String input){
		return sqlSession.selectList("game.getAuto", input);
	}

	public void addAttach(String fullName){
		sqlSession.insert("game.addAttach", fullName);
	}
	public void delteFile(String fileName){
		sqlSession.delete("game.deleteFile", fileName);
	}


}
