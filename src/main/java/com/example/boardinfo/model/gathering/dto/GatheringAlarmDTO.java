package com.example.boardinfo.model.gathering.dto;

import java.util.Date;

public class GatheringAlarmDTO {

    public enum AlarmType{
        FOCUS, BLUR, ATTEND, ACCEPTED,
        LEAVE, CLOSE, DELETED, APPLY, THROWN, REJECTED
    }

    private String alarm_id;
    private String receiver_id; //받는 사람
    private String sender_id;
    private GatheringAlarmDTO.AlarmType type; //알람 타입
    private String message;
    private Date create_date; //메시지 보낸 날짜
    private Date read_date;
    private String formattedDate;
    private int gathering_id;
    private String show;
    private String post_title;
    private String sender_nickname;
    private String url;
    private boolean existingUnread;


    public GatheringAlarmDTO(){

    }

    public GatheringAlarmDTO(String receiver_id, String sender_id, AlarmType type, int gathering_id) {
        this.receiver_id = receiver_id;
        this.sender_id = sender_id;
        this.type = type;
        this.gathering_id = gathering_id;
    }

    public GatheringAlarmDTO(String receiver_id, AlarmType type, int gathering_id) {
        this.receiver_id = receiver_id;
        this.type = type;
        this.gathering_id = gathering_id;
    }

    public String getAlarm_id() {
        return alarm_id;
    }

    public void setAlarm_id(String alarm_id) {
        this.alarm_id = alarm_id;
    }

    public String getReceiver_id() {
        return receiver_id;
    }

    public void setReceiver_id(String receiver_id) {
        this.receiver_id = receiver_id;
    }

    public String getSender_id() {
        return sender_id;
    }

    public void setSender_id(String sender_id) {
        this.sender_id = sender_id;
    }

    public AlarmType getType() {
        return type;
    }

    public void setType(AlarmType type) {
        this.type = type;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Date getRead_date() {
        return read_date;
    }

    public void setRead_date(Date read_date) {
        this.read_date = read_date;
    }

    public String getFormattedDate() {
        return formattedDate;
    }

    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }

    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public String getShow() {
        return show;
    }

    public void setShow(String show) {
        this.show = show;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getPost_title() {
        return post_title;
    }

    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }

    public String getSender_nickname() {
        return sender_nickname;
    }

    public void setSender_nickname(String sender_nickname) {
        this.sender_nickname = sender_nickname;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isExistingUnread() {
        return existingUnread;
    }

    public void setExistingUnread(boolean existingUnread) {
        this.existingUnread = existingUnread;
    }

    @Override
    public String toString() {
        return "GatheringAlarmDTO{" +
                "alarm_id='" + alarm_id + '\'' +
                ", receiver_id='" + receiver_id + '\'' +
                ", sender_id='" + sender_id + '\'' +
                ", type=" + type +
                ", message='" + message + '\'' +
                ", create_date=" + create_date +
                ", read_date=" + read_date +
                ", formattedDate='" + formattedDate + '\'' +
                ", gathering_id=" + gathering_id +
                ", show='" + show + '\'' +
                ", post_title='" + post_title + '\'' +
                ", sender_nickname='" + sender_nickname + '\'' +
                '}';
    }
}
