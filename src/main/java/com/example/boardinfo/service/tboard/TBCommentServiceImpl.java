package com.example.boardinfo.service.tboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBCommentDAO;
import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TBCommentServiceImpl implements TBCommentService {
	//로거
	private static final Logger logger
			= LoggerFactory.getLogger(TBCommentServiceImpl.class);
	@Inject
	TBCommentDAO tbcommentDao;

	@Inject
	TBoardDAO tboardDao;
	
	@Override
	public List<TBCommentDTO> getCommentList(int tb_num) {
		return tbcommentDao.getReplyList(tb_num);
	}
	@Override
	public int getCommentCount(int tb_num) {
		return tbcommentDao.getReplyCount(tb_num);
	}

	@Override
	@Transactional
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

			//댓글개수 증가 처리
			int tb_num = re_dto.getTb_num();
			tboardDao.increaseRecnt(tb_num);
		}
		return result;
	}

	@Override
	public String getReplyContent(int reply_reg_num) {
		return tbcommentDao.getReplyContent(reply_reg_num);
	}

	@Override
	public boolean editReply(TBCommentDTO re_dto) {
		boolean result = false;
		int editted = tbcommentDao.editReply(re_dto);
		logger.info("에디티드 : "+ editted);
		if(editted >= 1){
			result = true;
		}
		return result;
	}

	@Override
	public boolean deleteReply(int reply_reg_num, String update_user) {
		boolean result = false;

		Map<String, Object> map = new HashMap<>();
		map.put("reply_reg_num", reply_reg_num);
		map.put("update_user", update_user);
		int deletted = tbcommentDao.deleteReply(map);
		if(deletted >=1 ){
			result = true;
		}
		return result;
	}


}
