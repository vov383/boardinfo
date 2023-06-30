package com.example.boardinfo.controller.game;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.service.game.GameRatingService;
import com.example.boardinfo.service.game.GameService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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

	//게임목록 랭킹
	@GetMapping("gamerank/{sort}")
	public ModelAndView gamelist(ModelAndView mav, @PathVariable("sort")String sort,
								 @RequestParam(required = false, defaultValue = "1") int curPage) {

		mav.setViewName("game/game_list");
		mav.addObject("sort", sort);
		mav.addObject("map", gameService.gamelist(curPage, sort));
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
		String admin_id = (String)session.getAttribute("admin_id");
		String str = "";

		if(userid != null){
			dto.setCreate_user(userid);
			str = "user";
		} else if(admin_id != null){
			dto.setCreate_user(admin_id);
			str = "admin";
		} else
			return "redirect:/";

		gameService.gameinsert(dto, str);
		return "redirect:/";
	}

	//게임정보페이지로 이동
	@RequestMapping("view.do")
	public ModelAndView view(ModelAndView mav, int gnum, HttpServletRequest request,
							 HttpSession session, HttpServletResponse response) throws Exception {
		String userid = (String)session.getAttribute("userid");
		String admin_id = (String)session.getAttribute("admin_id");
		String logonid = "";

		if(userid != null)
			logonid = userid;
		else if(admin_id != null)
			logonid = admin_id;


		//조회수
		gameService.increaseViewcnt(gnum, request, response);
		//정보
		Map<String, Object> map = gameService.view(gnum);
		//평가정보
		Map<String, Object> statisticMap = gameRatingService.getStatistic(gnum, logonid);

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

	@RequestMapping("autoUpdate_delete.do/{value}/{gnum}/{filter}")
	public void autoUpdate_delete(@PathVariable("value") String value, @PathVariable("gnum") int gnum,
									@PathVariable("filter") String filter){
		gameService.autoUpdate_delete(value, gnum,filter);

	}

	@GetMapping ("partrank/{sort}")
	public ModelAndView sortGame(ModelAndView mav, @PathVariable("sort")String sort,
								 @RequestParam("filter") String filter, @RequestParam("num") int num,
								 @RequestParam(required = false, defaultValue = "1") int curPage) {

		mav.setViewName("game/game_filteredList");
		mav.addObject("sort",sort);
		mav.addObject("map", gameService.filteredGamelist(filter, num, curPage, sort));

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
		String admin_id = (String)session.getAttribute("admin_id");
		String logonid = "";
		String str = "";

		if(userid != null){
			logonid = userid;
			str = "user";
		}else if(admin_id != null){
			logonid = admin_id;
			str = "admin";
		}else{
			return "redirect:/";
		}
		dto.setUpdate_user(logonid);

		gameService.gameupdate(dto, str);
		return "redirect:/";
	}

	@RequestMapping("delete.do")
	public String delete(@RequestParam("delete_gnum")int gnum, HttpSession session){
		String userid = (String)session.getAttribute("userid");
		String admin_id = (String)session.getAttribute("admin_id");
		String logonid = "";

		if(userid != null)
			logonid = userid;
		else if(admin_id != null)
			logonid = admin_id;
		else{
			return "redirect:/";
		}

		gameService.deleteGame(gnum, logonid);
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping("parseAjax")
	public Map<String, Object> parseInsert(@RequestParam("bggnum")int bggnum, Map<String, Object> map){
		map = gameService.parseInsert(bggnum);
		return map;
	}

	//ajax방식으로 게임정보창의 확장재구현게임목록 표시
	@ResponseBody
	@RequestMapping("getExReAjax")
	public Map<String, Object> getExReList(@RequestBody Map<String, Object> param){
		String origin = (String) param.get("origin");
		String filter = (String) param.get("filter");
		int gnum = (int) param.get("num");

		Map<String, Object> map = gameService.getExRe(origin, filter, gnum);
		return map;
	}

	//메인페이지 캐러셀속 게임 출력
	@RequestMapping("gameListMain.do")
	public ModelAndView gameListMain(ModelAndView mav){
		Map<String, Object> map = gameService.gameListMain();
		mav.setViewName("game/game_main_carousel");
		mav.addObject("map", map);
		return mav;
	}

	//카테고리별 전체목록
	@GetMapping(value = "totalSearchMore/{filter}")
	public ModelAndView totalSearchMore(ModelAndView mav, Map<String, Object> map,
										@RequestParam(required = false, defaultValue = "1") int curPage,
										@PathVariable("filter") String filter){
		map.put("filter", filter);
		map.put("gameKeyword", "none");
		map.put("curPage", curPage);
		map = gameService.totalSearchMore(map);
		mav.setViewName("game/game_creditList");
		mav.addObject("map", map);
		return mav;
	}

	@GetMapping("categoryList")
	public ModelAndView categoryList(ModelAndView mav,
									 @RequestParam(required = false, defaultValue = "1") int curPage){
		mav.setViewName("game/game_list_category_theme");
		mav.addObject("map",gameService.game_list_category(curPage));
		mav.addObject("filter","category");
		return mav;
	}

	@GetMapping("themeList/{sort}")
	public ModelAndView themeList(ModelAndView mav, @PathVariable("sort") String sort,
								  @RequestParam(required = false, defaultValue = "1") int curPage) {
		mav.setViewName("game/game_list_category_theme");
		mav.addObject("map", gameService.game_list_theme(curPage,sort));
		mav.addObject("filter", "theme");
		return mav;
	}

}
