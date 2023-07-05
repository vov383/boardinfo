package com.example.boardinfo.model.mypage.dao;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dto.MyLikeDTO;
import com.example.boardinfo.model.mypage.dto.MyReplyDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

import java.util.List;
import java.util.Map;

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

    /*페이징을 위한 count*/
    int getGiCount(String userid);

    int getGaCount(String userid);

    int getTrCount(String userid);

    int getGrCount(String userid);

    int getRvCount(String userid);
    int getReCount(String userid);
    int getLikeCount(String userid);

    /*탭으로 페이징 처리된 목록 출력*/
    List<MypageGameDTO> gameInfoTabbed(Map<String, Object> map);
    List<GameRatingDTO> gameRatingTabbed(Map<String, Object> map);
    List<ReviewDTO> reviewTabbed(Map<String, Object> userid);
    List<MypageDTO> gatheringTabbed(Map<String, Object> map);
    List<TBoardDTO> tradeTabbed(Map<String, Object> map);

    List<MyReplyDTO> replyTabbed(Map<String, Object> map);

    List<MyLikeDTO> likeTabbed(Map<String, Object> map);
}
