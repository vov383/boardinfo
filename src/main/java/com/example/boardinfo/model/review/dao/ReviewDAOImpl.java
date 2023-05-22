package com.example.boardinfo.model.review.dao;

import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Inject
    SqlSession sqlSession;


    //리뷰 테이블
    @Override
    public List<ReviewDTO> reviewlist() {
        return sqlSession.selectList("review.reviewList");
    }

    //리뷰 입력 테스트
    @Override
    public void create(TestDTO testdto) {
        sqlSession.insert("board.insert", testdto);
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
