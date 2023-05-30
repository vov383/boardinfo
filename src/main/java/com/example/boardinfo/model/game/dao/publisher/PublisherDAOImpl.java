package com.example.boardinfo.model.game.dao.publisher;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class PublisherDAOImpl implements PublisherDAO {
	@Inject
	SqlSession sqlSession;
	
	@Override
	public int check_publisher(String publisher) {
		int result = sqlSession.selectOne("publisher.check", publisher);
		return result;
	}
	
	@Override
	public void insert_publisher(String publisher) {
		sqlSession.insert("publisher.insert", publisher);
	}
	
	@Override
	public void insert_publisher_mapping() {
		sqlSession.insert("publisher.insertmapping");
	}
	
	@Override
	public int publishernum(String publisher) {
		return sqlSession.selectOne("publisher.publisher_num", publisher);
	}
	
	@Override
	public void insert_publisher_mapping(int pnum) {
		sqlSession.insert("publisher.insertmapping_pnum",pnum);
	}

	public List<PublisherDTO> getAutoPublisher(String input){
		return sqlSession.selectList("publisher.getAuto", input);
	}

	public List<PublisherDTO> view(int gnum) { return sqlSession.selectList("publisher.view", gnum); }
}
