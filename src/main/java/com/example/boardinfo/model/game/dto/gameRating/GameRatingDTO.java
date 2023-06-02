package com.example.boardinfo.model.game.dto.gameRating;

public class GameRatingDTO {
    private int gnum;
    private String userid;
    private int rating;
    private int weight;
    private int participant1;
    private int participant2;
    private int participant3;
    private int participant4;
    private int participant5;
    private String rating_comment;

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public int getGnum() {
        return gnum;
    }

    public void setGnum(int gnum) {
        this.gnum = gnum;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public int getParticipant1() {
        return participant1;
    }

    public void setParticipant1(int participant1) {
        this.participant1 = participant1;
    }

    public int getParticipant2() {
        return participant2;
    }

    public void setParticipant2(int participant2) {
        this.participant2 = participant2;
    }

    public int getParticipant3() {
        return participant3;
    }

    public void setParticipant3(int participant3) {
        this.participant3 = participant3;
    }

    public int getParticipant4() {
        return participant4;
    }

    public void setParticipant4(int participant4) {
        this.participant4 = participant4;
    }

    public int getParticipant5() {
        return participant5;
    }

    public void setParticipant5(int participant5) {
        this.participant5 = participant5;
    }

    public String getRating_comment() {
        return rating_comment;
    }

    public void setRating_comment(String rating_comment) {
        this.rating_comment = rating_comment;
    }
    
    @Override
    public String toString() {
        return "GameRatingDTO{" +
                "gnum=" + gnum +
                ", userid='" + userid + '\'' +
                ", rating=" + rating +
                ", weight=" + weight +
                ", participant1=" + participant1 +
                ", participant2=" + participant2 +
                ", participant3=" + participant3 +
                ", participant4=" + participant4 +
                ", participant5=" + participant5 +
                ", rating_comment='" + rating_comment + '\'' +
                '}';
    }

}
