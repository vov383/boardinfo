package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface TBCommentService {
	List<TBCommentDTO> getCommentList(String tb_num);
	boolean insertReply(TBCommentDTO re_dto);

	TBCommentDTO getReplyContent(int replyRegNum, HttpSession session);

	boolean editReply(TBCommentDTO re_dto);

	boolean deleteReply(int reply_reg_num, String update_user);
}
