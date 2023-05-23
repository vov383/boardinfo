package com.example.boardinfo.model.review.dto;

import java.util.Date;

public class TestDTO {				// 리뷰 입력 테스트 테이블

	private String test1;			// 테스트 1 컬럼


	public TestDTO() {}


	public TestDTO(String test1) {
		super();
		this.test1 = test1;
	}


	@Override
	public String toString() {
		return "GameDTO [test1=" + test1 + "]";
	}

	public String getTest1() {
		return test1;
	}

	public void setTest1(String test1) {
		this.test1 = test1;
	}
}