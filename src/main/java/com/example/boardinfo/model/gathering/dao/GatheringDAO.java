package com.example.boardinfo.model.gathering.dao;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringDAO {
<<<<<<< HEAD
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
=======
	public int addPost(GatheringDTO dto);
	public int deletePost();
	public int editPost();
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, int start, int end, String option, String keyword);
	public GatheringDTO view(int gathering_id);
	public void updateViewCount(int gathering_id);
	public void replyOrderUpdate(int parent_reply, int inner_order);
	public int addReply(GatheringReplyDTO dto);
	public List<GatheringReplyDTO> getReplies(int gatheringId);
	public int getTargetReplyOrder(GatheringReplyDTO dto);
	public GatheringReplyDTO getReply(Integer motherReply);
>>>>>>> branch '한수진' of https://github.com/Suzzh/board-info-1.git

<<<<<<< HEAD
    int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);
=======
    public int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);

	public int update(GatheringDTO dto);
>>>>>>> branch '한수진' of https://github.com/Suzzh/board-info-1.git
}
