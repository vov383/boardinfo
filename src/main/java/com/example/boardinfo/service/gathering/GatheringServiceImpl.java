package com.example.boardinfo.service.gathering;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.*;


import javax.inject.Inject;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.member.dao.MemberDAO;
import com.example.boardinfo.service.game.GameServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import org.springframework.transaction.annotation.Transactional;


@Service
public class GatheringServiceImpl implements GatheringService {
	private static final Logger logger=
			LoggerFactory.getLogger(GatheringServiceImpl.class);
	@Inject
	GatheringDAO gatheringDao;

	@Inject
	ChatMessageDAO chatMessageDAO;

	@Autowired
	ApplicationEventPublisher eventPublisher;

	@Inject
	MemberDAO memberDAO;


	@Transactional
	@Override
	public int addPost(GatheringDTO dto) {
		int new_gathering_id = gatheringDao.addPost(dto);
		gatheringDao.addAttendee(new AttendeeDTO(dto.getWriter_id(), new_gathering_id, AttendeeType.ATTENDING));

		ChatMessageDTO notice = new ChatMessageDTO();
		notice.setGathering_id(new_gathering_id);
		notice.setUserId(dto.getWriter_id());
		notice.setType(ChatMessageDTO.MessageType.ATTEND);
		eventPublisher.publishEvent(notice);

		return new_gathering_id;
	}

	@Override
	public String deletePost(int gathering_id, String user_id) {
		String message;

		//일단 이 사람이 글쓴이인지 확인
		Map<String, String> map = gatheringDao.getWriterAndShow(gathering_id);
		if (map.get("WRITER_ID").equals(user_id)) {
			int num = gatheringDao.deletePost(gathering_id);

			//참가자 전원 leave로 바꿔버리고 apply는 삭제해버릴까? 고민좀 해보자
			if (num >=1) message = "게시물이 정상적으로 삭제되었습니다.";
			else message = "요청한 작업 처리 중 에러가 발생하였습니다.";
		}
		else message = "잘못된 요청입니다.";

		return message;
	}


	@Override
	public List<GatheringDTO> list(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, int start, int end, String searchOption, String keyword) {

		List<GatheringDTO> list =
				gatheringDao.list(showAvailable, address1List, from, to, start, end, searchOption, keyword);

		for (GatheringDTO dto : list) {

			//제주특별시, 세종특별시 두글자 처리
			dto.setAddress1(dto.getAddress1().substring(0, 2));

			//광역시가 아닌 경우 구까지는 안나오게 처리
			if (dto.getAddress2() != null && !dto.getAddress2().equals("")) {
				String address2 = dto.getAddress2() + " ";
				int num = address2.indexOf(" ", 3);
				address2 = address2.substring(0, num);
				dto.setAddress2(address2);
			}

			//status 세팅
			LocalDateTime now = LocalDateTime.now();
			LocalDateTime gathering_date = dto.getGathering_date();
			if (now.isAfter(gathering_date)) {
				dto.setStatus("모임종료");
			} else dto.setStatus("모집중");
		}

		return list;
	}

	@Override
	public GatheringDTO view(int gathering_id, boolean updateViewCount) {
		if (updateViewCount) {
			gatheringDao.updateViewCount(gathering_id);
		}
		GatheringDTO dto = gatheringDao.view(gathering_id);

		if (dto != null) {
			//status 세팅
			LocalDateTime now = LocalDateTime.now();
			if (now.isAfter(dto.getGathering_date())) {
				dto.setStatus("모임종료");
			} else dto.setStatus("모집중");
		}

		return dto;
	}


	@Transactional
	@Override
	public boolean addReply(GatheringReplyDTO dto) {

		boolean result = false;

		//대댓글이 아닌 일반 댓글인 경우
		if (dto.getMother_reply() == null) {
			dto.setDepth(0);
			int target = gatheringDao.getTargetReplyOrder(dto);
			dto.setInner_order(target);
		}

		//대댓글인 경우
		else {
			GatheringReplyDTO mother = gatheringDao.getReply(dto.getMother_reply());
			System.out.println("mother : " + mother);
			dto.setDepth(mother.getDepth() + 1);
			dto.setParent_reply(mother.getParent_reply());
			int target = gatheringDao.getTargetReplyOrder(mother);
			dto.setInner_order(target);
			System.out.println("target : " + target);
			gatheringDao.replyOrderUpdate(dto.getParent_reply(), dto.getInner_order());
		}

		if (gatheringDao.addReply(dto) >= 1) result = true;
		return result;
	}

