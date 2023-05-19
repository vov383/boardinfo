package com.example.boardinfo.model.tboard.dao;

import java.util.List;

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
	public void insertChilComment(TBCommentDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateComment(TBCommentDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteComment(int reply_reg_num) {
		// TODO Auto-generated method stub

	}

}
