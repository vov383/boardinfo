package com.example.boardinfo.controller.member;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.model.mypage.dto.MypageDTO;
import com.example.boardinfo.model.mypage.dto.MypageGameDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
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
import java.util.List;
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
    public ModelAndView moveToMyPage(@RequestParam(value="sessionUserid") String SessionUserid, ModelAndView mav) {
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
    public ModelAndView getGiList(@RequestParam String userid){
        ModelAndView mav = new ModelAndView();
        List<GameDTO> giList = mypageService.getGiList(userid);
        mav.setViewName("mypage/giTabbed");
        mav.addObject("giList", giList);
        return mav;
    }

    @RequestMapping("getGiMore")
    @ResponseBody
    public ModelAndView getGiMore(@RequestParam String userid, ModelAndView mav){
        List<MypageGameDTO> giMore = mypageService.getGiMore(userid);
        mav.setViewName("mypage/giMore");
        mav.addObject("giMore", giMore);
        return mav;
    }

    @RequestMapping("getGrList")
    @ResponseBody
    public ModelAndView getGrList(@RequestParam String userid){
        ModelAndView mav = new ModelAndView();
        List<GameRatingDTO> grList = mypageService.getGrList(userid);
        mav.setViewName("mypage/grTabbed");
        mav.addObject("grList", grList);
        return mav;
    }
    @RequestMapping("getGrMore")
    @ResponseBody
    public ModelAndView getGrMore(@RequestParam String userid, ModelAndView mav){
        List<GameRatingDTO> grMore = mypageService.getGrMore(userid);
        mav.setViewName("mypage/grMore");
        mav.addObject("grMore", grMore);
        return mav;
    }

    @RequestMapping("getRvList")
    @ResponseBody
    public ModelAndView getRvList(@RequestParam String userid){
        ModelAndView mav = new ModelAndView();
        List<ReviewDTO> rvList = mypageService.getRvList(userid);
        mav.setViewName("mypage/rvTabbed");
        mav.addObject("rvList", rvList);
        return mav;
    }

    @RequestMapping("getRvMore")
    @ResponseBody
    public ModelAndView getRvMore(@RequestParam String userid, ModelAndView mav){
        List<ReviewDTO> rvMore = mypageService.getRvMore(userid);
        mav.setViewName("mypage/rvMore");
        mav.addObject("rvMore", rvMore);
        return mav;
    }

    @RequestMapping("getGaList")
    @ResponseBody
    public ModelAndView getGaList(@RequestParam String userid){
        ModelAndView mav = new ModelAndView();
        List<MypageDTO> gaList = mypageService.getGaList(userid);
        mav.setViewName("mypage/gaTabbed");
        mav.addObject("gaList", gaList);
        return mav;
    }

    @RequestMapping("getGaMore")
    @ResponseBody
    public ModelAndView getGaMore(@RequestParam String userid, ModelAndView mav){
        List<MypageDTO> gaMore = mypageService.getGaMore(userid);
        mav.setViewName("mypage/gaMore");
        mav.addObject("gaMore", gaMore);
        return mav;
    }

    @RequestMapping("getTrList")
    @ResponseBody
    public ModelAndView getTrList(@RequestParam String userid){
        ModelAndView mav = new ModelAndView();
        List<TBoardDTO> trList = mypageService.getTrList(userid);
        mav.setViewName("mypage/trTabbed");
        mav.addObject("trList", trList);
        return mav;
    }

    @RequestMapping("getTrMore")
    @ResponseBody
    public ModelAndView getTrMore(@RequestParam String userid, ModelAndView mav){
        List<TBoardDTO> trMore = mypageService.getTrMore(userid);
        mav.setViewName("mypage/trMore");
        mav.addObject("trMore", trMore);
        return mav;
    }

//    @RequestMapping("getTabbedList")
//    @ResponseBody
//    public ModelAndView getTabbedList(
//            @RequestParam String userid, @RequestParam String str){
//
//        mav.setViewName("mypage/giTabbed");
//        ApiResponse<JsonObject> response = new ApiResponse<>();
//
//        if(dataList.size() > 0){
//            response.setData("dataList", dataList);
//            response.setData("message", "success");
//            mav.addObject("response", response);
//        }else{
//            response.setData("message", "fail");
//            mav.addObject("response", response);
//        }
//        mav.setViewName("mypage/tabbedList");
//        return mav;
//    }


    /*컬렉션 아마도*/
    @RequestMapping("collection")
    public ModelAndView collection(ModelAndView mav){
        mav.setViewName("member/collection");
        return mav;
    }
}
