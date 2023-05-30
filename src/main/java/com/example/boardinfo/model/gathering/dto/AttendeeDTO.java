package com.example.boardinfo.model.gathering.dto;

import java.util.Date;

public class AttendeeDTO {

    private AttendeeType type;
    private String user_id;
    private int attendee_id;
    private int gathering_id;
    private Date create_date;
    private Date update_date;


    public AttendeeDTO(){
    }

    public AttendeeDTO(String user_id, int gathering_id, AttendeeType type){
        this.user_id = user_id;
        this.gathering_id = gathering_id;
        this.type = type;
    }

    public int getAttendee_id() {
        return attendee_id;
    }

    public void setAttendee_id(int attendee_id) {
        this.attendee_id = attendee_id;
    }

    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    public AttendeeType getType() {
        return type;
    }

    public void setType(AttendeeType type) {
        this.type = type;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "AttendeeDTO{" +
                "type=" + type +
                ", user_id='" + user_id + '\'' +
                ", attendee_id=" + attendee_id +
                ", gathering_id=" + gathering_id +
                ", create_date=" + create_date +
                ", update_date=" + update_date +
                '}';
    }
}
