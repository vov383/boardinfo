package com.example.boardinfo.model.chat.dao;

import javax.inject.Inject;

import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.text.SimpleDateFormat;
import java.util.*;


@Repository
public class ChatMessageDAOImpl implements ChatMessageDAO {
	
	@Inject 
	private MongoTemplate mongoTemplate;

	public void insert(ChatMessageDTO message) {
			mongoTemplate.insert(message, "chatMessage");
	}

	@Override
	public List<ChatMessageDTO> getList(int gathering_id, int curPage, boolean desc) {

		int pageSize = 30;
		int skip = (curPage-1) * pageSize;

		Query query = new Query(Criteria.where("gathering_id").is(gathering_id))
				.with(Sort.by(Sort.Direction.DESC, "insertDate")).skip(skip).limit(pageSize);

		List<ChatMessageDTO> list = mongoTemplate.find(query, ChatMessageDTO.class, "chatMessage");

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd'T'HH:mm");
		list.forEach(item -> {
			item.setFormattedDate(dateFormat.format(item.getInsertDate()));
				});

		if(desc == false){
			Collections.reverse(list);
		}

		return list;
	}

	@Override
	public List<ChatMessageDTO> getLastChatMessages(List<Integer> idList) {

		MatchOperation match = Aggregation.match(Criteria.where("gathering_id").in(idList));
		SortOperation sort = Aggregation.sort(Sort.Direction.DESC, "insertDate");
		GroupOperation group = Aggregation.group("gathering_id")
				.first(Aggregation.ROOT).as("lastMessage");
		ProjectionOperation project = Aggregation.project("lastMessage")
				.andExpression("lastMessage.message").as("message")
				.andExpression("lastMessage.gathering_id").as("gathering_id")
				.andExpression("lastMessage.insertDate").as("insertDate")
				.andExpression("lastMessage.userId").as("userId");

		SortOperation finalSort = Aggregation.sort(Sort.Direction.DESC, "insertDate");

		Aggregation aggregation = Aggregation.newAggregation(match, sort, group,project,finalSort);
		AggregationResults<ChatMessageDTO> results = mongoTemplate.aggregate(aggregation, "chatMessage", ChatMessageDTO.class);
		return results.getMappedResults();

	}


	@Override
	public long countMyUnreads(List<ChatRoomDTO> myRooms) {
		long unread = 0L;

		for (ChatRoomDTO room : myRooms) {
			Query query = new Query()
					.addCriteria(Criteria.where("gathering_id").is(room.getGathering_id())
							.and("timestamp").gt(room.getLast_visit()));
			long unreadCount = mongoTemplate.count(query, ChatMessageDTO.class);
			unread += unreadCount;
		}

		return unread;
	}

}
