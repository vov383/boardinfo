package com.example.boardinfo.controller.game;

import com.example.boardinfo.model.game.dto.gameRating.GameRatingDTO;
import com.example.boardinfo.service.game.GameRatingService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("gameRating/*")
public class GameRatingController {

    @Inject
    GameRatingService gameRatingService;


    @ResponseBody
    @RequestMapping("add.do")
    public String ratingAdd(@ModelAttribute GameRatingDTO rating, HttpSession session){

        String userid = (String) session.getAttribute("userid");
        rating.setUserid(userid);
        System.out.println(rating.toString());

        System.out.println(userid);
        int num = gameRatingService.addGameRating(rating);
        if(num > 1) return "success";
        else return "failure";
    }






}
