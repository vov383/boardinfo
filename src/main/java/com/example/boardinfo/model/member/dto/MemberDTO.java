package com.example.boardinfo.model.member.dto;

import java.util.Date;

public class MemberDTO {
	private String profile;
	private String name; 
	private String userid;
	private String passwd;
	private String nickname;
	private String email;
	private String hp;
	private Date join_date;
	//getter,setter, toString ,생성자
	
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	@Override
	public String toString() {
		return "MemberDTO [profile=" + profile + ", name=" + name + ", userid=" + userid + ", passwd=" + passwd
				+ ", nickname=" + nickname + ", email=" + email + ", hp=" + hp + ", join_date=" + join_date + "]";
	}
	public MemberDTO() {
	
	}
	public MemberDTO(String profile, String name, String userid, String passwd, String nickname, String email,
			String hp, Date join_date) {
		super();
		this.profile = profile;
		this.name = name;
		this.userid = userid;
		this.passwd = passwd;
		this.nickname = nickname;
		this.email = email;
		this.hp = hp;
		this.join_date = join_date;
	}
	
	
	
	
	
	
}
