package com.example.boardinfo.model.mypage.dao;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
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

    @Override
    public List<Object> getTabbedList(String userid, String str) {
        Map<String, String> map = new HashMap<>();
        map.put("userid", userid);
        map.put("tableName", str);
        return sqlSession.selectList("mypage.getTabbedList", map);
    }

    @Override
    public int countgetGiList(String userid) {return sqlSession.selectOne("mypage.countGetGiList", userid);}

    @Override
    public List<MypageGameDTO> gameInfoTabbed(Map<String, Object> map) {
        return sqlSession.selectList("mypage.giTabbed", map);
    }
    @Override
    public List<MypageGameDTO> gameInfoMore(String userid) {
        return sqlSession.selectList("mypage.giMore", userid);
    }
    @Override
    public List<GameRatingDTO> gameRatingTabbed(String userid) {
        return sqlSession.selectList("mypage.grTabbed", userid);
    }
    @Override
    public List<GameRatingDTO> gameRatingMore(String userid) {
        return sqlSession.selectList("mypage.grMore", userid);
    }

    @Override
    public List<ReviewDTO> reviewTabbed(String userid) {
        return sqlSession.selectList("mypage.rvTabbed", userid);
    }
    @Override
    public List<ReviewDTO> reviewMore(String userid) {
        return sqlSession.selectList("mypage.rvMore", userid);
    }
    @Override
    public List<MypageDTO> gatheringTabbed(String userid) {
        return sqlSession.selectList("mypage.gaTabbed", userid);
    }

    @Override
    public List<MypageDTO> gatheringMore(String userid) {
        return sqlSession.selectList("mypage.gaMore", userid);
    }
    @Override
    public List<TBoardDTO> tradeTabbed(String userid) {
        return sqlSession.selectList("mypage.trTabbed", userid);
    }

    @Override
    public List<TBoardDTO> tradeMore(String userid) {
        return sqlSession.selectList("mypage.trMore", userid);
    }




}
