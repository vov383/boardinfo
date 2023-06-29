package com.example.boardinfo.model.gathering.dto;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;

import java.util.Date;

public class ChatRoomDTO {

    private String title;
    private int gathering_id;
    private boolean unread;
    private Date last_visit;
    private String finishChat;
    private int attendee_count;

    private ChatMessageDTO lastChat;




    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public Date getLast_visit() {
        return last_visit;
    }

    public void setLast_visit(Date last_visit) {
        this.last_visit = last_visit;
    }

    public String getFinishChat() {
        return finishChat;
    }

    public void setFinishChat(String finishChat) {
        this.finishChat = finishChat;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isUnread() {
        return unread;
    }

    public void setUnread(boolean unread) {
        this.unread = unread;
    }

    public int getAttendee_count() {
        return attendee_count;
    }

    public void setAttendee_count(int attendee_count) {
        this.attendee_count = attendee_count;
    }

    public ChatMessageDTO getLastChat() {
        return lastChat;
    }

    public void setLastChat(ChatMessageDTO lastChat) {
        this.lastChat = lastChat;
    }

    @Override
    public String toString() {
        return "ChatRoomDTO{" +
                "title='" + title + '\'' +
                ", gathering_id=" + gathering_id +
                ", unread=" + unread +
                ", last_visit=" + last_visit +
                ", finishChat='" + finishChat + '\'' +
                ", attendee_count=" + attendee_count +
                '}';
    }


}
