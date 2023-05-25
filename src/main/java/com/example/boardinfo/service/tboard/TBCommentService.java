package com.example.boardinfo.service.tboard;

import java.util.HashMap;
import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

public interface TBCommentService {
	public List<TBCommentDTO> getCommentList(int tb_num);
	public int getCommentCount(int tb_num);
	public void insertComment(TBCommentDTO re_dto);
	public void insertChilComment(TBCommentDTO re_dto);
	
	public void updateComment(int reply_reg_num, String content);
	public void deleteComment(int reply_reg_num);

    TBCommentDTO getCommentObject(int replyRegNum);
}