	@Override
	public List<GatheringReplyDTO> getReplies(int gatheringId) {
		return gatheringDao.getReplies(gatheringId);
	}

	@Override
	public int countList(boolean showAvailable, String[] address1List
			, LocalDate from, LocalDate to, String searchOption, String keyword) {
		return gatheringDao.countList(showAvailable, address1List, from, to, searchOption, keyword);
	}

	@Override
	public boolean update(GatheringDTO dto) {
		int num = gatheringDao.update(dto);
		if (num > 1) return true;
		else return false;
	}


	@Override
	public AttendeeType checkIfAttendee(int gathering_id, String user_id) {
		return gatheringDao.checkIfAttendee(gathering_id, user_id);
	}

	@Override
	public String addAttendee(int gathering_id, String user_id, String answer) {

		String message = "";


		//몇가지 조건 확인해야 함
		//(1) 이미 모임에 참가해 있지는 않는가?
		//(2) 모임 인원이 꽉 차거나 이미 종료되지는 않았는가?
		//(3) 모임이 허가제인가?
		//(4) 삭제된 모임은 아닌가?


		//먼저 모임 정보를 출력해오자(가입인원, max인원, 허가제여부, 모임중인지, 삭제 여부)
		GatheringDTO gatheringDTO = gatheringDao.getAttendInfo(gathering_id);
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime gathering_date = gatheringDTO.getGathering_date();

		if (gatheringDTO.getMaxPeople() <= gatheringDTO.getAttendee_count()) {
			message = "모집 인원이 꽉 찼습니다.";
		} else if(gatheringDTO.getShow().equals("n")){
				message = "이 모임은 삭제되었습니다.";
		} else if(now.isAfter(gathering_date)){
			message = "이 모임은 종료되었습니다.";
		} else {

				//내 마지막 가입 여부를 출력해오자
				//가입중이거나 가입신청중이라면 no
				//반려되었거나 탈퇴했다면 ok
				//밴당한거라면?? 보류...
				AttendeeType type = checkIfAttendee(gathering_id, user_id);

				if (type == AttendeeType.ATTENDING) {
					message = "이미 모임에 참여중입니다.";
					System.out.println(message);
				} else if (type == AttendeeType.WAIT) {
					message = "모임장의 승인을 기다리는 중입니다.";
					System.out.println(message);
				} else if (gatheringDTO.getAttendSystem().equals("p")) {
						AttendeeDTO dto = new AttendeeDTO(user_id, gathering_id, AttendeeType.WAIT);
						dto.setAnswer(answer);
						int num = gatheringDao.addAttendee(dto);
						if (num >= 1) message = "모임에 가입 신청하였습니다.";
				}

				else {
						AttendeeDTO dto = new AttendeeDTO(user_id, gathering_id, AttendeeType.ATTENDING);
						int num = gatheringDao.addAttendee(dto);
						if (num >= 1) message = "모임에 성공적으로 가입되었습니다.";

						ChatMessageDTO notice = new ChatMessageDTO();
						notice.setGathering_id(dto.getGathering_id());
						notice.setUserId(user_id);
						notice.setType(ChatMessageDTO.MessageType.ATTEND);
						eventPublisher.publishEvent(notice);
					}
				}

		return message;
	}


