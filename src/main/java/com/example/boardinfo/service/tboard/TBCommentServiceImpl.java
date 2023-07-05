package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dao.TBCommentDAO;
import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@Transactional
	public boolean insertReply(TBCommentDTO re_dto) {

		boolean result = false;

		//대댓글이 아닌 일반 댓글인 경우
		if (re_dto.getMother_reply() == null) {
			re_dto.setDepth(0);
			int target = tbcommentDao.getTargetReplyOrder(re_dto);
			re_dto.setInner_order(target);
		}

		//대댓글인 경우
		else {
			TBCommentDTO mother = tbcommentDao.getMotherObject(re_dto.getMother_reply());
			re_dto.setDepth(mother.getDepth() + 1);
			re_dto.setParent_reply(mother.getParent_reply());
			int target = tbcommentDao.getTargetReplyOrder(mother);
			re_dto.setInner_order(target);
			tbcommentDao.replyOrderUpdate(re_dto.getParent_reply(), re_dto.getInner_order());
		}
		/*댓글 insert*/
		int num = tbcommentDao.insertReply(re_dto); /*댓글 삽입하면 1, 실패하면 0*/
		if(num==1){
			result = true;/*1이면 result를 true로 아니면 그냥 return*/
		}
		return result;
	}

	@Override
	public TBCommentDTO getReplyContent(int reply_reg_num, HttpSession session) {
		boolean result = false;
		TBCommentDTO re_dto = tbcommentDao.getReplyContent(reply_reg_num);
		String userid = (String)session.getAttribute("userid");

		/*세션 유저아이디와 댓글 create_user가 같으면 result를 true로 */
		if(userid != null && userid.equals(re_dto.getCreate_user())){
			result = true;
		}
		if(result){
			return re_dto;
		}else{
			return null;
		}

	}

	@Override
	public boolean editReply(TBCommentDTO re_dto) {
		boolean result = false;
		int editted = tbcommentDao.editReply(re_dto);
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
