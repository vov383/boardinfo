package com.example.boardinfo.model.mypage.dao;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class MypageDAOImpl implements MypageDAO{

    @Inject
    SqlSession sqlSession;

    @Override
    public MypageDTO getUserInfo(String userid) {
        return sqlSession.selectOne("mypage.getUserInfo", userid);
    }

    /*user가 평가한 게임 목록 가져오기*/
    @Override
    public List<GameRatingDTO> getRateListbyUserid(String userid) {
        return sqlSession.selectList("mypage.rateListbyUserid", userid);
    }
    /*리뷰 list를 userid로 가져오는 방식*/
    @Override
    public List<ReviewDTO> getRvListByUserid(String userid) {
        return sqlSession.selectList("mypage.rvListByUserid", userid);
    }
    /*모임 list를 userid로 get*/
    @Override
    public List<GatheringDTO> getGaListByUserid(String userid) {
        return sqlSession.selectList("mypage.gaListByUserid", userid);
    }
    /*중고거래 list by userid*/
    @Override
    public List<TBoardDTO> getTbListByUserid(String userid) {
        return sqlSession.selectList("mypage.getTbList",userid);

    }


}
