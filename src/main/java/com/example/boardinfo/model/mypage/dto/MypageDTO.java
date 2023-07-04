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
    private String galLikeCount;
    private String trgLikeCount;

    private String likeTotCount;/*총 좋아요 수 count*/

    /*오프모임 게시판 dto*/
    private String gathering_id;
    private String create_date;
    private String title;
    private String create_user;
    private String gathering_date;
    private String address1;
    private String address2;
    private String place_name;
    private String maxpeople;
    private String attendee_count;
    private String view_count;


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

    public String getGalLikeCount() {
        return galLikeCount;
    }

    public void setGalLikeCount(String galLikeCount) {
        this.galLikeCount = galLikeCount;
    }

    public String getTrgLikeCount() {
        return trgLikeCount;
    }

    public void setTrgLikeCount(String trgLikeCount) {
        this.trgLikeCount = trgLikeCount;
    }

    public String getLikeTotCount() {
        return likeTotCount;
    }

    public void setLikeTotCount(String likeTotCount) {
        this.likeTotCount = likeTotCount;
    }

    public String getGathering_id() {
        return gathering_id;
    }

    public void setGathering_id(String gathering_id) {
        this.gathering_id = gathering_id;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreate_user() {
        return create_user;
    }

    public void setCreate_user(String create_user) {
        this.create_user = create_user;
    }

    public String getGathering_date() {
        return gathering_date;
    }

    public void setGathering_date(String gathering_date) {
        this.gathering_date = gathering_date;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getPlace_name() {
        return place_name;
    }

    public void setPlace_name(String place_name) {
        this.place_name = place_name;
    }

    public String getMaxpeople() {
        return maxpeople;
    }

    public void setMaxpeople(String maxpeople) {
        this.maxpeople = maxpeople;
    }

    public String getAttendee_count() {
        return attendee_count;
    }

    public void setAttendee_count(String attendee_count) {
        this.attendee_count = attendee_count;
    }

    public String getView_count() {
        return view_count;
    }

    public void setView_count(String view_count) {
        this.view_count = view_count;
    }
}