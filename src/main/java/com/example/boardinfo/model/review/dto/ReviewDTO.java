package com.example.boardinfo.model.review.dto;

public class ReviewDTO {

	private String regNum;			// 리뷰 테이블 PK
	private String category;		// 카테고리 : 게임, 모임
	private String nickName;		// 회원 닉네임
	private String views;			// 조회수
	private String gnum;			// 게임 테이블 PK
	private String gametitle;		// 게임 타이틀
	private String gatheringId;		// 모임 테이블 PK
	private String title;			// 리뷰 제목
	private String funScore;		// 재미 점수
	private String reviewScore;		// 리뷰 점수
	private String gameScore;		// 게임 난이도
	private String reviewDetail;	// 리뷰 내용 (사진 포함)
	private String good;			// 좋아요 여부 (기본값 : N)
	private String del;				// 삭제 여부 (기본값 : N)
	private String createUser;		// 등록자
	private String createDate;		// 등록 일자
	private String updateUser;		// 수정자
	private String updateDate;		// 수정 일자

	public String getRegNum() {
		return regNum;
	}

	public void setRegNum(String regNum) {
		this.regNum = regNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getViews() {
		return views;
	}

	public void setViews(String views) {
		this.views = views;
	}

	public String getGnum() {
		return gnum;
	}

	public void setGnum(String gnum) {
		this.gnum = gnum;
	}

	public String getGametitle() {
		return gametitle;
	}

	public void setGametitle(String gametitle) {
		this.gametitle = gametitle;
	}

	public String getGatheringId() {
		return gatheringId;
	}

	public void setGatheringId(String gatheringId) {
		this.gatheringId = gatheringId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFunScore() {
		return funScore;
	}

	public void setFunScore(String funScore) {
		this.funScore = funScore;
	}

	public String getReviewScore() {
		return reviewScore;
	}

	public void setReviewScore(String reviewScore) {
		this.reviewScore = reviewScore;
	}

	public String getGameScore() {
		return gameScore;
	}

	public void setGameScore(String gameScore) {
		this.gameScore = gameScore;
	}

	public String getReviewDetail() {
		return reviewDetail;
	}

	public void setReviewDetail(String reviewDetail) {
		this.reviewDetail = reviewDetail;
	}

	public String getGood() {
		return good;
	}

	public void setGood(String good) {
		this.good = good;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}