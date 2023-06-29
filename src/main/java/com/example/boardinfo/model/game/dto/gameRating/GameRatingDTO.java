package com.example.boardinfo.model.game.dto.gameRating;

public class GameRatingDTO {
    private int gnum;
    private String userid;
    private String nickname;
    private float rating;
    private float weight;
    private int participant1;
    private int participant2;
    private int participant3;
    private int participant4;
    private int participant5;
    private String rating_comment;
    private int likeCount;
    private int myLike;

    private String create_date;
    private String update_date;


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

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
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

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getMyLike() {
        return myLike;
    }

    public void setMyLike(int myLike) {
        this.myLike = myLike;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(String update_date) {
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
        return "GameRatingDTO{" +
                "gnum=" + gnum +
                ", userid='" + userid + '\'' +
                ", nickname='" + nickname + '\'' +
                ", rating=" + rating +
                ", weight=" + weight +
                ", participant1=" + participant1 +
                ", participant2=" + participant2 +
                ", participant3=" + participant3 +
                ", participant4=" + participant4 +
                ", participant5=" + participant5 +
                ", rating_comment='" + rating_comment + '\'' +
                ", likeCount=" + likeCount +
                ", myLike=" + myLike +
                ", create_date='" + create_date + '\'' +
                ", update_date='" + update_date + '\'' +
                '}';
    }
}
