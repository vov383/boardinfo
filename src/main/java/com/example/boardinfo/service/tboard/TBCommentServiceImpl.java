package com.example.boardinfo.service.tboard;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBCommentDAO;
import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

@Service
public class TBCommentServiceImpl implements TBCommentService {
	//로거
	private static final Logger logger
			= LoggerFactory.getLogger(TBCommentServiceImpl.class);
	@Inject
	TBCommentDAO tbcommentDao;
	
	@Override
	public List<TBCommentDTO> getCommentList(int tb_num) {
		return tbcommentDao.getReplyList(tb_num);
	}
	@Override
	public int getCommentCount(int tb_num) {
		return tbcommentDao.getReplyCount(tb_num);
	}

	@Override
	public boolean insertReply(TBCommentDTO re_dto) {

		boolean result = false;

		//대댓글이 아닌 일반 댓글인 경우
		if(re_dto.getMother_reply()==null) {
			re_dto.setDepth(0);
			int target = tbcommentDao.getTargetReplyOrder(re_dto);
			re_dto.setInner_order(target);
			logger.info("target 값 : "+target);
		}

		//대댓글인 경우
		else{
			TBCommentDTO mother = tbcommentDao.getMotherObject(re_dto.getMother_reply());
			logger.info("mother : "+mother);
			re_dto.setDepth(mother.getDepth()+1);
			re_dto.setParent_reply(mother.getParent_reply());
			int target = tbcommentDao.getTargetReplyOrder(mother);
			re_dto.setInner_order(target);
			logger.info("target : "+target);
			tbcommentDao.replyOrderUpdate(re_dto.getParent_reply(), re_dto.getInner_order());
		}

		if(tbcommentDao.insertReply(re_dto) >= 1) {
			result = true;
		}
		return result;
	}

	@Override
	public void updateComment(int reply_reg_num, String content, String update_user) {
		tbcommentDao.updateComment(reply_reg_num, content, update_user);
	}

	@Override
	public void deleteComment(int reply_reg_num, String update_user) {
		tbcommentDao.deleteComment(reply_reg_num, update_user);
	}


}
