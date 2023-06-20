package com.example.boardinfo.model.gathering.dao;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
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
		sqlSession.insert("gathering.addPost",dto);
		return dto.getGathering_id();
	}

	@Override
	public int deletePost(int gathering_id) {
		return sqlSession.update("gathering.deletePost", gathering_id);
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
	public int countList(boolean showAvailable, String[] address1List,
						 LocalDate from, LocalDate to,
						 String option, String keyword) {

		Map<String, Object> map = new HashMap<>();
		map.put("showAvailable", showAvailable);
		map.put("address1List", address1List);
		map.put("from", from);
		map.put("to", to);
		map.put("option", option);
		map.put("keyword", keyword);
		return sqlSession.selectOne("gathering.countList", map);
	}

	@Override
	public int update(GatheringDTO dto) {
		return sqlSession.update("gathering.update", dto);
	}

	@Override
	public int addAttendee(AttendeeDTO dto) {
		return sqlSession.insert("gathering.attend", dto);
	}

	@Override
	public AttendeeType checkIfAttendee(int gathering_id, String user_id) {
		Map<String, Object> map = new HashMap();
		map.put("gathering_id", gathering_id);
		map.put("user_id", user_id);
		AttendeeType type = sqlSession.selectOne("gathering.checkIfAttendee", map);
		return type;
	}

	@Override
	public GatheringDTO getAttendInfo(int gathering_id) {
		return sqlSession.selectOne("gathering.getAttendInfo", gathering_id);
	}

	@Override
	public int withdrawAttendee(int gathering_id, String user_id) {
		Map<String, Object> map = new HashMap();
		map.put("gathering_id", gathering_id);
		map.put("user_id", user_id);
		return sqlSession.update("gathering.withdraw", map);
	}

	@Override
	public Map<String, String> getWriterAndShow(int gathering_id) {
		return sqlSession.selectOne("gathering.getWriterAndShow", gathering_id);
	}

	@Override
	public int cancelApplication(int gathering_id, String user_id) {
		Map<String, Object> map = new HashMap();
		map.put("gathering_id", gathering_id);
		map.put("user_id", user_id);
		return sqlSession.delete("gathering.cancelApplication", map);
	}

	@Override
	public List<Map<String, String>> getIdAndNicknames(int gathering_id) {
		return sqlSession.selectList("gathering.getIdAndNicknames", gathering_id);
	}

	@Override
	public void finishChat() {
		sqlSession.update("gathering.finishChat");
	}

	@Override
	public List<Integer> finishList() {
		return sqlSession.selectList("gathering.finishList");
	}
}
