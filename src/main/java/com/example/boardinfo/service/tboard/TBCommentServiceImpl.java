package com.example.boardinfo.service.tboard;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBCommentDAO;
import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

@Service
public class TBCommentServiceImpl implements TBCommentService {
	
	@Inject
	TBCommentDAO tbcommentDao;
	
	@Override
	public List<TBCommentDTO> getCommentList(int tb_num) {
		return tbcommentDao.getCommentList(tb_num);
	}
	@Override
	public int getCommentCount(int tb_num) {
		return tbcommentDao.getCommentCount(tb_num);
	}

	@Override
	public void insertComment(TBCommentDTO re_dto) {
		tbcommentDao.insertComment(re_dto);
	}

	@Override
	public void insertChilComment(TBCommentDTO dto) {

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
