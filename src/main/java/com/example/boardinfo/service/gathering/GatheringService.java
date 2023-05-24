package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;

public interface GatheringService {
	
	public boolean addPost(GatheringDTO dto);
	public boolean deletePost();
	public boolean editPost();
	public GatheringDTO view(int gathering_id, boolean updateViewCount);
	List<GatheringDTO> list(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to);
}
