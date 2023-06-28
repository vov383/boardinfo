package com.example.boardinfo.model.game.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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

	//페이징에 필요한 전체 리스트갯수 구하기
	public int countList() {
		return sqlSession.selectOne("game.gameListCount");
	}

	//전체게임의 목록, 기준에 따라 순서가 다르다
	@Override
	public List<GameDTO> gamelist(Map<String, Object> map){
		List<GameDTO> list = new ArrayList<>();
		String sort = (String)map.get("sort");
		switch (sort){
			case "week":
				list = sqlSession.selectList("game.gameList", map);
				break;
			case "month":
				list = sqlSession.selectList("game.gameList_month", map);
				break;
			case "newbie":
				list = sqlSession.selectList("game.gameList_newbie", map);
				break;
			case "vcnt":
				list = sqlSession.selectList("game.gameList_vcnt", map);
				break;
		}
		return list;
	}

	//새로운 게임을 등록한다.
	@Override
	public void gameinsert(GameDTO dto) {
		sqlSession.insert("game.gameInsert",dto);
	}

	//조회수를 증가시킨다.
	public void increaseViewcnt(int gnum) throws Exception {
		sqlSession.update("game.increaseViewcnt", gnum);
	}

	//상세정보화면
	public GameDTO view(int gnum) {
		return sqlSession.selectOne("game.view", gnum);
	}

	//검색창 자동완성기능
	public List<GameDTO> getAutoGame(String input){
		return sqlSession.selectList("game.getAuto", input);
	}

	//이미지파일 경로명을 삽입한다.
	public void addAttach(String fullName, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("fullName",fullName);
		map.put("userid",userid);
		sqlSession.insert("game.addAttach", map);
	}

	//이미지파일 경로명을 삭제한다.
	public void delteFile(String fileName){
		sqlSession.delete("game.deleteFile", fileName);
	}

	//세부 카테고리별 목록의 갯수를 구한다. 페이징에 필요.
	public int countList(Map<String, Object> map){
		return sqlSession.selectOne("game.filteredListCount", map);
	}

	//세부 카테고리별 목록을 출력.
	public List<GameDTO> filteredGamelist(Map<String, Object> map) {
		List<GameDTO> list = new ArrayList<>();
		String sort = (String)map.get("sort");
		switch (sort){
			case "week":
				list = sqlSession.selectList("game.filteredList", map);
				break;
			case "month":
				list = sqlSession.selectList("game.filteredList_month", map);
				break;
			case "newbie":
				list = sqlSession.selectList("game.filteredList_newbie", map);
				break;
			case "vcnt":
				list = sqlSession.selectList("game.filteredList_vcnt", map);
				break;
			default:
				list = null;
		}
		return list;
	}

	//게임정보수정
	public void gameupdate(GameDTO dto){
		sqlSession.update("game.gameupdate", dto);
	}

	//확장게임의 정보를 삽입한다.(새 게임 등록시)
	public void insert_expansion(String expansion, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("expansion",expansion);
		map.put("userid",userid);
		sqlSession.insert("game.expansion_insert", map);
	}

	//재구현게임의 정보를 삽입한다.(새 게임 등록시)
	public void insert_reimplement(String reimplement, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("reimplement",reimplement);
		map.put("userid",userid);
		sqlSession.insert("game.reimplement_insert", map);
	}

	//확장게임의 정보를 삽입한다. (기존게임에 추가시)
	public void insert_expansion(int gnum, String expansion, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("expansion",expansion);
		map.put("userid",userid);
		sqlSession.insert("game.expansion_update", map);
	}

	//재구현게임의 정보를 삽입한다. (기존게임에 추가시)
	public void insert_reimplement(int gnum, String reimplement, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("reimplement",reimplement);
		map.put("userid",userid);
		sqlSession.insert("game.reimplement_update", map);
	}

	//게임정보에서 확장게임을 출력할때
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

	//게임정보에서 재구현게임을 출력할때
	public Map<String, Object> getReimplement(int gnum){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);

		//해당게임의 확장판 게임을 구하는 경우 (해당게임이 원본)
		map.put("strOn", "renum");
		map.put("strWhere","gnum");
		List<GameDTO> origin =sqlSession.selectList("game.getReimplement", map);

		//해당게임의 원본 게임을 구하는 경우 (해당게임이 재구현판)
		map.replace("strOn","gnum");
		map.replace("strWhere","renum");
		List<GameDTO> expansion = sqlSession.selectList("game.getReimplement", map);

		map.clear();

		map.put("origin", origin);
		map.put("reimplement",expansion);

		return map;
	}

	//게임을 삭제한다
	public void deleteGame(int gnum, String userid){
		Map<String, Object> map = new HashMap<>();
		map.put("gnum",gnum);
		map.put("userid",userid);

		sqlSession.update("game.delete", map);
	}

	//
	@Override
	public int countExRe(Map<String, Object> map) {
		return sqlSession.selectOne("game.countExRe", map);
	}

	public List<String> viewExpansion(int gnum){
		List<String> list = sqlSession.selectList("game.viewExpansion", gnum);
		return list;
	}

	public List<String> viewReimplement(int gnum){
		List<String> list = sqlSession.selectList("game.viewReimplement", gnum);
		return list;
	}

	//게임정보창의 확장재구현게임목록
	@Override
	public List<GameDTO> ExReList(Map<String, Object> map) {
		return sqlSession.selectList("game.getExReList", map);
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

	//메인페이지의 캐러셀에 들어가는 주간 랭킹
	@Override
	public List<GameDTO> weeklyList(Map<String, Object> map) {
		return sqlSession.selectList("game.weeklyList", map);
	}

	//메인페이지의 캐러셀에 들어가는 신규 게임
	@Override
	public List<GameDTO> newbieList(Map<String, Object> map) {
		return sqlSession.selectList("game.newbieList", map);
	}

	@Override
	public List<GameDTO> totalSearch(Map<String, Object> map) {
		return sqlSession.selectList("game.totalSearch", map);
	}

	@Override
	public int totalSearchCount(Map<String, Object> map) {
		return sqlSession.selectOne("game.totalSearchCount", map);
	}

	@Override
	public List<GameDTO> confirmList(Map<String, Object> map) {
		return sqlSession.selectList("game.confirmList", map);
	}

	@Override
	public int confirmListCount(String sort) {
		Map<String, Object> map = new HashMap<>();
		map.put("sort", sort);
		return sqlSession.selectOne("game.confirmListCount", map);
	}

	@Override
	public List<String> attachlist(int gnum) {
		return sqlSession.selectList("game.attachlist", gnum);
	}

	@Override
	public void denyGame(int gnum, String userid) {
		Map<String, Object> map = new HashMap<>();
		map.put("gnum", gnum);
		map.put("userid", userid);
		sqlSession.update("game.denyGame",map);
	}

	@Override
	public void gameAllow(GameDTO dto) {
		sqlSession.update("game.gameAllow", dto);
	}

	@Override
	public int game_list_themeCount(Map<String, Object> map) {
		return sqlSession.selectOne("game.game_list_themeCount", map);
	}

	@Override
	public List<GameDTO> game_list_theme(Map<String, Object> map) {
		return sqlSession.selectList("game.game_list_theme", map);
	}
}
