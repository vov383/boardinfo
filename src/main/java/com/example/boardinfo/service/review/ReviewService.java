package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import org.aspectj.weaver.ast.Test;

import java.util.List;

public interface ReviewService {

	//리뷰 테이블
	public List<ReviewDTO> reviewlist();

	// 리뷰 입력 테스트
	public void create(ReviewDTO reviewDTO);

	/*public List<ReviewDTO> reviewDetail();*/
/*

	// 댓글 및 답글 테이블
	public List<ReplyCommentsDTO> replycommentslist();

	// 선택된 게임 테이블
	public List<ChoiceGameDTO> choicegamelist();
*/

}




