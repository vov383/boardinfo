package com.example.boardinfo.controller.upload;

import java.io.File; 
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UploadController {
	//로깅을 위한 코드
	private static final Logger logger = 
			LoggerFactory.getLogger(UploadController.class);
	
	@Resource(name="uploadPath")
	String uploadPath;
	//servlet-context.xml 에서 String uploadPath 에 설정한 
	//id와 여기 변수명이 일치 hvt
	
	//업로드를 위한 폼 페이지로 이동
	@RequestMapping(value="/upload/uploadForm", 
			method = RequestMethod.GET)
	public String uploadForm() {
		return "upload/uploadForm";
	}
	
	//업로드된 내용 처리 메소드
	@RequestMapping(value = "/upload/uploadForm", 
			method = RequestMethod.POST)
	public ModelAndView uploadForm(MultipartFile file, 
			ModelAndView mav) throws Exception {
		String savedName= file.getOriginalFilename();
		savedName = uploadFile(savedName, file.getBytes());
		mav.setViewName("upload/uploadResult");//view 처리.. 포워딩
		mav.addObject("savedName", savedName);//전달할 데이터
		
		return mav;
	}
	
	//이런 코드는 모듈화, 정형화되어 있어서 갖다 쓰면 okay
	String uploadFile(String originalName, byte[] fileData) 
			throws Exception {
		//중복된 파일 처리
		//UUID = Universal Unique IDentifier, 범용 고유 식별자
		//중복된 파일이 올라갈 경우 서버에서 자동으로 다른 이름을 생성해 업로드 시킨다.
		UUID uid = UUID.randomUUID();
		//f6219330-8fcc-4e03-8750-06c52d4d04a0 이렇게 uuid가 생성됨
		//중복파일을 올려보면 다른 uuid가 붙는걸 알 수 있음
		
		String savedName = uid.toString()+"_"+originalName;
		
		//new File(디렉토리, 파일이름)
		File target= new File(uploadPath, savedName);
		//java.io객체의 File 패키지
		
		//첨부파일을 임시디렉토리에서 우리가 지정한 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}
	
}
