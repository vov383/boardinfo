package com.example.boardinfo.model.tboard.dto;

import java.util.Arrays;
import java.util.Date;

public class TBAttachDTO {

	private int file_reg_num;
	private int tb_num;
	private String fullName;
	private String formatName;
	private byte[] fileData;
	private String del;
	private String create_user;
	private Date create_date;

	private String update_user;
	private Date update_date;

	public String getFormatName() {
		return formatName;
	}

	public void setFormatName(String formatName) {
		this.formatName = formatName;
	}

	public int getFile_reg_num() {
		return file_reg_num;
	}

	public void setFile_reg_num(int file_reg_num) {
		this.file_reg_num = file_reg_num;
	}

	public int getTb_num() {
		return tb_num;
	}

	public void setTb_num(int tb_num) {
		this.tb_num = tb_num;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}


	public byte[] getFileData() {
		return fileData;
	}

	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
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
		return "TBAttachDTO{" +
				"file_reg_num=" + file_reg_num +
				", tb_num=" + tb_num +
				", fullName='" + fullName + '\'' +
				", formatName='" + formatName + '\'' +
				", fileData=" + Arrays.toString(fileData) +
				", del='" + del + '\'' +
				", create_user='" + create_user + '\'' +
				", create_date=" + create_date +
				", update_user='" + update_user + '\'' +
				", update_date=" + update_date +
				'}';
	}
}
