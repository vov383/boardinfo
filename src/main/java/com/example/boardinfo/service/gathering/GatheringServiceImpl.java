package com.example.boardinfo.service.gathering;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.*;


import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import com.example.boardinfo.model.gathering.dao.GatheringAlarmDAO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.*;
import com.example.boardinfo.service.chat.ChatService;

import com.example.boardinfo.model.gathering.dto.AttendeeDTO;
import com.example.boardinfo.model.gathering.dto.AttendeeType;
import com.example.boardinfo.model.gathering.dto.GatheringReplyDTO;
import com.example.boardinfo.util.Pager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;


@Service
public class GatheringServiceImpl implements GatheringService {
	private static final Logger logger=
			LoggerFactory.getLogger(GatheringServiceImpl.class);
	@Inject
	GatheringDAO gatheringDao;

	@Inject
	ChatService chatService;

	@Inject
	GatheringAlarmDAO gatheringAlarmDAO;

	@Autowired
	ApplicationEventPublisher eventPublisher;


	@Override
	public boolean checkIsWriter(int gathering_id, String user_id) {
		String writer_id = gatheringDao.getWriter(gathering_id);
		if(writer_id.equals(user_id)) return true;
		else return false;
	}

	@Override
	public String setStatus(GatheringDTO dto) {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime gathering_date = dto.getGathering_date();
		if (now.isAfter(gathering_date)) {
			return "모임종료";
		}
		else if(dto.getMaxPeople()<= dto.getAttendee_count()) return "모집완료";
		else return "모집중";
	}

	@Transactional
	@Override
	public int addPost(GatheringDTO dto, HttpSession session) {
		int new_gathering_id = gatheringDao.addPost(dto);
		gatheringDao.addAttendee(new AttendeeDTO(dto.getWriter_id(), new_gathering_id, AttendeeType.ATTENDING));

		//얘도 연결시키라고 알려줘야 함
		GatheringAlarmDTO alarm = new GatheringAlarmDTO(dto.getWriter_id(), GatheringAlarmDTO.AlarmType.ATTEND, dto.getGathering_id());
		eventPublisher.publishEvent(alarm);
		chatService.updateActiveChatList(session);

		ChatMessageDTO notice = new ChatMessageDTO(ChatMessageDTO.MessageType.ATTEND,
				new_gathering_id, dto.getWriter_id());
		eventPublisher.publishEvent(notice);

		return new_gathering_id;
	}

	@Transactional
	@Override
	public String deletePost(int gathering_id, String user_id, HttpSession session) {
		String message;

		//일단 이 사람이 글쓴이인지 확인
		if (checkIsWriter(gathering_id, user_id)) {
			int num = gatheringDao.deletePost(gathering_id);

			//참가자 전원 leave로 바꿔버리고 apply는 삭제해야
			if (num >=1) {
				message = "게시물이 정상적으로 삭제되었습니다.";

				List<String> attendeeList = gatheringDao.leaveAll(gathering_id);

				//모임이 삭제됐다고 알림 통보
				if(attendeeList!=null && attendeeList.size() > 0){
					GatheringAlarmDTO alarm = new GatheringAlarmDTO();
					alarm.setSender_id(user_id);
					alarm.setGathering_id(gathering_id);
					alarm.setType(GatheringAlarmDTO.AlarmType.DELETED);
					eventPublisher.publishEvent(alarm);
					gatheringAlarmDAO.noticeGatheringDeleted(alarm, attendeeList);
				}

				ChatMessageDTO chatMessageDTO = new ChatMessageDTO();
				chatMessageDTO.setGathering_id(gathering_id);
				chatMessageDTO.setType(ChatMessageDTO.MessageType.DELETED);
				eventPublisher.publishEvent(chatMessageDTO);
				chatService.updateActiveChatList(session);

			}
			else message = GatheringErrorMessages.ERROR_DURING_PROCESS;
		}
		else message = GatheringErrorMessages.UNAUTHORIZED;

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
			dto.setStatus(setStatus(dto));
		}

