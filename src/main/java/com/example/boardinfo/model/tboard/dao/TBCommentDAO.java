package com.example.boardinfo.model.tboard.dao;

import java.util.List;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

public interface TBCommentDAO {
	public List<TBCommentDTO> getCommentList(int tb_num);
	public int getCommentCount(int tb_num);
	public void insertComment(TBCommentDTO re_dto);
	public void insertChilComment(TBCommentDTO dto);
	
	public void updateComment(TBCommentDTO dto);
	public void deleteComment(int reply_reg_num);
}
