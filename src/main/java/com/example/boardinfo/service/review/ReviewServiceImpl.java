package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
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
	public List<TestDTO> reviewInTest(){

		List<TestDTO> list = reviewDAO.reviewInTest();
		System.out.print("vo : " + new Gson().toJson(list));

		return list;
	}

}
