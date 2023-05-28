package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringService {
	

	public boolean addPost(GatheringDTO dto);
	public boolean deletePost();
	public boolean editPost();
	public GatheringDTO view(int gathering_id, boolean updateViewCount);
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword);
	public boolean addReply(GatheringReplyDTO dto);


	List<GatheringReplyDTO> getReplies(int gatheringId);


    public int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);

	public boolean update(GatheringDTO dto);

}
