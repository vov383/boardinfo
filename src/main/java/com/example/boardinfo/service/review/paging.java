package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dto.PageDTO;

public class paging {

    // 페이징 초기화
    public static PageDTO Paging(PageDTO page) {

        /*현재 페이지 : 시작 값 1로 초기화*/
        if(page.getNowPage() == 0){
            page.setNowPage(1);
        }

        /*화면 페이지 가로 - 시작 값 10으로 초기화*/
        if(page.getCntPage() == 0){
            page.setCntPage(10);
        }

        /*화면 페이지 세로 - 시작 값 10으로 초기화*/
        if(page.getCntPerPage() == 0){
            page.setCntPerPage(10);
        }

        return page;
    }


    public static PageDTO Paginggeqwjg(PageDTO page, int cnt) {

        page.setTotal(cnt);
        page.setLastPage((int)Math.ceil((double)cnt / (double)page.getCntPerPage()));
        page.setEndPage(page.getNowPage() + page.getCntPage() - 1);
        page.setStartPage(page.getEndPage() - page.getCntPage() + 1);
        page.setEnd(page.getNowPage() * page.getCntPerPage());
        page.setStart(page.getEnd()-page.getCntPerPage()+1);

        page.setEndPage(Math.min(page.getEndPage(), page.getLastPage()));

        return page;
    }





}
