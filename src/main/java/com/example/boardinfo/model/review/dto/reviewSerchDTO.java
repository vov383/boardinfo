package com.example.boardinfo.model.review.dto;

/*리뷰 검색등에 사용하는 Key값*/
public class reviewSerchDTO {

	private String searchTitle;			// 제목 및 내용 검색
	private String category;			// 카테고리
	private String reviewDetailKey;		// regNum 키 값
	private String createUser;			// 작성자 (userId)
	private int start;                  // 쿼리 리스트 변수
	private int end;                    // 쿼리 리스트 변수
	private String ReplyRegNum;			// 댓글 키 값
	private String topReplyRegNum;		// 답글 키 값



	public String getSearchTitle() {
		return searchTitle;
	}

	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getReviewDetailKey() {
		return reviewDetailKey;
	}

	public void setReviewDetailKey(String reviewDetailKey) {
		this.reviewDetailKey = reviewDetailKey;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getReplyRegNum() {
		return ReplyRegNum;
	}

	public void setReplyRegNum(String replyRegNum) {
		ReplyRegNum = replyRegNum;
	}

	public String getTopReplyRegNum() {
		return topReplyRegNum;
	}

	public void setTopReplyRegNum(String topReplyRegNum) {
		this.topReplyRegNum = topReplyRegNum;
	}
}

