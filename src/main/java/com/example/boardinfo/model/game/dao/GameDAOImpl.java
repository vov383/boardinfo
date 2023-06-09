package com.example.boardinfo.model.game.dao;

import java.awt.image.ImageProducer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.service.game.GameServiceImpl;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.game.dto.GameDTO;

@Repository
public class GameDAOImpl implements GameDAO {
	private static final Logger logger=
			LoggerFactory.getLogger(GameDAOImpl.class);
	@Inject
	SqlSession sqlSession;

	public int countList() { return sqlSession.selectOne("game.gameListCount");}
	
	@Override
	public List<GameDTO> gamelist(Map<String, Object> map){
		return sqlSession.selectList("game.gameList", map);
	}
	
	@Override
	public void gameinsert(GameDTO dto) {
		sqlSession.insert("game.gameInsert",dto);
	}
	
	public void increaseViewcnt(int gnum) throws Exception {
		sqlSession.update("game.increaseViewcnt", gnum);
	}
	
	public GameDTO view(int gnum) {
		return sqlSession.selectOne("game.view", gnum);
	}

	public List<GameDTO> getAutoGame(String input){
		return sqlSession.selectList("game.getAuto", input);
	}

	public void addAttach(String fullName, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("fullName",fullName);
		map.put("userid",userid);
		sqlSession.insert("game.addAttach", map);
	}
	public void delteFile(String fileName){
		sqlSession.delete("game.deleteFile", fileName);
	}

	public int countList(Map<String, Object> map){
		return sqlSession.selectOne("game.filteredListCount", map);
	}

	public List<GameDTO> filteredGamelist(Map<String, Object> map) {

		return sqlSession.selectList("game.filteredList", map);
	}
	public void gameupdate(GameDTO dto){
		sqlSession.update("game.gameupdate", dto);
	}

	public void insert_expansion(String expansion, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("expansion",expansion);
		map.put("userid",userid);
		sqlSession.insert("game.expansion_insert", map);
	}

	public void insert_reimplement(String reimplement, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("reimplement",reimplement);
		map.put("userid",userid);
		sqlSession.insert("game.reimplement_insert", map);
	}

	public void insert_expansion(int gnum, String expansion, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("expansion",expansion);
		map.put("userid",userid);
		sqlSession.insert("game.expansion_update", map);
	}

	public void insert_reimplement(int gnum, String reimplement, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("reimplement",reimplement);
		map.put("userid",userid);
		sqlSession.insert("game.reimplement_update", map);
	}

	public Map<String, Object> getExpansion(int gnum){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);

		//해당게임의 확장판 게임을 구하는 경우 (해당게임이 원본)
		map.put("strOn", "exnum");
		map.put("strWhere","gnum");
		List<GameDTO> origin =sqlSession.selectList("game.getExpansion", map);

		//해당게임의 원본 게임을 구하는 경우 (해당게임이 확장판)
		map.replace("strOn","gnum");
		map.replace("strWhere","exnum");
		List<GameDTO> expansion = sqlSession.selectList("game.getExpansion", map);

		map.clear();

		map.put("origin", origin);
		map.put("expansion",expansion);

		return map;
	}

	public Map<String, Object> getReimplement(int gnum){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);

		//해당게임의 확장판 게임을 구하는 경우 (해당게임이 원본)
		map.put("strOn", "renum");
		map.put("strWhere","gnum");
		List<GameDTO> origin =sqlSession.selectList("game.getReimplement", map);

		//해당게임의 원본 게임을 구하는 경우 (해당게임이 확장판)
		map.replace("strOn","gnum");
		map.replace("strWhere","renum");
		List<GameDTO> expansion = sqlSession.selectList("game.getReimplement", map);

		map.clear();

		map.put("origin", origin);
		map.put("reimplement",expansion);

		return map;
	}

	public void deleteGame(int gnum, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);
		map.put("userid",userid);

		sqlSession.update("game.delete", map);
	}

	public List<String> viewExpansion(int gnum){
		List<String> list = sqlSession.selectList("game.viewExpansion", gnum);
		return list;
	}

	public List<String> viewReimplement(int gnum){
		List<String> list = sqlSession.selectList("game.viewReimplement", gnum);
		return list;
	}

	public int getExnum(int gnum, String expansion){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);
		map.put("expansion",expansion);
		return sqlSession.selectOne("game.getExnum", map);
	}

	public int getRenum(int gnum, String reimplement){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);
		map.put("reimplement",reimplement);
		return sqlSession.selectOne("game.getRenum", map);
	}
}
