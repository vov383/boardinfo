package com.example.boardinfo.controller.sample;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.boardinfo.service.sample.SampleService;

@Controller
@RequestMapping("sample/*") //공통 url mapping
public class SampleController {
	@Inject
	SampleService sampleService;
	
	@RequestMapping("sample.do")
	public String sample() {
		return "sample/main";
	}
}
