package com.example.boardinfo.model.review.dao;

import com.example.boardinfo.model.review.dto.*;

import java.util.List;

public interface ReviewDAO {

	/*리뷰 목록 조회*/
    List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO);

    int reviewListCnt(reviewSerchDTO reviewserchDTO);

    /*조회수 증가*/
    void reviewViews(reviewSerchDTO reviewserchDTO);

	/*리뷰 입력*/
    void reviewCreate(ReviewDTO reviewDTO, ChoiceGameDTO choiceGameDTO);

    /*리뷰 수정*/
    void reviewUpdate(ReviewDTO reviewDTO);

    /*리뷰 삭제*/
    void reviewDel(reviewSerchDTO reviewserchDTO);

    /*리뷰 좋아요*/
    void reviewGoodCreate(reviewSerchDTO reviewserchDTO);

    /*리뷰 댓글 입력*/
    void reviewReply(ReplyCommentsDTO replyCommentsDTO);

    /*리뷰 댓글 수정*/
    void reviewReplyUpdate(ReplyCommentsDTO replyCommentsDTO);

    /*리뷰 댓글 삭제*/
    void reviewReplyDel(ReplyCommentsDTO replyCommentsDTO);

    /*리뷰 댓글 출력*/
    List<ReplyCommentsDTO> reviewReplyOut(reviewSerchDTO reviewserchDTO);

    /*리뷰 대댓글 입력*/
    void topreplyinsetsave(ReplyCommentsDTO replyCommentsDTO);




    // 리뷰 Blob 입력 테스트
    void create(TestDTO testdto);

    List<ReviewDTO> getRvListByUserid(String userid);

    public List<ReviewDTO> getHomeList(Integer size);


    List<ReviewDTO> getHotList(Integer size);


	/*// 리뷰 입력 테스트
	public void create(TestDTO testdto);*/


/*

	// 댓글 및 답글 테이블
	public List<ReplyCommentsDTO> replycommentslist();

	// 선택된 게임 테이블
	public List<ChoiceGameDTO> choicegamelist();
*/

}
