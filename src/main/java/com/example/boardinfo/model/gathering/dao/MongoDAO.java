package com.example.boardinfo.model.gathering.dao;

import java.sql.Date;

import javax.inject.Inject;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class MongoDAO {
	
	@Inject
	private MongoTemplate mongoTemplate;
	

	public void insertTestVO() {
		TestVO testVO = new TestVO();
		testVO.setUser_id("kim123");
		testVO.setMessageText("안녕");
		
		//VO : collection명
		System.out.print("넣는당");
		mongoTemplate.insert(testVO, "chatMessage");
		System.out.print("넣었당");
	}
	
	
	
	
	public class TestVO{
		
		private String user_id;
		private String messageText;
		private Date sentDateTime;
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getMessageText() {
			return messageText;
		}
		public void setMessageText(String messageText) {
			this.messageText = messageText;
		}
		public Date getSentDateTime() {
			return sentDateTime;
		}
		public void setSentDateTime(Date sentDateTime) {
			this.sentDateTime = sentDateTime;
		}
		
		
		
	}

}
