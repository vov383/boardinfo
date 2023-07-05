package com.example.boardinfo.service.member;

import com.example.boardinfo.model.mypage.dto.MypageDTO;

import java.util.Map;

public interface MypageService {

    MypageDTO getUserInfo(String userid);

    Map<String, Object> getPostList(String userid);

//    List<Object> getTabbedList(String uesrid, String str);

    Map<String, Object> getGiList(String userid, int curPage);
    Map<String, Object> getGrList(String userid, int curPage);
    Map<String, Object> getRvList(String userid, int curPage);
    Map<String, Object> getGaList(String userid, int curPage);
    Map<String, Object> getTrList(String userid, int curPage);


    Map<String, Object> getReList(String userid, int curPage);

    Map<String, Object> getLikeList(String userid, int curPage);
}
