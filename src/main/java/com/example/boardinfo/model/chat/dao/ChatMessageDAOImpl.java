package com.example.boardinfo.model.chat.dao;

import javax.inject.Inject;

import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;


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
}
