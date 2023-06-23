package com.example.boardinfo.controller.member;

import com.example.boardinfo.model.member.dto.MemberDTO;
import com.example.boardinfo.service.member.MemberService;
import com.example.boardinfo.service.member.MypageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
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
    @GetMapping("goMypage/{userid}")
    public ModelAndView moveToMyPage(@PathVariable(value="userid") String userid, ModelAndView mav) throws Exception{
        try {
            MemberDTO dto = memberService.viewMember(userid);
            Map<String, Object> map = new HashMap<>();
            map.put("dto", dto);

            mav.setViewName("member/mypage");
//			logger.info("@@@mav =>>"+mav+"@@@@@@@@@");

            mav.addObject("map", map);
//			logger.info("@@@mav =>>"+mav+"@@@@@@@@@");
            return mav;
        }catch (Exception e){
            e.printStackTrace();
            return new ModelAndView("home");

        }

    }

    /* ajax로 유저의 postList를 get하는 */
    @RequestMapping("getPostList")
    @ResponseBody
    public Map<String, Object> getList(
            @RequestParam String userid) {
        logger.info("@@@ userid 잘 넘어오니 : " + userid + "@@@");
        Map<String, Object> map = mypageService.getPostList(userid);

        logger.info("@@@ map 잘 넘어오니 : " + map + "@@@");
        return map;
    }

    /*컬렉션 아마도*/
    @RequestMapping("collection")
    public ModelAndView collection(ModelAndView mav){
        mav.setViewName("member/collection");
        return mav;
    }
}
