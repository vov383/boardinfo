package com.example.boardinfo.service.member;

import com.example.boardinfo.controller.tboard.TBCommentController;
import com.example.boardinfo.model.game.dao.gameRating.GameRatingDAO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dao.MypageDAO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MypageServiceImpl implements MypageService {

    @Inject
    MypageDAO mypageDao;

    @Inject
    GameRatingDAO gameRatingDao;

    @Inject
    ReviewDAO reviewDao;

    @Inject
    GatheringDAO gatheringDao;

    @Inject
    TBoardDAO tboardDao;


    private static final Logger logger
            = LoggerFactory.getLogger(TBCommentController.class);

    @Override
    public MypageDTO getUserInfo(String userid) {
        MypageDTO myDto = mypageDao.getUserInfo(userid);
        /*전체 게시물 수*/
        return myDto;
    }

    @Override
    public Map<String, Object> getPostList(String userid) {

        /*게임 평가 리스트*/
        List<GameRatingDTO> grList = mypageDao.getRateListbyUserid(userid);
        /*리뷰 게시판 리스트*/
        List<ReviewDTO> rvList = mypageDao.getRvListByUserid(userid);
        /*모임 게시판 리스트*/
        List<GatheringDTO> gaList= mypageDao.getGaListByUserid(userid);
        /*중고거래 게시판 리스트*/
        List<TBoardDTO> tbList = mypageDao.getTbListByUserid(userid);

        /*list들을 담을 맵 생성*/
        Map<String, Object> map = new HashMap<>();

        map.put("grList", grList);
        map.put("rvList", rvList);
        map.put("gaList", gaList);
        map.put("tbList", tbList);
        return map;
    }


}
