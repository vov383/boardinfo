package com.example.boardinfo.model.tboard.dao;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

import java.util.List;
import java.util.Map;

public interface TBCommentDAO {
	List<TBCommentDTO> getReplyList(int tb_num);
	int getReplyCount(int tb_num);
	int insertReply(TBCommentDTO re_dto);

	TBCommentDTO getMotherObject(Integer mother_reply);

	int getTargetReplyOrder(TBCommentDTO re_dto);

	void replyOrderUpdate(int parent_reply, int innerOrder);

	String getReplyContent(int replyRegNum);

	int editReply(TBCommentDTO re_dto);

	int deleteReply(Map<String, Object> map);


}
