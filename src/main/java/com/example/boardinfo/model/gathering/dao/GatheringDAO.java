package com.example.boardinfo.model.gathering.dao;

import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

import java.time.LocalDate;
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
	public List<GatheringReplyDTO> getReplies(int gatheringId);
	public int getTargetReplyOrder(GatheringReplyDTO dto);
	public GatheringReplyDTO getReply(Integer motherReply);

    int countList(boolean showAvailable, String[] address1List,
                  LocalDate from, LocalDate to,
                  String option, String keyword);

    public int update(GatheringDTO dto);
	public int addAttendee(AttendeeDTO dto);
	public AttendeeType checkIfAttendee(int gatheringId, String userId);
	public GatheringDTO getAttendInfo(int gatheringId);
    public int withdrawAttendee(int gatheringId, String userId);
	public Map<String, String> getWriterAndShow(int gathering_id);
	public int cancelApplication(int gatheringId, String userId);
	public List<Map<String, String>> getIdAndNicknames(int gathering_id);
	public void finishChat();
    public List<Integer> finishList();

    List<GatheringDTO> getGaListByUserid(String userid);
}
