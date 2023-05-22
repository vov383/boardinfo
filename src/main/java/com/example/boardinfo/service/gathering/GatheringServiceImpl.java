package com.example.boardinfo.service.gathering;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;


@Service
public class GatheringServiceImpl implements GatheringService {
	
	@Inject GatheringDAO gatheringDao;
	

	@Override
	public boolean addPost(GatheringDTO dto) {
		int num = gatheringDao.addPost(dto);
		boolean addCheck = false;
		if(num == 1) addCheck = true; 
		return addCheck;
	}

	@Override
	public boolean deletePost() {
		return false;
	}

	@Override
	public boolean editPost() {
		return false;
	}

	@Override
	public List<GatheringDTO> list() {
		return null;
	}

}
