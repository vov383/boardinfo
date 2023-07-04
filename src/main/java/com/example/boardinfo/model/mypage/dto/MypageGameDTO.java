package com.example.boardinfo.model.mypage.dto;

/*마이페이지 게임인포 출력에 필요한 dto*/
public class MypageGameDTO {
    private int gnum;
    private String bggnum;
    private String gametitle;
    private String gametitle_eng;
    private String release_year;
    private String theme;
    private String bgg_thumbnail;
    private String gamephoto_url;
    private String create_date;
    private String create_user;
    private String confirmed;
    private String update_date; //수정 날짜
    private String update_user; //수정한 유저명
    private String del; //삭제여부
    private int totalviewcount; //조회수


    public int getGnum() {
        return gnum;
    }

    public void setGnum(int gnum) {
        this.gnum = gnum;
    }

    public String getBggnum() {
        return bggnum;
    }

    public void setBggnum(String bggnum) {
        this.bggnum = bggnum;
    }

    public String getGametitle() {
        return gametitle;
    }

    public void setGametitle(String gametitle) {
        this.gametitle = gametitle;
    }

    public String getGametitle_eng() {
        return gametitle_eng;
    }

    public void setGametitle_eng(String gametitle_eng) {
        this.gametitle_eng = gametitle_eng;
    }

    public String getRelease_year() {
        return release_year;
    }

    public void setRelease_year(String release_year) {
        this.release_year = release_year;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getBgg_thumbnail() {
        return bgg_thumbnail;
    }

    public void setBgg_thumbnail(String bgg_thumbnail) {
        this.bgg_thumbnail = bgg_thumbnail;
    }

    public String getGamephoto_url() {
        return gamephoto_url;
    }

    public void setGamephoto_url(String gamephoto_url) {
        this.gamephoto_url = gamephoto_url;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getCreate_user() {
        return create_user;
    }

    public void setCreate_user(String create_user) {
        this.create_user = create_user;
    }

    public String getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(String confirmed) {
        this.confirmed = confirmed;
    }

    public String getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(String update_date) {
        this.update_date = update_date;
    }

    public String getUpdate_user() {
        return update_user;
    }

    public void setUpdate_user(String update_user) {
        this.update_user = update_user;
    }

    public String getDel() {
        return del;
    }

    public void setDel(String del) {
        this.del = del;
    }

    public int getTotalviewcount() {
        return totalviewcount;
    }

    public void setTotalviewcount(int totalviewcount) {
        this.totalviewcount = totalviewcount;
    }
}
