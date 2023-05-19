package com.example.boardinfo.model.sample.dto;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.example.boardinfo.service.sample.SampleService;

public class SampleDTO {
	@Inject
	SampleService sampleService;
	
	@RequestMapping("sample.do")
	public String sample(String test_message) {
		test_message = sampleService.sample(test_message);
		return test_message;
	}
	
}
