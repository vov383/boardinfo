package com.example.boardinfo.model.gathering.dto;

import java.util.Date;


public class GatheringReplyDTO {

    private int reply_id;
    private int gathering_id;
    private Integer parent_reply;
    private Integer mother_reply;
    private int inner_order;
    private int depth;
    private String reply_text;
    private String creator_id;
    private Date create_date;
    private String updater_id;
    private Date update_date;
    private String nickname;

    public int getReply_id() {
        return reply_id;
    }

    public void setReply_id(int reply_id) {
        this.reply_id = reply_id;
    }

    public int getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(int gathering_id) {
        this.gathering_id = gathering_id;
    }

    public Integer getParent_reply() {
        return parent_reply;
    }

    public void setParent_reply(Integer parent_reply) {
        this.parent_reply = parent_reply;
    }

    public Integer getMother_reply() {
        return mother_reply;
    }

    public void setMother_reply(Integer mother_reply) {
        this.mother_reply = mother_reply;
    }

    public int getInner_order() {
        return inner_order;
    }

    public void setInner_order(int inner_order) {
        this.inner_order = inner_order;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    public String getReply_text() {
        return reply_text;
    }

    public void setReply_text(String reply_text) {
        this.reply_text = reply_text;
    }

    public String getCreator_id() {
        return creator_id;
    }

    public void setCreator_id(String creator_id) {
        this.creator_id = creator_id;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public String getUpdater_id() {
        return updater_id;
    }

    public void setUpdater_id(String updater_id) {
        this.updater_id = updater_id;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "GatheringReplyDTO{" +
                "reply_id=" + reply_id +
                ", gathering_id=" + gathering_id +
                ", parent_reply=" + parent_reply +
                ", mother_reply=" + mother_reply +
                ", inner_order=" + inner_order +
                ", depth=" + depth +
                ", reply_text='" + reply_text + '\'' +
                ", creator_id='" + creator_id + '\'' +
                ", create_date=" + create_date +
                ", updater_id='" + updater_id + '\'' +
                ", update_date=" + update_date +
                ", nickname='" + nickname + '\'' +
                '}';
    }
}