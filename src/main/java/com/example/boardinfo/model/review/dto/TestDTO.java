package com.example.boardinfo.model.review.dto;

import java.util.Date;

public class TestDTO {				// 리뷰 입력 테스트 테이블

	private String test1;			// 테스트 1 컬럼
	private String blob;			// Blob 테스트 컬럼


	@Override
	public String toString() {
		return "TestDTO [test1=" + test1 + "]";
	}


	public String getTest1() {
		return test1;
	}

	public void setTest1(String test1) {
		this.test1 = test1;
	}

	public String getBlob() {
		return blob;
	}

	public void setBlob(String blob) {
		this.blob = blob;
	}
}