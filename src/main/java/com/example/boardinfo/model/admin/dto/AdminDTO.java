package com.example.boardinfo.model.admin.dto;

import java.util.Date;

public class AdminDTO {
    private String admin_id;
    private String passwd;
    private String nickname;
    private String name;
    private String email;
    private String hp;
    private String profile;
    private String admin_dept;
    private String admin_level;
    private String del;
    private String create_user;
    private Date create_date;
    private String update_user;
    private Date update_date;

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getAdmin_dept() {
        return admin_dept;
    }

    public void setAdmin_dept(String admin_dept) {
        this.admin_dept = admin_dept;
    }

    public String getAdmin_level() {
        return admin_level;
    }

    public void setAdmin_level(String admin_level) {
        this.admin_level = admin_level;
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
        return "AdminDTO{" +
                "admin_id='" + admin_id + '\'' +
                ", passwd='" + passwd + '\'' +
                ", nickname='" + nickname + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", hp='" + hp + '\'' +
                ", profile='" + profile + '\'' +
                ", admin_dept='" + admin_dept + '\'' +
                ", admin_level='" + admin_level + '\'' +
                ", del='" + del + '\'' +
                ", create_user='" + create_user + '\'' +
                ", create_date=" + create_date +
                ", update_user='" + update_user + '\'' +
                ", update_date=" + update_date +
                '}';
    }
}
