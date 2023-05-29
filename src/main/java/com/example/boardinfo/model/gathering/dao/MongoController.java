package com.example.boardinfo.model.gathering.dao;

import javax.inject.Inject;

import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.boardinfo.service.chat.MongoService;


@Controller
public class MongoController {
	
	
	@Inject MongoService service;
	
		
		@RequestMapping("/mongo/insert.do")
		public String insert() {
			System.out.print("넣을꺼야");
			service.insert();
			return "redirect:/gathering/add.do";
		}
		
	

}
