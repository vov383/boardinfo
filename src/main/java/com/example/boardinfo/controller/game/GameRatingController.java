package com.example.boardinfo.controller.game;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.service.game.GameRatingService;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("gameRating/*")
public class GameRatingController {

    @Inject
    GameRatingService gameRatingService;


    @ResponseBody
    @RequestMapping("add.do")
    public String ratingAdd(@RequestParam HashMap rating, HttpSession session){
    	String userid = (String) session.getAttribute("userid");
        rating.put("userid", userid);
        System.out.println("gnum은 " + rating.get("gnum"));
        int num = gameRatingService.addGameRating(rating);
        if(num >= 1) return "success";
        else return "failure";
    }


    @ResponseBody
    @RequestMapping("update.do")
    public String ratingUpdate(@RequestParam HashMap rating, HttpSession session){
        String userid = (String) session.getAttribute("userid");
        rating.put("userid", userid);
        int num = gameRatingService.updateGameRating(rating);
        if(num >= 1) return "success";
        else return "failure";
    }


    @ResponseBody
    @RequestMapping("getUserRating.do")
    public GameRatingDTO getUserRating(@RequestParam int gnum, HttpSession session){
        String userid = (String) session.getAttribute("userid");
        GameRatingDTO dto = gameRatingService.getUserRating(gnum, userid);
        return dto;
    }


    @RequestMapping("delete.do")
    public String deleteRating(@RequestParam int gnum, HttpSession session){
        String userid = (String)session.getAttribute("userid");
        int num = gameRatingService.deleteGameRating(gnum, userid);

        if(num >= 1) {
            session.setAttribute("msg", "평가가 삭제되었습니다.");
            return "redirect:/game/view.do?gnum=" + gnum;
        }
        else{
            session.setAttribute("msg", "요청을 처리하던 도중 오류가 발생하였습니다.");
            return "redirect:/game/view.do?gnum=" + gnum;
        }
    }

    @ResponseBody
    @RequestMapping("getRatingJsonData.do")
    public JSONObject getRatingJsonData(@RequestParam int gnum){
        return gameRatingService.getRatingJsonData(gnum);
    }

    @ResponseBody
    @RequestMapping("getWeightJsonData.do")
    public JSONObject getWeightJsonData(@RequestParam int gnum){
        return gameRatingService.getWeightJsonData(gnum);
    }

    @ResponseBody
    @RequestMapping("getPlayerJsonData.do")
    public JSONObject getPlayerJsonData(@RequestParam int gnum){
        return gameRatingService.getPlayerJsonData(gnum);
    }


    @ResponseBody
    @RequestMapping("getTopRatings.do")
    public HashMap<String, List<GameRatingDTO>> getTopRatings(@RequestParam int gnum, HttpSession session){
        int number = 3; //상위 몇건까지 출력할 것인지

        String user_id = (String)session.getAttribute("userid");
        List<GameRatingDTO> list = gameRatingService.getTopRatings(gnum, number, user_id);
        HashMap<String, List<GameRatingDTO>> map = new HashMap<>();
        map.put("list", list);
        System.out.println("사이즈는 " + list.size());
        return map;
    }


    @ResponseBody
    @RequestMapping("likeIt.do")
    public int likeIt(@RequestParam int gnum, @RequestParam String writer_id, HttpSession session){
        String user_id = (String)session.getAttribute("userid");
        int num = gameRatingService.likeIt(gnum, writer_id, user_id);
        return num;
    }


    @ResponseBody
    @RequestMapping("unLikeIt.do")
    public int unLikeIt(@RequestParam int gnum, @RequestParam String writer_id, HttpSession session){
        String user_id = (String)session.getAttribute("userid");
        int num = gameRatingService.unLikeIt(gnum, writer_id, user_id);
        return num;
    }









}
