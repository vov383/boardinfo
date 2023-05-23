package com.example.boardinfo.model.gathering.dao;

import java.util.List;

import com.example.boardinfo.model.gathering.dto.GatheringDTO;

public interface GatheringDAO {
	public int addPost(GatheringDTO dto);
	public int deletePost();
	public int editPost();
	public List<GatheringDTO> list();
	public GatheringDTO view(int gathering_id);
	public void updateViewCount(int gathering_id);

}
