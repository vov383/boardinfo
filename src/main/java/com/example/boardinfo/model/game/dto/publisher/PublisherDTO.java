package com.example.boardinfo.model.game.dto.publisher;

public class PublisherDTO {

    private int pnum;
    private String publisher;
    private String userid;

    public PublisherDTO() {}

    @Override
    public String toString() {
        return "PublisherDTO{" +
                "pnum=" + pnum +
                ", publisher='" + publisher + '\'' +
                ", userid='" + userid + '\'' +
                '}';
    }

    public int getPnum() {
        return pnum;
    }

    public void setPnum(int pnum) {
        this.pnum = pnum;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public PublisherDTO(int pnum, String publisher, String userid) {
        this.pnum = pnum;
        this.publisher = publisher;
        this.userid = userid;
    }
}