		return list;
	}

	@Override
	public GatheringDTO simpleView(int gathering_id) {
		GatheringDTO dto = gatheringDao.view(gathering_id);
		return dto;
	}


	@Override
	public GatheringDTO getGatheringDetails(int gathering_id) {
		GatheringDTO dto = simpleView(gathering_id);

		if(dto!=null){
			List<AttendeeDTO> attendees = gatheringDao.getAttendeeInfoList(gathering_id);
			dto.setAttendeeDTOList(attendees);
			List<AttendeeDTO> waitings = gatheringDao.getWaitingInfoList(gathering_id);
			dto.setWaitingDTOList(waitings);
			dto.setAttendee_count(dto.getAttendeeDTOList().size());
			dto.setStatus(setStatus(dto));
		}
		return dto;
	}


	@Override
	public List<AttendeeDTO> getAttendeeList(Integer gathering_id) {
		return gatheringDao.getAttendeeInfoList(gathering_id);
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
			dto.setDepth(mother.getDepth() + 1);
			dto.setParent_reply(mother.getParent_reply());
			int target = gatheringDao.getTargetReplyOrder(mother);
			dto.setInner_order(target);
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

	@Transactional
	@Override
	public String addAttendee(int gathering_id, String user_id, String answer, HttpSession session) {

		String message = "";

		//몇가지 조건 확인해야 함
		//(1) 이미 모임에 참가해 있지는 않는가?
		//(2) 모임 인원이 꽉 차거나 이미 종료되지는 않았는가?
		//(3) 모임이 허가제인가?
		//(4) 삭제된 모임은 아닌가?

		//먼저 모임 정보를 출력해오자(가입인원, max인원, 허가제여부, 모임중인지, 삭제 여부)
		GatheringDTO gatheringDTO = gatheringDao.getAttendInfo(gathering_id);
		gatheringDTO.setStatus(setStatus(gatheringDTO));
		if(gatheringDTO.getStatus().equals("모집완료")){
			message = GatheringErrorMessages.FULL;
		} else if(gatheringDTO.getStatus().equals("모임종료")){
			message = GatheringErrorMessages.FINISHED;
		} else if(gatheringDTO.getShow().equals("N")){
				message = GatheringErrorMessages.DELETED;
		} else {
				//내 마지막 가입 여부를 출력해오자
				//이미 가입중이거나 가입신청중이라면 no
				AttendeeType type = checkIfAttendee(gathering_id, user_id);

				if (type == AttendeeType.ATTENDING) {
					message = GatheringErrorMessages.ALREADY_ATTENDING;
				} else if (type == AttendeeType.WAIT) {
					message = GatheringErrorMessages.WAITING;
				} else if (gatheringDTO.getAttendSystem().equals("p")) {
						AttendeeDTO dto = new AttendeeDTO(user_id, gathering_id, AttendeeType.WAIT);
						dto.setAnswer(answer);
						int num = gatheringDao.addAttendee(dto);
						if (num >= 1) {
							message = "모임에 가입 신청하였습니다.";
							String writer_id = gatheringDao.getWriter(gathering_id);
							GatheringAlarmDTO alarm = new GatheringAlarmDTO(writer_id, user_id, GatheringAlarmDTO.AlarmType.APPLY, gathering_id);
							eventPublisher.publishEvent(alarm);
						}
				}

				else {
						AttendeeDTO dto = new AttendeeDTO(user_id, gathering_id, AttendeeType.ATTENDING);
						int num = gatheringDao.addAttendee(dto);
						if (num >= 1) message = "모임에 성공적으로 가입되었습니다.";
						ChatMessageDTO notice = new ChatMessageDTO(ChatMessageDTO.MessageType.ATTEND,
								dto.getGathering_id(), user_id);
						eventPublisher.publishEvent(notice);

						//얘도 연결시키라고 알려줘야 함
						GatheringAlarmDTO alarm = new GatheringAlarmDTO(
								user_id, GatheringAlarmDTO.AlarmType.ATTEND, dto.getGathering_id());
						eventPublisher.publishEvent(alarm);
						chatService.updateActiveChatList(session);
					}
				}

		return message;
	}


	@Override
	public String withDrawAttendee(int gathering_id, String user_id, HttpSession session) {
		String message = "";

		if (gatheringDao.checkIfAttendee(gathering_id, user_id) == AttendeeType.ATTENDING) {

			//이 사람이 글쓴이인지 확인하기
			if(checkIsWriter(gathering_id, user_id)){
				//모임글 삭제 여부 확인하기
				//사실 정상적인 루트라면 여기까지는 안 올 가능성이 크지만 혹시나 하는 경우에 대비
				GatheringDTO dto = gatheringDao.view(gathering_id);
				if(dto.getShow().equals("Y")){
					message = GatheringErrorMessages.WRITER_CANNOT_LEAVE;
					return message;
				}
			}

			int num = gatheringDao.withdrawAttendee(gathering_id, user_id);
			if (num >= 1) {
				message = "모임에서 성공적으로 탈퇴되었습니다.";
				chatService.updateActiveChatList(session);

				ChatMessageDTO notice = new ChatMessageDTO(ChatMessageDTO.MessageType.LEAVE, gathering_id, user_id);
				eventPublisher.publishEvent(notice);
				GatheringAlarmDTO alarm = new GatheringAlarmDTO(user_id, GatheringAlarmDTO.AlarmType.LEAVE, gathering_id);
				eventPublisher.publishEvent(alarm);

			} else message = GatheringErrorMessages.ERROR_DURING_PROCESS;

		} else {
			message = GatheringErrorMessages.NOT_ATTENDING;
		}
		return message;
	}


	@Override
	public String cancelApplication(int gathering_id, String user_id) {
		String message;
		int num = gatheringDao.cancelApplication(gathering_id, user_id);
		if (num >= 1) message = "가입 신청이 취소되었습니다.";
		else message = GatheringErrorMessages.ERROR_DURING_PROCESS;
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
	public List<GatheringDTO> totalSearch(String gameKeyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("gameKeyword", gameKeyword);
		map.put("filter", "none");
		List<GatheringDTO> list = gatheringDao.totalSearch(map);

		for(GatheringDTO dto : list) {
			dto.setStatus(setStatus(dto));
		}
		return list;
	}

	@Override
	public Map<String, Object> totalSearchMore(Map<String, Object> map) {
		int curPage = Integer.parseInt(String.valueOf(map.get("curPage")));

		int count = gatheringDao.totalSearchCount(map);

		Pager pager = new Pager(count, curPage, 10);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		map.put("start",start);
		map.put("end",end);

		List<GatheringDTO> list = gatheringDao.totalSearch(map);
		for(GatheringDTO dto : list) {
			dto.setStatus(setStatus(dto));
		}
		map.put("list",list);
		map.put("count",count);
		map.put("pager",pager);
		return map;
	}

	@Override
	public void updateViewCount(int gathering_id, Cookie cookie, HttpServletResponse response) {
		if(cookie!=null) {
			String gatheringViewCookie = cookie.getValue();
			if(gatheringViewCookie.indexOf("["+gathering_id+"]")==-1) {
				response.addCookie(new Cookie("gatheringView", gatheringViewCookie + "_["+gathering_id+"]"));
				gatheringDao.updateViewCount(gathering_id);
			}
		}
		else {
			response.addCookie(new Cookie("gatheringView", "["+gathering_id+"]"));
		}
	}


	@Transactional
	@Override
	public Map<String, Object> acceptApply(String writer_id, int gathering_id, int attendee_id) {

		Map<String, Object> resultMap = new HashMap<>();

		String message = "";
		//두가지를 확인해야 함
		//(1) 이 사람이 모임장이며 이 글이 삭제되지 않았는가?
		//(2) 이 모임의 인원이 꽉 차지 않았고 + 모임 날짜가 지나지 않았는가?

		if(checkIsWriter(gathering_id, writer_id)) {
			GatheringDTO gatheringDTO = gatheringDao.getAttendInfo(gathering_id);
			gatheringDTO.setStatus(setStatus(gatheringDTO));

			if (gatheringDTO.getStatus().equals("모집완료")) {
				message = GatheringErrorMessages.FULL;
			} else if (gatheringDTO.getShow().equals("N")) {
				message = GatheringErrorMessages.DELETED;
			} else if (gatheringDTO.getStatus().equals("모임종료")) {
				message = GatheringErrorMessages.FINISHED;
			} else {
				int num = gatheringDao.acceptApply(gathering_id, attendee_id);

				if (num > 0){
					List<AttendeeDTO> attendeeDTOList = gatheringDao.getAttendeeInfoList(gathering_id);
					List<AttendeeDTO> waitingDTOList = gatheringDao.getWaitingInfoList(gathering_id);

					if(attendeeDTOList.size() <= gatheringDTO.getMaxPeople()){
						resultMap.put("attendeeDTOList", attendeeDTOList);
						resultMap.put("waitingDTOList", waitingDTOList);

						AttendeeDTO attendee = gatheringDao.getAttendeeInfo(attendee_id);
						ChatMessageDTO chatMessage
								= new ChatMessageDTO(ChatMessageDTO.MessageType.ATTEND, gathering_id, attendee.getUser_id());
						chatMessage.setNickname(attendee.getNickname());
						eventPublisher.publishEvent(chatMessage);

						GatheringAlarmDTO alarm = new GatheringAlarmDTO(attendee.getUser_id(), writer_id, GatheringAlarmDTO.AlarmType.ACCEPTED, gathering_id);
						eventPublisher.publishEvent(alarm);
					}

					else{
						TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
						message = GatheringErrorMessages.FULL;
					}

				}
				else message = GatheringErrorMessages.ERROR_DURING_PROCESS;
			}
		}
		else{
			message = GatheringErrorMessages.UNAUTHORIZED;
		}

		resultMap.put("message", message);
		return resultMap;
	}


	@Override
	public Map<String, Object> rejectApply(String writer_id, int gathering_id, int attendee_id) {

		Map<String, Object> resultMap = new HashMap<>();
		String message = "";

		//한가지를 확인해야 함. 이 사람이 모임장이 맞는가?
		if(checkIsWriter(gathering_id, writer_id)) {
			int num = gatheringDao.rejectApply(gathering_id, attendee_id);
			if(num > 0){
				List<AttendeeDTO> attendeeDTOList = gatheringDao.getAttendeeInfoList(gathering_id);
				List<AttendeeDTO> waitingDTOList = gatheringDao.getWaitingInfoList(gathering_id);
				resultMap.put("attendeeDTOList", attendeeDTOList);
				resultMap.put("waitingDTOList", waitingDTOList);

				AttendeeDTO attendee = gatheringDao.getAttendeeInfo(attendee_id);
				GatheringAlarmDTO alarm = new GatheringAlarmDTO(attendee.getUser_id(), writer_id,
						GatheringAlarmDTO.AlarmType.REJECTED, gathering_id);
				eventPublisher.publishEvent(alarm);

			}

			else{
				message = GatheringErrorMessages.ERROR_DURING_PROCESS;
			}
		}

		else{
			message = GatheringErrorMessages.UNAUTHORIZED;
		}

		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public Map<String, Object> throwAttendee(String writer_id, int gathering_id, int attendee_id) {
		Map<String, Object> resultMap = new HashMap<>();
		String message = "";

		if(checkIsWriter(gathering_id, writer_id)){
			AttendeeDTO attendee = gatheringDao.getAttendeeInfo(attendee_id);
			if(attendee.getUser_id().equals(writer_id)){
				message = GatheringErrorMessages.WRITER_CANNOT_BE_THROWN;
			}
			else{
				int num = gatheringDao.throwAttendee(attendee_id, gathering_id);
				if(num > 0){
					List<AttendeeDTO> attendeeDTOList = gatheringDao.getAttendeeInfoList(gathering_id);
					List<AttendeeDTO> waitingDTOList = gatheringDao.getWaitingInfoList(gathering_id);
					resultMap.put("attendeeDTOList", attendeeDTOList);
					resultMap.put("waitingDTOList", waitingDTOList);

					GatheringAlarmDTO alarm = new GatheringAlarmDTO(attendee.getUser_id(), writer_id, GatheringAlarmDTO.AlarmType.THROWN, gathering_id);
					eventPublisher.publishEvent(alarm);

					ChatMessageDTO chatMessage
							= new ChatMessageDTO(ChatMessageDTO.MessageType.THROW, gathering_id, attendee.getUser_id());
					chatMessage.setNickname(attendee.getNickname());
					eventPublisher.publishEvent(chatMessage);

				}

				else{
					message = GatheringErrorMessages.ERROR_DURING_PROCESS;
				}

			}
		}
		else{
			message = GatheringErrorMessages.UNAUTHORIZED;
		}

		resultMap.put("message", message);

		return resultMap;
	}



}