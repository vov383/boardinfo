package com.example.boardinfo.controller.game;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.service.game.GameRatingService;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

	@Inject
	GameRatingService gameRatingService;

	//전체게임목록으로 이동
	@RequestMapping("gamelist.do")
	public ModelAndView gamelist(ModelAndView mav, @RequestParam(required = false, defaultValue = "1") int curPage) {

		mav.setViewName("game/game_list");
		mav.addObject("map", gameService.gamelist(curPage));
		return mav;
	}

	//게임등록으로 이동
	@RequestMapping("write.do")
	public ModelAndView write(ModelAndView mav) {

		Map<String, Object> map=new HashMap<>();

		//카테고리와 메카닉은 테이블에서 선택하기에 미리 값을 받아놈
	    map.put("clist", gameService.categorylist());
	    map.put("mlist", gameService.mechaniclist());
	    
	    mav.setViewName("game/game_insert");
	    mav.addObject("map", map);
		return mav;
	}

	//게임등록
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute GameDTO dto,HttpSession session) {
		String userid = (String)session.getAttribute("userid");

		if(userid != null)
			dto.setCreate_user(userid);
		else
			dto.setCreate_user("admin");
		gameService.gameinsert(dto);
		return "home";
	}

	//게임정보페이지로 이동
	@RequestMapping("view.do")
	public ModelAndView view(ModelAndView mav, int gnum, HttpServletRequest request,
							 HttpSession session, HttpServletResponse response) throws Exception {
		//조회수
		gameService.increaseViewcnt(gnum, request, response);
		//정보
		Map<String, Object> map = gameService.view(gnum);
		//평가정보
		Map<String, Object> statisticMap = gameRatingService.getStatistic(gnum, (String)session.getAttribute("userid"));


		mav.setViewName("game/game_viewDetail");
		mav.addObject("map", map);
		mav.addObject("statisticMap", statisticMap);
		return mav;
	}

	//게임등록페이지 내 아티스트 검색기능
	@RequestMapping("autoArtist.do/{input}")
    @ResponseBody
    public List<ArtistDTO> autoArtist(@PathVariable String input) {

		List<ArtistDTO> list = gameService.getAutoArtist(input);
        return list;
    }

    //게임등록페이지 내 디자이너 검색기능
	@RequestMapping("autoDesigner.do/{input}")
	@ResponseBody
	public List<DesignerDTO> autoDesigner(@PathVariable String input) {

		List<DesignerDTO> list = gameService.getAutoDesigner(input);
		return list;
	}

	//게임등록페이지 내 퍼블리셔 검색기능
	@RequestMapping("autoPublisher.do/{input}")
	@ResponseBody
	public List<PublisherDTO> autoPublisher(@PathVariable String input) {

		List<PublisherDTO> list = gameService.getAutoPublisher(input);
		return list;
	}

	//top의 검색창에서의 검색 자동완성 기능
	@RequestMapping("autoGame.do/{input}")
	@ResponseBody
	public List<GameDTO> autoGame(@PathVariable String input){
		List<GameDTO> list = gameService.getAutoGame(input);
		return list;
	}

	@GetMapping ("search.do")
	public ModelAndView sortGame(ModelAndView mav, @RequestParam("filter") String filter, @RequestParam("num") int num,
								 @RequestParam(required = false, defaultValue = "1") int curPage) {

		mav.setViewName("game/game_list");
		mav.addObject("map", gameService.filteredGamelist(filter, num, curPage));

		return mav;
	}

	@RequestMapping("updateView.do")
	public ModelAndView updateView(ModelAndView mav, @RequestParam("gnum")int gnum) throws Exception {
		mav.setViewName("game/game_update");
		mav.addObject("dto", gameService.updateView(gnum));
		mav.addObject("clist", gameService.categorylist());
		mav.addObject("mlist", gameService.mechaniclist());
		return mav;
	}

	@RequestMapping("update.do")
	public String update(@ModelAttribute GameDTO dto,HttpSession session) {
		String userid = (String)session.getAttribute("userid");

		if(userid != null)
			dto.setUpdate_user(userid);
		else
			dto.setUpdate_user("admin");

		gameService.gameupdate(dto);
		return "home";
	}

	@RequestMapping("delete.do")
	public String delete(@RequestParam("delete_gnum")int gnum, HttpSession session){
		String userid = (String)session.getAttribute("userid");
		gameService.deleteGame(gnum, userid);
		return "home";
	}

	@ResponseBody
	@RequestMapping("parseAjax")
	public Map<String, Object> parseInsert(@RequestParam("bggnum")int bggnum, Map<String, Object> map){
		map = gameService.parseInsert(bggnum);
		return map;
	}

	@ResponseBody
	@RequestMapping("getExReAjax")
	public Map<String, Object> getExReList(@RequestBody Map<String, Object> param){
		String origin = (String) param.get("origin");
		String filter = (String) param.get("filter");
		int gnum = (int) param.get("num");

		Map<String, Object> map = gameService.getExRe(origin, filter, gnum);
		return map;
	}
}
