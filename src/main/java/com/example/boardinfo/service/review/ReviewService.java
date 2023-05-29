package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import com.example.boardinfo.model.review.dto.reviewSerchDTO;
import org.aspectj.weaver.ast.Test;

import java.util.List;

public interface ReviewService {

	//리뷰 테이블
    List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO);

//    주는놈 메소드(받는놈);


	// 리뷰 입력
    void reviewCreate(ReviewDTO reviewDTO);

    // 리뷰 수정
    void reviewUpdate(ReviewDTO reviewDTO);

	// 리뷰 입력
    void create(TestDTO testdto);



	/*public List<ReviewDTO> reviewDetail();*/




/*
	// 댓글 및 답글 테이블
	public List<ReplyCommentsDTO> replycommentslist();

	// 선택된 게임 테이블
	public List<ChoiceGameDTO> choicegamelist();
*/

}




