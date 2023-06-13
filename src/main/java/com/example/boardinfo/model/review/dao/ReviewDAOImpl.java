package com.example.boardinfo.model.review.dao;

import com.example.boardinfo.model.review.dto.ReplyCommentsDTO;
import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import com.example.boardinfo.model.review.dto.reviewSerchDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    SqlSession sqlSession;


    /*리뷰 목록 조회*/
    @Override
    public List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO) {
        return sqlSession.selectList("review.reviewList", reviewserchDTO);
    }

    /*리뷰 목록 조회*/
    @Override
    public int reviewListCnt(reviewSerchDTO reviewserchDTO) {
        return sqlSession.selectOne("review.reviewListCnt", reviewserchDTO);
    }



    /*리뷰 조회수 증가*/
    @Override
    public void reviewViews(reviewSerchDTO reviewserchDTO) {
        sqlSession.update("review.reviewViews", reviewserchDTO);
    }

    /*리뷰 입력*/
    @Override
    public void reviewCreate(ReviewDTO reviewDTO) {

        sqlSession.insert("review.reviewInsertPage", reviewDTO);

    }

    /*리뷰 수정*/
    @Override
    public void reviewUpdate(ReviewDTO reviewDTO) {

        sqlSession.update("review.reviewedit", reviewDTO);

    }

    /*리뷰 삭제*/
    @Override
    public void reviewDel(reviewSerchDTO reviewserchDTO) {

        sqlSession.update("review.revieweDel", reviewserchDTO);

    }

    /*리뷰 좋아요*/
    @Override
    public void reviewGoodCreate(reviewSerchDTO reviewserchDTO) {

        sqlSession.insert("review.reviewGood", reviewserchDTO);

    }

    /*리뷰 댓글 입력*/
    @Override
    public void reviewReply(ReplyCommentsDTO replyCommentsDTO) {

        sqlSession.insert("review.reviewReply", replyCommentsDTO);

    }

    /*리뷰 댓글 수정*/
    @Override
    public void reviewReplyUpdate(ReplyCommentsDTO replyCommentsDTO) {
        sqlSession.update("review.reviewReplyUpdate", replyCommentsDTO);
    }

    /*리뷰 댓글 삭제*/
    @Override
    public void reviewReplyDel(ReplyCommentsDTO replyCommentsDTO) {
        sqlSession.update("review.reviewReplyDel", replyCommentsDTO);
    }

    /*리뷰 댓글 출력*/
    @Override
    public List<ReplyCommentsDTO> reviewReplyOut(reviewSerchDTO reviewserchDTO) {
        return sqlSession.selectList("review.reviewReplyOut", reviewserchDTO);
    }

    /*리뷰 답글 입력*/
    @Override
    public void topreplyinsetsave(ReplyCommentsDTO replyCommentsDTO) {
        sqlSession.insert("review.topreplyinsetsave", replyCommentsDTO);
    }







    //리뷰 Blob 테스트
    @Override
    public void create(TestDTO testdto) {

        sqlSession.insert("review.reviewBlob", testdto);
    }

/*

	//댓글 및 답글 테이블
	@Override
	public List<ReplyCommentsDTO> replycommentslist(){
		return sqlSession.selectList("review.reviewList");
	}

	//선택된 게임 테이블
	@Override
	public List<ChoiceGameDTO> choicegamelist(){
		return sqlSession.selectList("review.reviewList");
	}
*/


}