	@Override
	public String withDrawAttendee(int gatheringId, String userId) {
		String message = "";

		if (gatheringDao.checkIfAttendee(gatheringId, userId) == AttendeeType.ATTENDING) {

			//이 사람이 글쓴이인지 확인하기
			Map<String, String> map = gatheringDao.getWriterAndShow(gatheringId);
			if (map.get("WRITER_ID").equals(userId)) {
				//모임글 삭제 여부 확인하기
				//사실 정상적인 루트라면 여기까지는 안 올 가능성이 크지만 혹시나 하는 경우에 대비
				if (map.get("SHOW").equals("y")) {
					message = "게시글 작성자는 모임 글을 삭제하기 전에는 모임에서 탈퇴할 수 없습니다.";
					return message;
				}
			}

			int num = gatheringDao.withdrawAttendee(gatheringId, userId);
			if (num >= 1) {
				message = "모임에서 성공적으로 탈퇴되었습니다.";
				ChatMessageDTO notice = new ChatMessageDTO();
				notice.setGathering_id(gatheringId);
				notice.setUserId(userId);
				notice.setType(ChatMessageDTO.MessageType.LEAVE);
				eventPublisher.publishEvent(notice);
			} else message = "요청하신 작업 처리 중 에러가 발생하였습니다.";
		} else {
			message = "요청하신 작업 처리 중 에러가 발생하였습니다.\n이 모임의 참가자가 맞는지 다시 한번 확인해 주세요.";
		}
		;

		return message;
	}


	@Override
	public String cancelApplication(int gathering_id, String user_id) {
		String message;
		int num = gatheringDao.cancelApplication(gathering_id, user_id);
		if (num >= 1) message = "가입 신청이 취소되었습니다.";
		else message = "잘못된 요청입니다.";
		return message;
	}


	@Override
	public List<GatheringDTO> getHomeList(Integer size) {
		List<GatheringDTO> list = gatheringDao.getHomeList(size);
		for (GatheringDTO dto : list) {

			//제주특별시, 세종특별시 두글자 처리
			dto.setAddress1(dto.getAddress1().substring(0, 2));
		}

		return list;
	}


	@Override
	public String getReplyWriter(int reply_id) {
		return gatheringDao.getReplyWriter(reply_id);
	}

	@Override
	public int updateReply(GatheringReplyDTO dto) {
		return gatheringDao.updateReply(dto);
	}


	@Override
	public int deleteReply(GatheringReplyDTO dto) {
		return gatheringDao.deleteReply(dto);
	}

	@Override
	public List<GatheringDTO> getAttendingChatroomList(String user_id, Integer gathering_id) {
		List<GatheringDTO> gatheringList = gatheringDao.getAttendingGatheringList(user_id);

		List<Integer> idList = new ArrayList<>();
		List<GatheringDTO> resultList = new ArrayList<>();

		for(GatheringDTO item : gatheringList) {
			idList.add(item.getGathering_id());
		}

		List<ChatMessageDTO> lastMessages = chatMessageDAO.getLastChatMessages(idList);

		for(ChatMessageDTO item : lastMessages){

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
			item.setFormattedDate(dateFormat.format(item.getInsertDate()));

			if(item.getUserId().equals("SYSTEM")){
				String message = item.getMessage();
				int index = message.indexOf("]");
				if(index!=-1){
					String user = message.substring(1, index);
					item.setMessage(memberDAO.getNickname(user) + message.substring(index+1));
				}
			}

			Optional<GatheringDTO> dto = gatheringList.stream()
					.filter(g -> g.getGathering_id() == item.getGathering_id())
					.findFirst();

			if(dto.isPresent()){
				GatheringDTO g = dto.get();
				g.setLastChat(item);

				resultList.add(g);
			}

		}
		return resultList;
	}

	@Override
	public List<Integer> getMyActiveChats(String user_id) {
		return gatheringDao.getMyActiveChats(user_id);

	@Override
	public List<GatheringDTO> totalSearch(String gameKeyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("gameKeyword", gameKeyword);
		map.put("filter", "none");
		List<GatheringDTO> list = gatheringDao.totalSearch(map);

		for(GatheringDTO dto : list) {
			//status 세팅
			LocalDateTime now = LocalDateTime.now();
			LocalDateTime gathering_date = dto.getGathering_date();
			if (now.isAfter(gathering_date)) {
				dto.setStatus("모임종료");
			} else dto.setStatus("모집중");
		}
		return list;
	}

	@Override
	public Map<String, Object> totalSearchMore(Map<String, Object> map) {
		List<GatheringDTO> list = gatheringDao.totalSearch(map);
		for(GatheringDTO dto : list) {
			//status 세팅
			LocalDateTime now = LocalDateTime.now();
			LocalDateTime gathering_date = dto.getGathering_date();
			if (now.isAfter(gathering_date)) {
				dto.setStatus("모임종료");
			} else dto.setStatus("모집중");
		}
		map.put("list",list);
		return map;
	}
}