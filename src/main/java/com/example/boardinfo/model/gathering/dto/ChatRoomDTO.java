package com.example.boardinfo.model.gathering.dto;

import java.util.Date;

public class ChatRoomDTO {

    private int gathering_id;
    private long unread;
    private Date last_visit;


    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public long getUnread() {
        return unread;
    }

    public void setUnread(long unread) {
        this.unread = unread;
    }

    public Date getLast_visit() {
        return last_visit;
    }

    public void setLast_visit(Date last_visit) {
        this.last_visit = last_visit;
    }


    @Override
    public String toString() {
        return "ChatRoomDTO{" +
                "gathering_id=" + gathering_id +
                ", unread=" + unread +
                ", last_visit=" + last_visit +
                '}';
    }
}
