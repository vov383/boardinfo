package com.example.boardinfo.model.chat.dao;

import javax.inject.Inject;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;


@Repository
public class ChatMessageDAO {
	
	@Inject 
	private MongoTemplate mongoTemplate;
	
		public void insert(ChatMessageDTO message) {
			System.out.println("넣을거임");
			System.out.println("template" + mongoTemplate);
			mongoTemplate.insert(message, "chatMessage");
			System.out.println("넣었니");

	}
	

}
