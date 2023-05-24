package com.example.boardinfo.controller.review;

import com.example.boardinfo.model.review.dto.ReviewDTO;
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

	// 리뷰 리스트 페이지
	@RequestMapping("reviewlist.do")
	public ModelAndView revewlist(ModelAndView mav) {
		mav.setViewName("review/gameReviewMain");
		mav.addObject("list", reviewservice.reviewlist());

		System.out.println("reviewservice.reviewlist().get(0).getCreateDate() : " + reviewservice.reviewlist().get(0).getCreateDate());
		return mav;
	}

	// 리뷰 상세 페이지
	@RequestMapping("reviewdetail.do")
	public ModelAndView revewDetail(ModelAndView mav) {
		mav.setViewName("review/reviewDetail");
		mav.addObject("list", reviewservice.reviewlist());
		return mav;
	}

	// 리뷰 입력할 페이지
	@RequestMapping("reviewInsert.do")
	public String insert(@ModelAttribute ReviewDTO reviewDTO){
		return "/review/ReviewInsert";
	}

	// 리뷰 저장후 페이지
	@RequestMapping("reviewinsertsave.do")
	public String insertPage(@ModelAttribute ReviewDTO reviewDTO){

		/*System.out.println("testtesttesttesttest");*/

		reviewservice.create(reviewDTO);
		return "/review/gameReviewMain";
	}

    // Blob Test, 입력P
    @RequestMapping("reviewBlobInsert.do")
    public String insert(@ModelAttribute TestDTO testdto){
        return "/review/ReviewBlobInsert";
    }

    // Blob Test, 저장P
    @RequestMapping("reviewBlobInsertPage.do")
    public String insertPage(@ModelAttribute TestDTO testdto){
        reviewservice.create(testdto);
        return "/review/ReviewBlobInsert";
    }





	/*
	@RequestMapping("reviewInTest.do")
	public String insert(@ModelAttribute TestDTO testdto){
		return "/review/reviewinset";
	}*/


/*	// 페이지 열기
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
*/


}