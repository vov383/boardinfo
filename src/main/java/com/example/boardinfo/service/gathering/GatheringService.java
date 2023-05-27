package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;

public interface GatheringService {
	
<<<<<<< HEAD
	boolean addPost(GatheringDTO dto);
	boolean deletePost();
	boolean editPost();
	GatheringDTO view(int gathering_id, boolean updateViewCount);
	List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end);
	boolean addReply(GatheringReplyDTO dto);
=======
	public boolean addPost(GatheringDTO dto);
	public boolean deletePost();
	public boolean editPost();
	public GatheringDTO view(int gathering_id, boolean updateViewCount);
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword);
	public boolean addReply(GatheringReplyDTO dto);
>>>>>>> branch '한수진' of https://github.com/Suzzh/board-info-1.git

	List<GatheringReplyDTO> getReplies(int gatheringId);

<<<<<<< HEAD
    int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);
=======
    public int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);

	public boolean update(GatheringDTO dto);
>>>>>>> branch '한수진' of https://github.com/Suzzh/board-info-1.git
}
