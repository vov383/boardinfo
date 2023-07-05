package com.example.boardinfo.service.member;

import com.example.boardinfo.controller.tboard.TBCommentController;
import com.example.boardinfo.model.game.dao.gameRating.GameRatingDAO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.gathering.dao.GatheringDAO;
import com.example.boardinfo.model.gathering.dto.GatheringDTO;
import com.example.boardinfo.model.mypage.dao.MypageDAO;
import com.example.boardinfo.model.mypage.dto.MyLikeDTO;
import com.example.boardinfo.model.mypage.dto.MyReplyDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.util.Pager;
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
    /*마이페이지 첫 화면의 회원정보 출력*/
    @Override
    public MypageDTO getUserInfo(String userid) {
        MypageDTO myDto = mypageDao.getUserInfo(userid);
        /*전체 게시물 수*/
        return myDto;
    }
    /*마이페이지 첫화면의 회원 작성 글 게시판별 6개씩 출력*/
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

    /*게시판 탭마다 회원이 작성한 글 10개씩 페이징 처리해서 출력*/
    @Override
    public Map<String, Object> getGiList(String userid, int curPage) {
        Map<String, Object> map = new HashMap<>();
        int count = mypageDao.getGiCount(userid);
        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();
        map.put("start", start);
        map.put("end", end);
        map.put("userid", userid);
        List<MypageGameDTO> giList = mypageDao.gameInfoTabbed(map);
        map.put("pager", pager);
        map.put("giList", giList);
        return map;
    }


    @Override
    public Map<String, Object> getGrList(String userid, int curPage) {
        Map<String, Object> map = new HashMap<>();
        int count = mypageDao.getGrCount(userid);
        Pager pager = new Pager(count, curPage, 10);
        int Start = pager.getPageBegin();
        int end = pager.getPageEnd();
        map.put("start", Start);
        map.put("end", end);
        map.put("userid", userid);
        List<GameRatingDTO> grList = mypageDao.gameRatingTabbed(map);
        map.put("pager", pager);
        map.put("grList", grList);

        return map;
    }


    @Override
    public Map<String, Object> getRvList(String userid, int curPage) {
        Map<String, Object> map = new HashMap<>();

        int count = mypageDao.getRvCount(userid);

        Pager pager = new Pager(count, curPage, 10);
        int Start = pager.getPageBegin();
        int end = pager.getPageEnd();
        map.put("start", Start);
        map.put("end", end);
        map.put("userid", userid);
        List<ReviewDTO> rvList = mypageDao.reviewTabbed(map);
        map.put("pager", pager);
        map.put("rvList", rvList);

        return map;
    }


    @Override
    public Map<String, Object> getGaList(String userid, int curPage) {

        Map<String, Object> map = new HashMap<>();

        int count = mypageDao.getGaCount(userid);

        Pager pager = new Pager(count, curPage, 10);
        int Start = pager.getPageBegin();
        int end = pager.getPageEnd();
        map.put("start", Start);
        map.put("end", end);
        map.put("userid", userid);

        List<MypageDTO> gaList = mypageDao.gatheringTabbed(map);
        map.put("pager", pager);
        map.put("gaList", gaList);

        return map;

    }

    @Override
    public Map<String, Object> getTrList(String userid, int curPage) {

        /*tr count 값 구하고*/
        int count = mypageDao.getTrCount(userid);

        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();

        Map<String, Object> map = new HashMap<>();
        map.put("userid", userid);
        map.put("start", start);
        map.put("end", end);

        List<TBoardDTO> trList = mypageDao.tradeTabbed(map);

        map.put("trList", trList);
        map.put("pager", pager);
        map.put("count", count);
        map.put("curPage", curPage);

        return map;
    }


    @Override
    public Map<String, Object> getReList(String userid, int curPage) {
        int count = mypageDao.getReCount(userid);
        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();
        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);
        map.put("userid", userid);

        List<MyReplyDTO> reList = mypageDao.replyTabbed(map);
        map.put("pager", pager);
        map.put("reList", reList);

        return map;
    }

    @Override
    public Map<String, Object> getLikeList(String userid, int curPage) {
        int count = mypageDao.getLikeCount(userid);
        Pager pager = new Pager(count, curPage, 10);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();
        Map<String, Object> map = new HashMap<>();
        map.put("start", start);
        map.put("end", end);
        map.put("userid", userid);

        List<MyLikeDTO> likeList = mypageDao.likeTabbed(map);
        map.put("pager", pager);
        map.put("likeList", likeList);

        return map;
    }


}
