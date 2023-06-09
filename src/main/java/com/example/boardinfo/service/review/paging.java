package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dto.PageDTO;

public class paging {

    /*페이징 초기화*/
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


    /*페이지 계산*/
    public static PageDTO Paginggeqwjg(PageDTO page, int cnt) {

        /*쿼리 총 개수*/
        page.setTotal(cnt);

        /*마지막 페이지 (올림함수(쿼리총개수 / 쿼리 리스트 개수)) */
        page.setLastPage((int)Math.ceil((double)cnt / (double)page.getCntPerPage()));

        /*화면 페이지 가로 마지막 번호 (현재 페이지 + 화면 페이지 개수)*/
        page.setEndPage(page.getNowPage() + page.getCntPage() - 1);

        /*화면 페이지 가로 시작 번호 (화면 페이지 가로 마지막 번호 - 화면 페이지 개수)*/
        page.setStartPage(page.getEndPage() - page.getCntPage() + 1);

        /*쿼리 리스트 변수 (현재 페이지 * 쿼리 리스트 개수)*/
        page.setEnd(page.getNowPage() * page.getCntPerPage());

        /*쿼리 스타트 리스트 변수 (쿼리 리스트 변수 - 쿼리 리스트 개수)*/
        page.setStart(page.getEnd()-page.getCntPerPage()+1);

        /*쿼리 엔드 리스트 변수(최소값 함수(화면 페이지 가로 마지막 번호 및 마지막 페이지)*/
        page.setEndPage(Math.min(page.getEndPage(), page.getLastPage()));

        return page;
    }





}
