package com.example.boardinfo.model.gathering.dao;

import com.example.boardinfo.model.gathering.dto.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface GatheringDAO {

	public int addPost(GatheringDTO dto);
	public int deletePost(int gathering_id);
	public int editPost();
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, int start, int end, String option, String keyword);
	public GatheringDTO view(int gathering_id);
	public void updateViewCount(int gathering_id);
	public void replyOrderUpdate(int parent_reply, int inner_order);
	public int addReply(GatheringReplyDTO dto);
	public List<GatheringReplyDTO> getReplies(int gathering_id);
	public int getTargetReplyOrder(GatheringReplyDTO dto);
	public GatheringReplyDTO getReply(Integer motherReply);

    public int countList(boolean showAvailable, String[] address1List,
                  LocalDate from, LocalDate to,
                  String option, String keyword);

    public int update(GatheringDTO dto);
	public int addAttendee(AttendeeDTO dto);
	public AttendeeType checkIfAttendee(int gathering_id, String user_id);
	public GatheringDTO getAttendInfo(int gathering_id);
    public int withdrawAttendee(int gatheringId, String user_id);
	public int cancelApplication(int gathering_id, String user_id);
	public List<Map<String, String>> getIdAndNicknames(int gathering_id);
	public void finishChat();
    public List<Integer> finishList();
	public List<GatheringDTO> getHomeList(Integer size);
    public String getReplyWriter(int reply_id);
	public int updateReply(GatheringReplyDTO dto);
	public int deleteReply(GatheringReplyDTO dto);
	public List<ChatRoomDTO> getAttendingGatheringList(String user_id);
	public ChatRoomDTO getAttendingChatroom(String user_id, int gathering_id);
	public List<Integer> getMyActiveChats(String user_id);
	public void updateLastVisit(int gatheringId, String user_id, LocalDateTime date);
	public List<String> leaveAll(int gathering_id);
	public List<AttendeeDTO> getAttendeeInfoList(int gathering_id);
	public List<AttendeeDTO> getWaitingInfoList(int gathering_id);
	public List<GatheringDTO> totalSearch(Map<String, Object> map);
	public int totalSearchCount(Map<String, Object> map);
    public List<ChatRoomDTO> getMyLastVisit(String user_id);
	public int acceptApply(int gathering_id, int attendee_id);
	public AttendeeDTO getAttendeeInfo(int attendee_id);
    public String getWriter(int gatheringId);
	public int throwAttendee(int attendee_id, int gathering_id);
    public int rejectApply(int gathering_id, int attendee_id);

}
