package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
    ReviewDAO reviewDAO;

	@Override // 덮어쓰기 의미
	public List<ReviewDTO> reviewlist(){

		List<ReviewDTO> list = reviewDAO.reviewlist();
		System.out.println("vo : " + new Gson().toJson(list));

		return list;
	}

	@Transactional
	@Override // 덮어쓰기 의미
	public void create(ReviewDTO reviewDTO){

		System.out.println("testtesttesttesttesttesttesttesttesttest");
		System.out.println("reviewDTO.getRegNum() : " + reviewDTO.getRegNum());
		System.out.println("reviewDTO.getCategory() : " + reviewDTO.getCategory());
		System.out.println("reviewDTO.getNickName() : " + reviewDTO.getNickName());
		System.out.println("reviewDTO.getViews() : " + reviewDTO.getViews());
		System.out.println("reviewDTO.getGnum() : " + reviewDTO.getGnum());
		System.out.println("reviewDTO.getGatheringId() : " + reviewDTO.getGatheringId());
		System.out.println("reviewDTO.getTitle() : " + reviewDTO.getTitle());
		System.out.println("reviewDTO.getFunScore() : " + reviewDTO.getFunScore());
		System.out.println("reviewDTO.getReviewScore() : " + reviewDTO.getReviewScore());
		System.out.println("reviewDTO.getGameScore() : " + reviewDTO.getGameScore());
		System.out.println("reviewDTO.getReviewDetail() : " + reviewDTO.getReviewDetail());
		System.out.println("reviewDTO.getGood() : " + reviewDTO.getGood());
		System.out.println("reviewDTO.getDel() : " + reviewDTO.getDel());
		System.out.println("reviewDTO.getCreateUser() : " + reviewDTO.getCreateUser());
		System.out.println("reviewDTO.getCreateDate() : " + reviewDTO.getCreateDate());
		System.out.println("reviewDTO.getUpdateUser() : " + reviewDTO.getUpdateUser());
		System.out.println("reviewDTO.getUpdateDate() : " + reviewDTO.getUpdateDate());
		System.out.println("testtesttesttesttesttesttesttesttesttest");


		reviewDAO.create(reviewDTO);
	}


/*	@Transactional
	@Override // 덮어쓰기 의미
	public void create(TestDTO testdto){

		System.out.println("test 1 : " + testdto.getTest1());
		reviewDAO.create(testdto);
	}*/

}
