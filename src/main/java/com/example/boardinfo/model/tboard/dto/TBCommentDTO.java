package com.example.boardinfo.model.tboard.dto;

import java.util.Date;

public class TBCommentDTO {
	private int reply_reg_num;
    private int reply_parent_reg_num;
    private int tb_num;
    private String content;
    private String del;
    private String create_user;
    private Date create_date;
    private String update_user;
    private Date update_date;
	
    //getter, setter
    public int getReply_reg_num() {
		return reply_reg_num;
	}
	public void setReply_reg_num(int reply_reg_num) {
		this.reply_reg_num = reply_reg_num;
	}
	public int getReply_parent_reg_num() {
		return reply_parent_reg_num;
	}
	public void setReply_parent_reg_num(int reply_parent_reg_num) {
		this.reply_parent_reg_num = reply_parent_reg_num;
	}
	public int getTb_num() {
		return tb_num;
	}
	public void setTb_num(int tb_num) {
		this.tb_num = tb_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
		return "TBCommentsDTO [reply_reg_num=" + reply_reg_num + ", reply_parent_reg_num=" + reply_parent_reg_num
				+ ", tb_num=" + tb_num + ", content=" + content + ", del=" + del + ", create_user=" + create_user
				+ ", create_date=" + create_date + ", update_user=" + update_user + ", update_date=" + update_date
				+ "]";
	}
    
}
