package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
    ReviewDAO reviewDAO;

	@Override // 덮어쓰기 의미
	public List<ReviewDTO> reviewlist(){

		List<ReviewDTO> list = reviewDAO.reviewlist();
		System.out.print("vo : " + new Gson().toJson(list));

		return list;
	}

	@Override // 덮어쓰기 의미
	public List<ReviewDTO> reviewInTest(){

		List<ReviewDTO> list = reviewDAO.reviewlist();
		System.out.print("vo : " + new Gson().toJson(list));

		return list;
	}

}
