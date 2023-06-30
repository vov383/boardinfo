package com.example.boardinfo.service.member;

import com.example.boardinfo.model.mypage.dto.MypageDTO;

import java.util.Map;

public interface MypageService {

    MypageDTO getUserInfo(String userid);

    Map<String, Object> getPostList(String userid);

}
