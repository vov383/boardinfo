package com.example.boardinfo.service.tboard;

import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

public interface TBCommentService {
	List<TBCommentDTO> getCommentList(int tb_num);
	int getCommentCount(int tb_num);
	boolean insertReply(TBCommentDTO re_dto);

    String getReplyContent(int replyRegNum);

	boolean editReply(TBCommentDTO re_dto);

	boolean deleteReply(int reply_reg_num, String update_user);
}
