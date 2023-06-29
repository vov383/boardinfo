package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

public interface GatheringService {
	

	public int addPost(GatheringDTO dto, HttpSession session);
	public GatheringDTO simpleView(int gathering_id);
	public GatheringDTO getGatheringDetails(int gathering_id);

	@Transactional
	String deletePost(int gathering_id, String user_id, HttpSession session);

	public List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword);



	public boolean addReply(GatheringReplyDTO dto);
	public List<GatheringReplyDTO> getReplies(int gatheringId);

	public int countList(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, String searchOption, String keyword);
	public boolean update(GatheringDTO dto);
	public AttendeeType checkIfAttendee(int gathering_id, String user_id);
	abstract String addAttendee(int gathering_id, String user_id, String answer, HttpSession session);

	public String withDrawAttendee(int gathering_id, String user_id, HttpSession session);
    public String cancelApplication(int gathering_id, String user_id);
    public List<GatheringDTO> getHomeList(Integer size);
    public String getReplyWriter(int reply_id);
	public int updateReply(GatheringReplyDTO dto);
	public int deleteReply(GatheringReplyDTO dto);
    public List<AttendeeDTO> getAttendeeList(Integer gathering_id);


}
