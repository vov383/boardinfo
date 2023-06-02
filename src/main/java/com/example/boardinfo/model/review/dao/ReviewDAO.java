package com.example.boardinfo.model.review.dao;

import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import com.example.boardinfo.model.review.dto.reviewSerchDTO;

import java.util.List;

public interface ReviewDAO {

	// 리뷰 테이블
    List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO);

    // 조회수 증가
    void reviewViews(reviewSerchDTO reviewserchDTO);

	// 리뷰 입력
    void reviewCreate(ReviewDTO reviewDTO);

    // 리뷰 수정
    void reviewUpdate(ReviewDTO reviewDTO);

    // 리뷰 삭제
    void reviewDel(reviewSerchDTO reviewserchDTO);

    // 리뷰 좋아요
    void reviewGoodCreate(reviewSerchDTO reviewserchDTO);



    // 리뷰 Blob 입력 테스트
    void create(TestDTO testdto);

	/*// 리뷰 입력 테스트
	public void create(TestDTO testdto);*/


/*

	// 댓글 및 답글 테이블
	public List<ReplyCommentsDTO> replycommentslist();

	// 선택된 게임 테이블
	public List<ChoiceGameDTO> choicegamelist();
*/

}
