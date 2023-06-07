package com.example.boardinfo.model.review.dto;

public class PageDTO {

    private int nowPage;                 // 현재 페이지
    private int startPage;               // 화면 페이지 시작 번호
    private int endPage;                 // 화면 페이지 마지막 번호
    private int cntPage;                 // 화면 페이지 개수
    private int total;                   // 쿼리 리스트 총 개수
    private int cntPerPage;              // 쿼리 리스트 개수
    private int lastPage;                // 마지막 번호 (시작번호는 1로고정)
    private int start;                   // 쿼리 리스트 변수
    private int end;                     // 쿼리 리스트 변수

    public int getNowPage() {
        return nowPage;
    }

    public void setNowPage(int nowPage) {
        this.nowPage = nowPage;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getCntPage() {
        return cntPage;
    }

    public void setCntPage(int cntPage) {
        this.cntPage = cntPage;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getCntPerPage() {
        return cntPerPage;
    }

    public void setCntPerPage(int cntPerPage) {
        this.cntPerPage = cntPerPage;
    }

    public int getLastPage() {
        return lastPage;
    }

    public void setLastPage(int lastPage) {
        this.lastPage = lastPage;
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
}