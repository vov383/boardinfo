package com.example.boardinfo.model.tboard.dao;

import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

public interface TBCommentDAO {
	List<TBCommentDTO> getCommentList(int tb_num);
	int getCommentCount(int tb_num);
	void insertComment(TBCommentDTO re_dto);
	void insertChilComment(TBCommentDTO re_dto);

	void insertChildComment(TBCommentDTO re_dto);

	void updateComment(int reply_reg_num, String content, String update_user);
	void deleteComment(int reply_reg_num);

    void deleteComment(int reply_reg_num, String update_user);

    TBCommentDTO getCommentObject(int replyRegNum);
}
