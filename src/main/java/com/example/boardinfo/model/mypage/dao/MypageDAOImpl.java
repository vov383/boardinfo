package com.example.boardinfo.model.mypage.dao;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dto.MyLikeDTO;
import com.example.boardinfo.model.mypage.dto.MyReplyDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

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

    /*목록 페이징을 위한 카운트*/
    @Override
    public int getGiCount(String userid) {
        return sqlSession.selectOne("mypage.countGiList", userid);
    }

    @Override
    public int getGrCount(String userid) {
        return sqlSession.selectOne("mypage.countGrList", userid);
    }

    @Override
    public int getRvCount(String userid) {
        return sqlSession.selectOne("mypage.countRvList", userid);
    }

    @Override
    public int getGaCount(String userid) {
        return sqlSession.selectOne("mypage.countGaList", userid);
    }

    @Override
    public int getTrCount(String userid) {
        return sqlSession.selectOne("mypage.countTrList", userid);
    }


    @Override
    public int getReCount(String userid) {
        return sqlSession.selectOne("mypage.countReList", userid);
    }

    @Override
    public int getLikeCount(String userid) {
        return sqlSession.selectOne("mypage.countLikeList", userid);
    }
    
    /*페이징 처리된 목록*/
    @Override
    public List<MypageGameDTO> gameInfoTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.giTabbed", map);
    }
    @Override
    public List<GameRatingDTO> gameRatingTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.grTabbed", map);
    }

    @Override
    public List<ReviewDTO> reviewTabbed(Map<String, Object> userid) {
        return sqlSession.selectList("mypage.rvTabbed", userid);
    }
    @Override
    public List<MypageDTO> gatheringTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.gaTabbed", map);
    }
    @Override
    public List<TBoardDTO> tradeTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.trTabbed", map);
    }

    @Override
    public List<MyReplyDTO> replyTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.myReply", map);
    }

    @Override
    public List<MyLikeDTO> likeTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.myLike", map);
    }


}
