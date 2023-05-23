package com.example.boardinfo.model.game.dto.publisher;

public class PublisherDTO {

    private int pnum;
    private String publisher;

    public PublisherDTO() {}

    public PublisherDTO(int pnum, String publisher) {
        this.pnum = pnum;
        this.publisher = publisher;
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

    @Override
    public String toString() {
        return "PublisherDTO{" +
                "pnum=" + pnum +
                ", publisher='" + publisher + '\'' +
                '}';
    }
}
