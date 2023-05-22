package com.example.boardinfo.controller.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.service.game.GameService;

@Controller
@RequestMapping("game/*")
public class GameController {
	private static final Logger logger=
			LoggerFactory.getLogger(GameController.class);
	@Inject
	GameService gameService;
	
	@RequestMapping("gamelist.do")
	public ModelAndView gamelist(ModelAndView mav) {
		mav.setViewName("game/game_list");
		mav.addObject("list", gameService.gamelist());
		return mav;
	}
	
	@RequestMapping("write.do")
	public ModelAndView write(ModelAndView mav) {

		//카테고리와 메카닉은 테이블에서 선택하기에 미리 값을 받아놈
	    List<CategoryDTO> categorylist = gameService.categorylist();
	    List<MechanicDTO> mechaniclist = gameService.mechaniclist();

	    
	    Map<String, Object> map=new HashMap<>();
	    map.put("clist", categorylist);
	    map.put("mlist", mechaniclist);
	    
	    mav.setViewName("game/game_insert");
	    mav.addObject("map", map);
		return mav;
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute GameDTO dto) {
		gameService.gameinsert(dto);
		return "home";
	}
	
	@RequestMapping("view.do")
	public ModelAndView view(int gnum, HttpSession session) throws Exception {
		gameService.increaseViewcnt(gnum, session);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("game/game_view");
		mav.addObject("dto", gameService.view(gnum));
		return mav;
	}
	
	@RequestMapping("auto.do/{input}")
    @ResponseBody
    public List<ArtistDTO> autoCompleteArtist(@PathVariable String input) {

		List<ArtistDTO> list = gameService.getAuto(input);
        return list;
    }
	
	
	
	
}
