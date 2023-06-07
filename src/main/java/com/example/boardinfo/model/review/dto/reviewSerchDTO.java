package com.example.boardinfo.model.review.dto;

/*리뷰 검색등에 사용하는 Key값*/
public class reviewSerchDTO {

	private String searchTitle;			// 제목 및 내용 검색
	private String reviewDetailKey;		// regNum 키 값
	private String createUser;			// 작성자 (userId)



	public String getSearchTitle() {
		return searchTitle;
	}

	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
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

}

