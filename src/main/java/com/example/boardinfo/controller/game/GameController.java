package com.example.boardinfo.controller.game;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.service.game.GameService;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@RequestMapping("autoArtist.do/{input}")
    @ResponseBody
    public List<ArtistDTO> autoArtist(@PathVariable String input) {

		List<ArtistDTO> list = gameService.getAutoArtist(input);
        return list;
    }

	@RequestMapping("autoDesigner.do/{input}")
	@ResponseBody
	public List<DesignerDTO> autoDesigner(@PathVariable String input) {

		List<DesignerDTO> list = gameService.getAutoDesigner(input);
		return list;
	}

	@RequestMapping("autoPublisher.do/{input}")
	@ResponseBody
	public List<PublisherDTO> autoPublisher(@PathVariable String input) {

		List<PublisherDTO> list = gameService.getAutoPublisher(input);
		return list;
	}

	@RequestMapping("searchAll.do")
	public Map<String,Object> searchAll(@RequestParam String gameKeyword ){
		System.out.println(gameKeyword);
		return null;
	}

	@RequestMapping("autoGame.do/{input}")
	@ResponseBody
	public List<GameDTO> autoGame(@PathVariable String input){
		List<GameDTO> list = gameService.getAutoGame(input);
		return list;
	}

//	@RequestMapping("photoupload.do")
//	public String photoupload
	
	
	
}
