package com.example.boardinfo.service.chat;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.chat.dao.ChatMessageDAO;
import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.model.gathering.dao.MongoDAO;

@Service
public class MongoService {
	
	@Inject
	private MongoDAO dao;
	
	@Inject
	private ChatMessageDAO cdao;
	
	
	public void insert() {
		ChatMessageDTO chat = new ChatMessageDTO();
		chat.setMessage("안녕!!!");
		cdao.insert(chat);
	}

}
