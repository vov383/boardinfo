package com.example.boardinfo.service.review;

import com.example.boardinfo.model.review.dao.ReviewDAO;
import com.example.boardinfo.model.review.dto.*;

import com.example.boardinfo.util.Pager;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
    ReviewDAO reviewDAO;

	/*리뷰 목록 조회*/
	@Override // 덮어쓰기 의미
	public List<ReviewDTO> reviewlist(reviewSerchDTO reviewserchDTO){
		reviewDAO.reviewViews(reviewserchDTO);
		List<ReviewDTO> list = reviewDAO.reviewlist(reviewserchDTO);
		/*System.out.println("vo : " + new Gson().toJson(list));*/

		return list;
	}

	/*게임 목록 출력*/
	@Override // 덮어쓰기 의미
	public List<ChoiceGameDTO> gameListOut(reviewSerchDTO reviewserchDTO){


		List<ChoiceGameDTO> gameList = reviewDAO.gameListOut(reviewserchDTO);
		/*System.out.println("vo : " + new Gson().toJson(list));*/

		return gameList;
	}


	/*리뷰 목록 카운트*/
	@Override // 덮어쓰기 의미
	public int reviewListCnt(reviewSerchDTO reviewserchDTO){
		return reviewDAO.reviewListCnt(reviewserchDTO);
	}

	/*리뷰 입력*/
	@Transactional
	@Override
	public void reviewCreate(ReviewDTO reviewDTO, HttpSession session){

		String userid = (String) session.getAttribute("userid");
		reviewDTO.setCreateUser(userid);

/*
		System.out.println("testtesttesttesttesttesttesttesttesttest");
		System.out.println("reviewDTO.getRegNum() : " + reviewDTO.getRegNum());
		System.out.println("reviewDTO.getCategory() : " + reviewDTO.getCategory());
		System.out.println("reviewDTO.getNickName() : " + reviewDTO.getNickName());
		System.out.println("reviewDTO.getViews() : " + reviewDTO.getViews());
		System.out.println("reviewDTO.getGnum() : " + reviewDTO.getGnum());
		System.out.println("reviewDTO.getGatheringId() : " + reviewDTO.getGatheringId());
		System.out.println("reviewDTO.getTitle() : " + reviewDTO.getTitle());
		System.out.println("reviewDTO.getFunScore() : " + reviewDTO.getFunScore());
		System.out.println("reviewDTO.getReviewScore() : " + reviewDTO.getReviewScore());
		System.out.println("reviewDTO.getGameScore() : " + reviewDTO.getGameScore());
		System.out.println("reviewDTO.getReviewDetail() : " + reviewDTO.getReviewDetail());
		System.out.println("reviewDTO.getGood() : " + reviewDTO.getGood());
		System.out.println("reviewDTO.getDel() : " + reviewDTO.getDel());
		System.out.println("reviewDTO.getCreateUser() : " + reviewDTO.getCreateUser());
		System.out.println("reviewDTO.getCreateDate() : " + reviewDTO.getCreateDate());
		System.out.println("reviewDTO.getUpdateUser() : " + reviewDTO.getUpdateUser());
		System.out.println("reviewDTO.getUpdateDate() : " + reviewDTO.getUpdateDate());
		System.out.println("reviewDTO.getReviewpk() : " + reviewDTO.getReviewpk());
		System.out.println("testtesttesttesttesttesttesttesttesttest");
*/

		if (null == reviewDTO.getRegNum()){
			reviewDAO.reviewCreate(reviewDTO);
		} else {
			reviewDAO.reviewUpdate(reviewDTO);
		}

	}

	/*리뷰 수정*/
	@Transactional
	@Override
	public void reviewUpdate(ReviewDTO reviewDTO){


		/*System.out.println("reviewUpdate : " + new Gson().toJson(reviewDTO));*/
		reviewDAO.reviewUpdate(reviewDTO);
	}

	/*리뷰 삭제*/
	@Transactional
	@Override
	public void reviewDel(reviewSerchDTO reviewserchDTO){

		/*System.out.println("testestestestestestestest");
		System.out.println("testestestestestestestest");
		System.out.println("testestestestestestestest");
		System.out.println("reviewserchDTO : " + new Gson().toJson(reviewserchDTO));
		*/
		reviewDAO.reviewDel(reviewserchDTO);
	}



	/*리뷰 좋아요*/
	@Transactional
	@Override
	public void reviewGoodCreate(reviewSerchDTO reviewserchDTO, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		reviewserchDTO.setCreateUser(userid);
		reviewDAO.reviewGoodCreate(reviewserchDTO);

	}

	/*리뷰 댓글 입력*/
	@Transactional
	@Override
	public void reviewReply(ReplyCommentsDTO replyCommentsDTO, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		replyCommentsDTO.setCreateUser(userid);
		reviewDAO.reviewReply(replyCommentsDTO);

	}

	/*리뷰 댓글 입력*/
	@Transactional
	@Override
	public void reviewReplyUpdate(ReplyCommentsDTO replyCommentsDTO, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		replyCommentsDTO.setCreateUser(userid);
		reviewDAO.reviewReplyUpdate(replyCommentsDTO);

	}

	/*리뷰 댓글 삭제*/
	@Transactional
	@Override
	public void reviewReplyDel(ReplyCommentsDTO replyCommentsDTO, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		replyCommentsDTO.setCreateUser(userid);
		reviewDAO.reviewReplyDel(replyCommentsDTO);

	}

	/*리뷰 댓글 출력*/
	@Override // 덮어쓰기 의미
	public List<ReplyCommentsDTO> reviewReplyOut(reviewSerchDTO reviewserchDTO){


		List<ReplyCommentsDTO> list = reviewDAO.reviewReplyOut(reviewserchDTO);
		/*System.out.println("vo : " + new Gson().toJson(list));*/

		return list;
	}

	/*리뷰 대댓글 입력*/
	@Transactional
	@Override
	public void topreplyinsetsave(ReplyCommentsDTO replyCommentsDTO, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		replyCommentsDTO.setCreateUser(userid);
//		reviewDAO.topreplyinsetsave(replyCommentsDTO);
		reviewDAO.reviewReply(replyCommentsDTO);

	}






	@Transactional
	@Override
	public void create(TestDTO testdto){

		System.out.println("Blob : " + testdto.getBlob());
		reviewDAO.create(testdto);
	}

	/*	@Transactional
	@Override // 덮어쓰기 의미
	public void create(TestDTO testdto){

		System.out.println("test 1 : " + testdto.getTest1());
		reviewDAO.create(testdto);
	}
*/


	@Override
	public List<ReviewDTO> getHomeList(Integer size) {
		return reviewDAO.getHomeList(size);
	}

	@Override
	public List<ReviewDTO> getHotList(Integer size) {
		return reviewDAO.getHotList(size);
	}

	@Override
	public Map<String, Object> getHotList(int curPage) {
		Map<String, Object> map = new HashMap<>();

		reviewSerchDTO dto = new reviewSerchDTO();
		int cnt = reviewDAO.getHotListCnt(dto);
		PageDTO page = new PageDTO();
		page = paging.Paging(page);
		page = paging.PagingMath(page, cnt);

		dto.setStart(page.getStart());
		dto.setEnd(page.getEnd());

		List<ReviewDTO> list = reviewDAO.getHotAll(dto);

		map.put("list", list);
		map.put("page", page);

		return map;
	}

	@Override
	public Map<String, Object> totalSearch(String gameKeyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("gameKeyword", gameKeyword);
		map.put("filter", "none");

		map.put("boardDivision","'자유게시판'");
		List<ReviewDTO> list1 = reviewDAO.totalSearch(map);
		map.replace("boardDivision","'자유게시판'","'게임후기', '노하우', '질문'");
		List<ReviewDTO> list2 = reviewDAO.totalSearch(map);
		map.remove("boardDivision");


		map.put("list1", list1);
		map.put("list2", list2);
		return map;

	}

	@Override
	public Map<String, Object> totalSearchMore(Map<String, Object> map) {
		int curPage = Integer.parseInt(String.valueOf(map.get("curPage")));

		int count = reviewDAO.totalSearchCount(map);

		Pager pager = new Pager(count, curPage, 10);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		map.put("start",start);
		map.put("end",end);

		String filter = (String)map.get("filter");
		if(filter.indexOf("자유게시판") != -1) {
			map.put("boardDivision", "'자유게시판'");
			List<ReviewDTO> list = reviewDAO.totalSearch(map);
			map.put("list",list);
		}else{
			map.put("boardDivision", "'게임후기', '노하우', '질문'");
			List<ReviewDTO> list = reviewDAO.totalSearch(map);
			map.put("list",list);
		}
		map.remove("boardDivision");
		map.put("count",count);
		map.put("pager",pager);

		return map;
	}
}

