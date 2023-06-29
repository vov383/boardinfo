package com.example.boardinfo.model.gathering.dto;

import java.util.Date;

public class GatheringAlarmDTO {

    public enum AlarmType{
        FOCUS, BLUR, ATTEND, ACCEPTED, LEAVE, CLOSE, DELETED, APPLY
    }

    public String alarm_id;
    private String user_id; //받는 사람
    private String message; //메시지 내용
    private GatheringAlarmDTO.AlarmType type; //알람 타입
    private Date create_date; //메시지 보낸 날짜
    private String formattedDate;
    private int gathering_id;
    private String read;
    private boolean existingUnread;


    //n: process필요, d: 완료
    private String process;


    public GatheringAlarmDTO(){

    }

    public GatheringAlarmDTO(String user_id, AlarmType type, int gathering_id) {
        this.user_id = user_id;
        this.type = type;
        this.gathering_id = gathering_id;
    }

    public String getAlarm_id() {
        return alarm_id;
    }

    public void setAlarm_id(String alarm_id) {
        this.alarm_id = alarm_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public String getRead() {
        return read;
    }

    public void setRead(String read) {
        this.read = read;
    }

    public String getProcess() {
        return process;
    }

    public void setProcess(String process) {
        this.process = process;
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
                "alarm_id=" + alarm_id +
                ", user_id='" + user_id + '\'' +
                ", message='" + message + '\'' +
                ", type=" + type +
                ", create_date=" + create_date +
                ", formattedDate='" + formattedDate + '\'' +
                ", gathering_id=" + gathering_id +
                ", read='" + read + '\'' +
                ", process='" + process + '\'' +
                '}';
    }
}
