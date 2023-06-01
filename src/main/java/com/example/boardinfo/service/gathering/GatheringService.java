package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringService {
	

	public int addPost(GatheringDTO dto);
	public boolean deletePost();
	public GatheringDTO view(int gathering_id, boolean updateViewCount);
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword);
	public boolean addReply(GatheringReplyDTO dto);

	List<GatheringReplyDTO> getReplies(int gatheringId);

    int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);

	public boolean update(GatheringDTO dto);
	public AttendeeType checkIfAttendee(int gathering_id, String userId);

	public String addAttendee(int gatheringId, String userId);
}
