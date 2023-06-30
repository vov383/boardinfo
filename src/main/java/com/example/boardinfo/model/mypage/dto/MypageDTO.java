package com.example.boardinfo.model.mypage.dto;
/*내활동 정보를 담을 dto*/
public class MypageDTO {
    private String userid;
    private String nickname;
    private String profile;
    private String join_date; /*가입일*/
    /*각 게시판 별 작성 글 수*/
    private String gCount;
    private String grCount; /*게임 평가 수*/
    private String rvCount;
    private String gaCount;
    private String tbCount;

    private String totCount;/*총 게시물 cont*/

    public String getTotCount() {
        return totCount;
    }

    public void setTotCount(String totCount) {
        this.totCount = totCount;
    }

    /*각 게시판별 댓글 작성 수*/
    private String rcCount;
    private String garCount;
    private String tbcCount;
    private String reTotCount;/*총 댓글 수 count*/

    public String getReTotCount() {
        return reTotCount;
    }

    public void setReTotCount(String reTotCount) {
        this.reTotCount = reTotCount;
    }

    /*게시판 별 좋아요 수*/
    private String grlLikeCount;
    private String rvgLikeCount;

    private String likeTotCount;/*총 좋아요 수 count*/

    public String getLikeTotCount() {
        return likeTotCount;
    }

    public void setLikeTotCount(String likeTotCount) {
        this.likeTotCount = likeTotCount;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getJoin_date() {
        return join_date;
    }

    public void setJoin_date(String join_date) {
        this.join_date = join_date;
    }

    public String getgCount() {
        return gCount;
    }

    public void setgCount(String gCount) {
        this.gCount = gCount;
    }

    public String getGrCount() {
        return grCount;
    }

    public void setGrCount(String grCount) {
        this.grCount = grCount;
    }

    public String getRvCount() {
        return rvCount;
    }

    public void setRvCount(String rvCount) {
        this.rvCount = rvCount;
    }

    public String getGaCount() {
        return gaCount;
    }

    public void setGaCount(String gaCount) {
        this.gaCount = gaCount;
    }

    public String getTbCount() {
        return tbCount;
    }

    public void setTbCount(String tbCount) {
        this.tbCount = tbCount;
    }

    public String getRcCount() {
        return rcCount;
    }

    public void setRcCount(String rcCount) {
        this.rcCount = rcCount;
    }

    public String getGarCount() {
        return garCount;
    }

    public void setGarCount(String garCount) {
        this.garCount = garCount;
    }

    public String getTbcCount() {
        return tbcCount;
    }

    public void setTbcCount(String tbcCount) {
        this.tbcCount = tbcCount;
    }

    public String getGrlLikeCount() {
        return grlLikeCount;
    }

    public void setGrlLikeCount(String grlLikeCount) {
        this.grlLikeCount = grlLikeCount;
    }

    public String getRvgLikeCount() {
        return rvgLikeCount;
    }

    public void setRvgLikeCount(String rvgLikeCount) {
        this.rvgLikeCount = rvgLikeCount;
    }
}