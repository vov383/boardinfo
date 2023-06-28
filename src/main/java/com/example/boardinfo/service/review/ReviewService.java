package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dto.*;
import org.springframework.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface ReviewService {

	/*리뷰 목록 조회*/
    List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO);

	/*리뷰 목록 조회*/
    int reviewListCnt(reviewSerchDTO reviewserchDTO);

    /*게임 목록 출력*/
    List<ChoiceGameDTO> gameListOut(reviewSerchDTO reviewserchDTO);

//    주는놈 메소드(받는놈);


	/*리뷰 입력*/
    void reviewCreate(ReviewDTO reviewDTO, HttpSession session);

    /*리뷰 수정*/
    void reviewUpdate(ReviewDTO reviewDTO);

    /*리뷰 삭제*/
    void reviewDel(reviewSerchDTO reviewserchDTO);

    /*리뷰 좋아요*/
    void reviewGoodCreate(reviewSerchDTO reviewserchDTO, HttpSession session);

    /*리뷰 댓글 입력*/
    void reviewReply(ReplyCommentsDTO replyCommentsDTO, HttpSession session);

    /*리뷰 댓글 수정*/
    void reviewReplyUpdate(ReplyCommentsDTO replyCommentsDTO, HttpSession session);

    /*리뷰 댓글 삭제*/
    void reviewReplyDel(ReplyCommentsDTO replyCommentsDTO, HttpSession session);

    /*리뷰 댓글 출력*/
    List<ReplyCommentsDTO> reviewReplyOut(reviewSerchDTO reviewserchDTO);

    /*리뷰 대댓글 입력*/
    void topreplyinsetsave(ReplyCommentsDTO replyCommentsDTO, HttpSession session);







	// 리뷰 입력 테스트
    void create(TestDTO testdto);

    public List<ReviewDTO> getHomeList(Integer size);
    List<ReviewDTO> getHotList(Integer size);
    Map<String, Object> totalSearch(String gameKeyword);
    Map<String, Object> totalSearchMore(Map<String, Object> map);



    /*public List<ReviewDTO> reviewDetail();*/




/*
	// 댓글 및 답글 테이블
	public List<ReplyCommentsDTO> replycommentslist();

	// 선택된 게임 테이블
	public List<ChoiceGameDTO> choicegamelist();
*/

}




