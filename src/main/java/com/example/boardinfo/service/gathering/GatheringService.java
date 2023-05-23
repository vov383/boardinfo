package com.example.boardinfo.service.gathering;

import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;

public interface GatheringService {
	
	public boolean addPost(GatheringDTO dto);
	public boolean deletePost();
	public boolean editPost();
	public List<GatheringDTO> list();


}
