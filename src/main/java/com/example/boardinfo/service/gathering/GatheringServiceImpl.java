package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.inject.Inject;

import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import org.springframework.transaction.annotation.Transactional;


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
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, int start, int end) {
		List<GatheringDTO> list = 
				gatheringDao.list(showAvailable, address1List, from, to, start, end);
		
		for (GatheringDTO dto : list) {
			
			//제주특별시, 세종특별시 두글자 처리
			dto.setAddress1(dto.getAddress1().substring(0, 2));
			
			//광역시가 아닌 경우 구까지는 안나오게 처리
			if(dto.getAddress2()!=null && !dto.getAddress2().equals("")) {
				String address2 = dto.getAddress2() + " ";
				int num = address2.indexOf(" ", 3);
				address2 = address2.substring(0, num);
				dto.setAddress2(address2);
			}
			
			//status 세팅
			LocalDate now = LocalDate.now();
			LocalDate gathering_date = dto.getGathering_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			if(now.isAfter(gathering_date)) {
				dto.setStatus("모임종료");
			}
			
			else dto.setStatus("모집중");
		}
		
		return list;
	}

	@Override
	public GatheringDTO view(int gathering_id, boolean updateViewCount) {
		
		
		if(updateViewCount) {
			gatheringDao.updateViewCount(gathering_id);
		}
			GatheringDTO dto = gatheringDao.view(gathering_id);
		
		//status 세팅
		LocalDate now = LocalDate.now();
		LocalDate gathering_date = dto.getGathering_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		if(now.isAfter(gathering_date)) {
			dto.setStatus("모임종료");
		}
		
		else dto.setStatus("모집중");
		
		return dto;
		
	}


	@Transactional
	@Override
	public boolean addReply(GatheringReplyDTO dto) {

		boolean result = false;

		//대댓글이 아닌 일반 댓글인 경우
		if(dto.getMother_reply()==null){
			dto.setDepth(0);
			int target = gatheringDao.getTargetReplyOrder(dto);
			dto.setInner_order(target);
		}

		//대댓글인 경우
		else{
			GatheringReplyDTO mother = gatheringDao.getReply(dto.getMother_reply());
			System.out.println("mother : " + mother);
			dto.setDepth(mother.getDepth()+1);
			dto.setParent_reply(mother.getParent_reply());
			int target = gatheringDao.getTargetReplyOrder(mother);
			dto.setInner_order(target);
			System.out.println("target : " + target);
			gatheringDao.replyOrderUpdate(dto.getParent_reply(), dto.getInner_order());
		}

		if(gatheringDao.addReply(dto) >= 1) result = true;
		return result;
	}

	@Override
	public List<GatheringReplyDTO> getReplies(int gatheringId) {
		return gatheringDao.getReplies(gatheringId);
	}

	@Override
	public int countList(boolean showAvailable, String[] address1List, LocalDate from, LocalDate to) {
		return gatheringDao.countList(showAvailable, address1List, from, to);
	}
}
