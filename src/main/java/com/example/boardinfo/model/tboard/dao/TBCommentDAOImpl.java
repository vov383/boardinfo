package com.example.boardinfo.model.tboard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

@Repository
public class TBCommentDAOImpl implements TBCommentDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<TBCommentDTO> getCommentList(int tb_num) {
		return sqlSession.selectList("tbComment.getCommentList", tb_num);
	}

	@Override
	public int getCommentCount(int tb_num) {
		return sqlSession.selectOne("tbComment.commentCount", tb_num);
	}
	
	@Override
	public void insertComment(TBCommentDTO re_dto) {
		sqlSession.insert("tbComment.insertComment", re_dto);
	}

	@Override
	public void insertChilComment(TBCommentDTO re_dto) {

	}

	@Override
	public void insertChildComment(TBCommentDTO re_dto) {
		sqlSession.insert("tbComment.insertChildComment", re_dto);
	}

	@Override
	public void updateComment(int reply_reg_num, String content, String update_user) {
		Map<String, Object> map = new HashMap<>();
		map.put("reply_reg_num", reply_reg_num);
		map.put("content", content);
		map.put("update_user", update_user);
		sqlSession.update("tbComment.updateComment", map);
	}

	@Override
	public void deleteComment(int reply_reg_num) {

	}

	@Override
	public void deleteComment(int reply_reg_num, String update_user) {
		Map<String, Object> map = new HashMap<>();
		map.put("reply_reg_num", reply_reg_num);
		map.put("update_user", update_user);
		sqlSession.delete("tbComment.deleteComment", reply_reg_num);

	}

	@Override
	public TBCommentDTO getCommentObject(int reply_reg_num) {
		return sqlSession.selectOne("tbComment.getComment", reply_reg_num);
	}

}
