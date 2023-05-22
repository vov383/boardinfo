package com.example.boardinfo.model.game.dao.artist;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;

@Repository
public class ArtistDAOImpl implements ArtistDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int check_artist(String artist) {
		int result = sqlSession.selectOne("artist.check", artist);
		return result;
	}
	
	@Override
	public void insert_artist(String artist) {
		sqlSession.insert("artist.insert", artist);
	}
	
	@Override
	public void insert_artist_mapping() {
		sqlSession.insert("artist.insertmapping");
	}
	
	@Override
	public int artistnum(String artist) {
		return sqlSession.selectOne("artist.artist_num", artist);
	}
	
	@Override
	public void insert_artist_mapping(int anum) {
		sqlSession.insert("artist.insertmapping_anum",anum);
	}
	
	public List<String> getAuto(String input){
	    return sqlSession.selectList("artist.getAuto", input);
	}
	
}
