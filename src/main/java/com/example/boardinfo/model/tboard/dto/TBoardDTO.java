package com.example.boardinfo.model.tboard.dto;

import java.util.Date;

public class TBoardDTO {

	private int tb_num;
	private String category;
	private String title;
	private int price;
	private String description;
	private int view_count;
	private int re_count;
	private String del;
	private String create_user;
	private Date create_date;
	private String update_user;
	private Date update_date;
	private String meeting_place;
	
	public String getMeeting_place() {
		return meeting_place;
	}
	public void setMeeting_place(String meeting_place) {
		this.meeting_place = meeting_place;
	}
	//getter, setter
	public int getTb_num() {
		return tb_num;
	}
	public void setTb_num(int tb_num) {
		this.tb_num = tb_num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public int getRe_count() {
		return re_count;
	}
	public void setRe_count(int re_count) {
		this.re_count = re_count;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_user() {
		return update_user;
	}
	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	@Override
	public String toString() {
		return "TBoardDTO [tb_num=" + tb_num + ", category=" + category + ", title=" + title + ", price=" + price
				+ ", description=" + description + ", view_count=" + view_count + ", re_count=" + re_count + ", del="
				+ del + ", create_user=" + create_user + ", create_date=" + create_date + ", update_user=" + update_user
				+ ", update_date=" + update_date + ", meeting_place=" + meeting_place + "]";
	}
	
}
