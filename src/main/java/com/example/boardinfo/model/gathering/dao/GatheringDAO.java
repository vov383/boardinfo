package com.example.boardinfo.model.gathering.dao;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringDAO {
	int addPost(GatheringDTO dto);
	int deletePost();
	int editPost();
	List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end);
	GatheringDTO view(int gathering_id);
	void updateViewCount(int gathering_id);
	void replyOrderUpdate(int parent_reply, int inner_order);
	int addReply(GatheringReplyDTO dto);
	List<GatheringReplyDTO> getReplies(int gatheringId);
	int getTargetReplyOrder(GatheringReplyDTO dto);
	GatheringReplyDTO getReply(Integer motherReply);

    int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);
}
