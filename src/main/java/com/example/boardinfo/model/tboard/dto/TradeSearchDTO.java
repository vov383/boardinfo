package com.example.boardinfo.model.tboard.dto;

public class TradeSearchDTO {
    private String searchTitle;			// 제목 및 내용 검색
    private String category;			// 카테고리
    
    private String search_option; /*검색 옵션*/
    private String keyword; /*검색 키워드*/
    private int curPage; /*현재 페이지*/
    private String create_user;		/*작성자 id*/
    private String nickname;    /*작성자 닉네임*/
    private String tb_num;		/*tb_num 키*/
    private int start;   /*쿼리 리스트 변수*/
    private int end;     /*쿼리 리스트 변수*/
    private String reply_reg_num;   /*답글 키*/
    private String goodkey; /*좋아요 키*/

    public String getSearchTitle() {
        return searchTitle;
    }
    
    public void setSearchTitle(String searchTitle) {
        this.searchTitle = searchTitle;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSearch_option() {
        return search_option;
    }
    
    public void setSearch_option(String search_option) {
        this.search_option = search_option;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getCurPage() {
        return curPage;
    }

    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }

    public String getCreate_user() {
        return create_user;
    }

    public void setCreate_user(String create_user) {
        this.create_user = create_user;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getTb_num() {
        return tb_num;
    }

    public void setTb_num(String tb_num) {
        this.tb_num = tb_num;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public String getReply_reg_num() {
        return reply_reg_num;
    }

    public void setReply_reg_num(String reply_reg_num) {
        this.reply_reg_num = reply_reg_num;
    }

    public void setGoodkey(String goodkey) {
        this.goodkey = goodkey;
    }

    public String getGoodkey() {
        return goodkey;
    }

    @Override
    public String
    toString() {
        return "TradeSearchDTO{" +
                "searchTitle='" + searchTitle + '\'' +
                ", category='" + category + '\'' +
                ", search_option='" + search_option + '\'' +
                ", keyword='" + keyword + '\'' +
                ", curPage=" + curPage +
                ", create_user='" + create_user + '\'' +
                ", nickname='" + nickname + '\'' +
                ", tb_num='" + tb_num + '\'' +
                ", start=" + start +
                ", end=" + end +
                ", reply_reg_num='" + reply_reg_num + '\'' +
                ", goodkey='" + goodkey + '\'' +
                '}';
    }


}
