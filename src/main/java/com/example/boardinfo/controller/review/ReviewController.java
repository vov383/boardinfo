package com.example.boardinfo.controller.review;

import com.example.boardinfo.model.review.dto.TestDTO;
import com.example.boardinfo.service.review.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

@Controller
@RequestMapping("review/*")
public class ReviewController {
	@Inject
	ReviewService reviewservice;

	@RequestMapping("reviewlist.do")
	public ModelAndView revewlist(ModelAndView mav) {
		mav.setViewName("review/reviewMain");
		mav.addObject("list", reviewservice.reviewlist());
		return mav;
	}
	// 페이지 열기
	@RequestMapping("reviewInTest.do")
	public String insert(@ModelAttribute TestDTO testdto){
		return "/review/reviewInTest";
	}
	// 저장
	@RequestMapping("reviewInTestInsertPage.do")
	public String insertPage(@ModelAttribute TestDTO testdto){
		reviewservice.create(testdto);
		return "/review/reviewInTest";
	}


	/*public ModelAndView reviewDetail(ModelAndView mav) {
		mav.setViewName("review/reviewInTest");
		mav.addObject("list", reviewservice.reviewInTest());
		return mav;
	}*/


}