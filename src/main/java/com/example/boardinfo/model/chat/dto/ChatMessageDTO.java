package com.example.boardinfo.model.chat.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ChatMessageDTO {

	public enum MessageType{
		CONNECT, FOCUS, BLUR, SEND, CLOSE, ATTEND, LEAVE
	}
	
	private String userId; //메시지 보낸 사람
	private String message; //메시지 내용
	private MessageType type; //메시지 타입

	private Date insertDate; //메시지 보낸 날짜
	private String formattedDate;
	private String nickname;
	private int gathering_id;
	
	
	
	public ChatMessageDTO() {
		insertDate = new Date();
	}
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public MessageType getType() {
		return type;
	}

	public void setType(MessageType type) {
		this.type = type;
	}

	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	public int getGathering_id() {
		return gathering_id;
	}

	public void setGathering_id(int gathering_id) {
		this.gathering_id = gathering_id;
	}

	public String getFormattedDate() {
		return formattedDate;
	}

	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "ChatMessageDTO{" +
				"userId='" + userId + '\'' +
				", message='" + message + '\'' +
				", type=" + type +
				", insertDate=" + insertDate +
				", formattedDate='" + formattedDate + '\'' +
				", nickname='" + nickname + '\'' +
				", gathering_id=" + gathering_id +
				'}';
	}
}
