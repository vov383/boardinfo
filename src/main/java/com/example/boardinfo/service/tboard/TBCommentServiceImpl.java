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
	public void insertChilComment(TBCommentDTO re_dto) {

	}

	@Override
	public void insertChildComment(TBCommentDTO re_dto) {
		tbcommentDao.insertChildComment(re_dto);
	}

	@Override
	public void updateComment(int reply_reg_num, String content, String update_user) {
		tbcommentDao.updateComment(reply_reg_num, content, update_user);
	}

	@Override
	public void deleteComment(int reply_reg_num, String update_user) {
		tbcommentDao.deleteComment(reply_reg_num, update_user);
	}

	@Override
	public TBCommentDTO getCommentObject(int reply_reg_num) {
		return tbcommentDao.getCommentObject(reply_reg_num);
	}

}
