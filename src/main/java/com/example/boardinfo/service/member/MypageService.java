package com.example.boardinfo.service.member;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

import java.util.List;
import java.util.Map;

public interface MypageService {

    MypageDTO getUserInfo(String userid);

    Map<String, Object> getPostList(String userid);

//    List<Object> getTabbedList(String uesrid, String str);

    Map<String, Object> getGiList(String userid, int curPage);

    List<MypageGameDTO> getGiMore(String userid);

    List<GameRatingDTO> getGrList(String userid);

    List<GameRatingDTO> getGrMore(String userid);

    List<ReviewDTO> getRvList(String userid);

    List<ReviewDTO> getRvMore(String userid);

    List<MypageDTO> getGaList(String userid);
    List<MypageDTO> getGaMore(String userid);
    List<TBoardDTO> getTrList(String userid);
    List<TBoardDTO> getTrMore(String userid);


}
