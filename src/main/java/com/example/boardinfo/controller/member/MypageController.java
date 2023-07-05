package com.example.boardinfo.controller.member;

import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.service.member.MemberService;
import com.example.boardinfo.service.member.MypageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("mypage/*")
public class MypageController {
    private static final Logger logger
            = LoggerFactory.getLogger(MypageController.class);
    @Inject
    MypageService mypageService;
    @Inject
    MemberService memberService;

    /*마이페이지로 이동*/
    @RequestMapping(value = "goMypage")
    public ModelAndView moveToMyPage(@RequestParam(value = "sessionUserid") String SessionUserid, ModelAndView mav) {
        String userid = SessionUserid;
        MypageDTO myDto = mypageService.getUserInfo(userid);
        Map<String, Object> map = new HashMap<>();
        map.put("myDto", myDto);

        mav.setViewName("mypage/mypage");

        mav.addObject("map", map);

        return mav;

    }

    /* ajax로 유저의 postList를 get하는 */
    @RequestMapping("getPostList.do")
    @ResponseBody
    public ModelAndView getList(
            @RequestParam String userid) {
        Map<String, Object> map = mypageService.getPostList(userid);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/loadAllPost");
        mav.addObject("map", map);

        return mav;
    }

    @RequestMapping("getGiList")
    @ResponseBody
    public ModelAndView getGiList(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> response = mypageService.getGiList(userid, curPage);
        mav.setViewName("mypage/giTabbed");
        mav.addObject("response", response);
        return mav;
    }
    @RequestMapping("getGrList")
    @ResponseBody
    public ModelAndView getGrList(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> response = mypageService.getGrList(userid, curPage);
        mav.setViewName("mypage/grTabbed");
        mav.addObject("response", response);

        return mav;
    }
    @RequestMapping("getRvList")
    @ResponseBody
    public ModelAndView getRvList(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> response = mypageService.getRvList(userid, curPage);
        mav.setViewName("mypage/rvTabbed");
        mav.addObject("response", response);

        return mav;
    }
    @RequestMapping("getGaList")
    @ResponseBody
    public ModelAndView getGaList(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> response = mypageService.getGaList(userid, curPage);
        mav.setViewName("mypage/gaTabbed");
        mav.addObject("response", response);
        return mav;
    }

    @RequestMapping("getTrList")
    @ResponseBody
    public ModelAndView getTrList(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> response = mypageService.getTrList(userid, curPage);

        mav.setViewName("mypage/trTabbed");
        mav.addObject("response", response);

        return mav;
    }


    /*댓글 목록*/
    @RequestMapping("getMyReply")
    @ResponseBody
    public ModelAndView getMyReply(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage){
        Map<String, Object> response = mypageService.getReList(userid, curPage);

        ModelAndView mav = new ModelAndView();

        mav.setViewName("mypage/replyTabbed");
        mav.addObject("response", response);
        return mav;
    }

    /*좋아요 목록*/
    @RequestMapping("getMyLike")
    @ResponseBody
    public ModelAndView getMyLike(@RequestParam String userid, @RequestParam(value="curPage", defaultValue = "1") int curPage){
        Map<String, Object> response = mypageService.getLikeList(userid, curPage);
        ModelAndView mav = new ModelAndView();

        mav.setViewName("mypage/likeTabbed");
        mav.addObject("response", response);
        return mav;
    }


}
