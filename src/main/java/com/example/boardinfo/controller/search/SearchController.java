package com.example.boardinfo.controller.search;

import com.example.boardinfo.controller.game.GameController;
import com.example.boardinfo.service.game.GameService;
import com.example.boardinfo.service.gathering.GatheringService;
import com.example.boardinfo.service.sample.SampleService;
import com.example.boardinfo.service.tboard.TBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

@Controller
@RequestMapping("search/*") //공통 url mapping
public class SearchController {
	private static final Logger logger=
			LoggerFactory.getLogger(GameController.class);
	@Inject
	GameService gameService;

	@Inject
	TBoardService tBoardService;

	@Inject
	GatheringService gatheringService;

	@GetMapping("searchAll.do")
	public ModelAndView totalSearch(ModelAndView mav, @RequestParam("gameKeyword")String gameKeyword){
		mav.setViewName("include/totalSearch");
		mav.addObject("gameKeyword", gameKeyword);
		mav.addObject("gameMap", gameService.totalSearch(gameKeyword));
		mav.addObject("t_boardList",tBoardService.totalSearch(gameKeyword));
		mav.addObject("gatheringList",gatheringService.totalSearch(gameKeyword));
		return mav;
	}
}
