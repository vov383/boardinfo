package com.example.boardinfo.model.chat.dao;

import javax.inject.Inject;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.util.List;


@Repository
public class ChatMessageDAOImpl implements ChatMessageDAO {
	
	@Inject 
	private MongoTemplate mongoTemplate;

	public void insert(ChatMessageDTO message) {
			mongoTemplate.insert(message, "chatMessage");
	}

	@Override
	public List<ChatMessageDTO> getList(int gathering_id) {
		Query query = new Query(Criteria.where("gathering_id").is(gathering_id));
		return mongoTemplate.find(query, ChatMessageDTO.class, "chatMessage");
	}
}
