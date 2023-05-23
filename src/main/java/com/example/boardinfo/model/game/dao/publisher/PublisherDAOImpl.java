package com.example.boardinfo.model.game.dao.publisher;

import javax.inject.Inject;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

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
		List<PublisherDTO> list = sqlSession.selectList("publisher.getAuto", input);
		System.out.println(list);
		return list;
	}
}
