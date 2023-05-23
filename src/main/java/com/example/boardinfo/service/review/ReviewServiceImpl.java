package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
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
	public void create(TestDTO testdto){

		System.out.println("test 1 : " + testdto.getTest1());
		reviewDAO.create(testdto);
	}

}
