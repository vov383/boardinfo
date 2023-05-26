package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringService {
	
	boolean addPost(GatheringDTO dto);
	boolean deletePost();
	boolean editPost();
	GatheringDTO view(int gathering_id, boolean updateViewCount);
	List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end);
	boolean addReply(GatheringReplyDTO dto);

	List<GatheringReplyDTO> getReplies(int gatheringId);

    int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);
}
