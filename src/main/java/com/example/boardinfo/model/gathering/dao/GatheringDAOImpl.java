package com.example.boardinfo.model.gathering.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;


@Repository
public class GatheringDAOImpl implements GatheringDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int addPost(GatheringDTO dto) {
		return sqlSession.insert("gathering.addPost",dto);
	}

	@Override
	public int deletePost() {
		return 0;
	}

	@Override
	public int editPost() {
		return 0;
	}

	@Override
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List) {

		Map<String, Object> map = new HashMap<>();
		map.put("showAvailable", showAvailable);
		map.put("address1List", address1List);
		return sqlSession.selectList("gathering.list", map);
	}

	@Override
	public GatheringDTO view(int gathering_id) {
		return sqlSession.selectOne("gathering.view", gathering_id);
	}

	@Override
	public void updateViewCount(int gathering_id) {
		sqlSession.update("gathering.viewCount", gathering_id);
	}
	
	
	
	

}
