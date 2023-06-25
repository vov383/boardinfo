package com.example.boardinfo.controller.search;

import com.example.boardinfo.controller.game.GameController;
import com.example.boardinfo.service.game.GameService;
import com.example.boardinfo.service.gathering.GatheringService;
import com.example.boardinfo.service.review.ReviewService;
import com.example.boardinfo.service.sample.SampleService;
import com.example.boardinfo.service.tboard.TBoardService;
import com.example.boardinfo.util.GameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("search/*") //공통 url mapping
public class SearchController {
	private static final Logger logger=
			LoggerFactory.getLogger(SearchController.class);
	@Inject
	GameService gameService;

	@Inject
	TBoardService tBoardService;

	@Inject
	GatheringService gatheringService;

	@Inject
	ReviewService reviewService;

	@GetMapping("searchAll.do")
	public ModelAndView totalSearch(ModelAndView mav, @RequestParam("gameKeyword")String gameKeyword){
		mav.setViewName("include/totalSearch");
		mav.addObject("gameKeyword", gameKeyword);
		mav.addObject("gameMap", gameService.totalSearch(gameKeyword));
		mav.addObject("t_boardList",tBoardService.totalSearch(gameKeyword));
		mav.addObject("gatheringList",gatheringService.totalSearch(gameKeyword));
		mav.addObject("reviewMap",reviewService.totalSearch(gameKeyword));
		return mav;
	}

	@GetMapping(value = "totalSearchMore/{filter}/{gameKeyword}")
	public ModelAndView totalSearchMore(ModelAndView mav,
										@RequestParam(required = false, defaultValue = "1") int curPage,
										@PathVariable("filter")String filter,
										@PathVariable("gameKeyword") String gameKeyword,
										Map<String, Object> map){

		map.put("gameKeyword", gameKeyword);
		map.put("curPage", curPage);
		map.put("filter",filter);
		switch (filter){
			case "아티스트":
			case "디자이너":
			case "퍼블리셔":
			case "게임":
				map.put("sort","search");
				map = gameService.totalSearchMore(map);
				break;
			case "자유게시판"	: case "게임포럼" :
				map = reviewService.totalSearchMore(map);
				break;
			case "모임게시판"	:
				map = gatheringService.totalSearchMore(map);
				break;
			case "거래게시판" :
				map = tBoardService.totalSearchMore(map);
				break;
		}
		mav.setViewName("include/totalSearchMore");
		mav.addObject("sort", "search");
		mav.addObject("map", map);
		return mav;
	}
}
