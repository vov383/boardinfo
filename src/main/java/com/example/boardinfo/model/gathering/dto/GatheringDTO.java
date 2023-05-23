package com.example.boardinfo.model.gathering.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GatheringDTO {
	
	private int gathering_id;
	private String writer_id;

	private Date post_date;
	private Date update_date;
	private String title;
	private String description;
	private String img_url;
	@DateTimeFormat(pattern="yyy-MM-dd'T'HH:mm")
	private Date gathering_date;
	private int fee;
	private String address1;
	private String address2;
	private String address3;
	private String place_name;
	private double lat;
	private double lng;
	private int maxPeople;
	private String attendSystem;
	private String note;
	private String question;
	private String status;
	private int club_id;
	private int is_public;
	private int view_count;
	
	public int getGathering_id() {
		return gathering_id;
	}
	public void setGathering_id(int gathering_id) {
		this.gathering_id = gathering_id;
	}
	public String getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public Date getGathering_date() {
		return gathering_date;
	}
	public void setGathering_date(Date gathering_date) {
		this.gathering_date = gathering_date;
	}
	public int getFee() {
		return fee;
	}
	public void setFee(int fee) {
		this.fee = fee;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public int getMaxPeople() {
		return maxPeople;
	}
	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}
	public String getAttendSystem() {
		return attendSystem;
	}
	public void setAttendSystem(String attendSystem) {
		this.attendSystem = attendSystem;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getClub_id() {
		return club_id;
	}
	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}
	public int getIs_public() {
		return is_public;
	}
	public void setIs_public(int is_public) {
		this.is_public = is_public;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
	
	
	

	

}
