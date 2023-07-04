package com.example.boardinfo.model.mypage.dao;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

import java.util.List;

public interface MypageDAO {
    MypageDTO getUserInfo(String userid);

    /*user가 평가한 게임 목록 가져오기*/
    List<GameRatingDTO> getRateListbyUserid(String userid);

    /*리뷰 list를 userid로 가져오는 방식*/
    List<ReviewDTO> getRvListByUserid(String userid);

    /*모임 list를 userid로 get*/
    List<GatheringDTO> getGaListByUserid(String userid);

    /*중고거래 list by userid*/
    List<TBoardDTO> getTbListByUserid(String userid);

    List<Object> getTabbedList(String userid, String str);

    List<GameDTO> gameInfoTabbed(String userid);

    List<GameRatingDTO> gameRatingTabbed(String userid);

    List<ReviewDTO> reviewTabbed(String userid);

    List<TBoardDTO> tradeTabbed(String userid);

    List<MypageGameDTO> gameInfoMore(String userid);

    List<GameRatingDTO> gameRatingMore(String userid);

    List<ReviewDTO> reviewMore(String userid);

    List<TBoardDTO> tradeMore(String userid);

    List<MypageDTO> gatheringTabbed(String userid);

    List<MypageDTO> gatheringMore(String userid);
}
