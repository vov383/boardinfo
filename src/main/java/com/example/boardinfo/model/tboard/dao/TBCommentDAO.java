package com.example.boardinfo.model.tboard.dao;

import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

public interface TBCommentDAO {
	List<TBCommentDTO> getReplyList(int tb_num);
	int getReplyCount(int tb_num);
	int insertReply(TBCommentDTO re_dto);

	//대댓글 넣으면 문제가 여기서 발생하고 댓글달기 실패 뜸...
	TBCommentDTO getMotherObject(Integer mother_reply);

	void updateComment(int reply_reg_num, String content, String update_user);

    void deleteComment(int reply_reg_num, String update_user);


	int getTargetReplyOrder(TBCommentDTO re_dto);

	void replyOrderUpdate(int parent_reply, int innerOrder);
}
