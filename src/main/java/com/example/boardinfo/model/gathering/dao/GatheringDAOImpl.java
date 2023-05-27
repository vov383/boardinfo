package com.example.boardinfo.model.gathering.dao;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
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
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List,
								   LocalDate from, LocalDate to,
								   int start, int end, String option, String keyword) {

		Map<String, Object> map = new HashMap<>();
		map.put("showAvailable", showAvailable);
		map.put("address1List", address1List);
		map.put("from", from);
		map.put("to", to);
		map.put("start", start);
		map.put("end", end);
		map.put("option", option);
		map.put("keyword", keyword);
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

	@Override
	public void replyOrderUpdate(int parent_reply, int inner_order) {
		Map<String, Integer> map = new HashMap<>();
		map.put("parent_reply", parent_reply);
		map.put("inner_order", inner_order);
		System.out.println(sqlSession.update("gathering.replyOrderUpdate", map));
	}

	@Override
	public int addReply(GatheringReplyDTO dto) {
		System.out.print(dto);
		int result = sqlSession.insert("gathering.addReply", dto);
		return result;
	}

	@Override
	public List<GatheringReplyDTO> getReplies(int gathering_id) {
		System.out.println("gathering_id" + gathering_id);
		return sqlSession.selectList("gathering.getReplies", gathering_id);
	}

	@Override
	public GatheringReplyDTO getReply(Integer mother_reply) {
		return sqlSession.selectOne("gathering.getReply", mother_reply);
	}

	@Override
	public int getTargetReplyOrder(GatheringReplyDTO dto) {
		int target = 0;

		if(dto.getParent_reply()==null){
			int gathering_id = dto.getGathering_id();
			target = sqlSession.selectOne("gathering.getLast", gathering_id);
		}

		else{
			target = sqlSession.selectOne("gathering.getTargetReplyOrder", dto);
		}

		return target;
	}

	@Override
	public int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to) {
		Map<String, Object> map = new HashMap<>();
		map.put("showAvailable", showAvailable);
		map.put("address1List", address1List);
		map.put("from", from);
		map.put("to", to);
		return sqlSession.selectOne("gathering.countList", map);
	}

	@Override
	public int update(GatheringDTO dto) {
		return sqlSession.update("gathering.update", dto);
	}
}
