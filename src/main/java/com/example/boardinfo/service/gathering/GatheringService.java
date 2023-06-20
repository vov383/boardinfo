package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringService {
	

	public int addPost(GatheringDTO dto);
	public String deletePost(int gathering_id, String user_id);
	public GatheringDTO view(int gathering_id, boolean updateViewCount);
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword);
	public boolean addReply(GatheringReplyDTO dto);
	public List<GatheringReplyDTO> getReplies(int gatheringId);

	public int countList(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, String searchOption, String keyword);

	public boolean update(GatheringDTO dto);
	public AttendeeType checkIfAttendee(int gathering_id, String userId);
	public String addAttendee(int gatheringId, String userId, String answer);
	public String withDrawAttendee(int gatheringId, String userId);
    public String cancelApplication(int gatheringId, String userId);
    public List<GatheringDTO> getHomeList(Integer size);
    public String getReplyWriter(int reply_id);
	public int updateReply(GatheringReplyDTO dto);
	public int deleteReply(GatheringReplyDTO dto);
}
