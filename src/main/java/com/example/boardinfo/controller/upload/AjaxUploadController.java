package com.example.boardinfo.controller.upload;

import java.io.File; 
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import com.example.boardinfo.service.game.GameService;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.boardinfo.service.tboard.TBoardService;
import com.example.boardinfo.util.MediaUtils;
import com.example.boardinfo.util.UploadFileUtils;

@Controller
public class AjaxUploadController {

	//로깅
	private static Logger logger = 
			LoggerFactory.getLogger(AjaxUploadController.class);
	
	@Inject
	TBoardService tboardService;
	@Inject
	GameService gameService;

	
	//upload 디렉토리 설정
	@Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
	String uploadPath;
	
	@RequestMapping(value = "upload/uploadAjax", method = RequestMethod.GET)
	public String uploadAjax() {
		return "/upload/uploadAjax";
	}
	
	@ResponseBody //객체를 json형식으로 return can (서버 => 클라이언트) 
	// 그 역은 @RequestBody
	@RequestMapping(value = "/upload/uploadAjax", 
			method = RequestMethod.POST, 
			produces = "text/plain;charset=utf-8") //한글이 깨지지 않도록 보완처리
	// ResponseEntity : 업로드한 파일 정보와 Http 상태 코드를 함께 리턴
	public ResponseEntity<String> uploadAjax(MultipartFile file) 
			throws Exception {
		
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(
				uploadPath, file.getOriginalFilename(), 
				file.getBytes()), HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) 
			throws Exception{
		//서버의 파일을 다운로드하기 위한 스트림
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			//확장자 검사
			String formatName = 
					fileName.substring(fileName.lastIndexOf('.') + 1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			//헤더 구성 객체
			HttpHeaders headers = new HttpHeaders();
			
			//InputStream 생성
			in = new FileInputStream(uploadPath + fileName);
			fileName = fileName.substring(fileName.indexOf('.')+1);
			
			//다운로드용 컨텐츠 타입
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\""
					+ new String(
							fileName.getBytes("utf-8"), "iso-8859-1")+"\"");
			
			//바이트 배열(내용), 헤더, 상태코드 3개를 묶어서 전달
			entity = new ResponseEntity<byte[]>(
					IOUtils.toByteArray(in), headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			//실패했을 때 에러메시지 전달
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if(in != null)
				in.close(); //스트림 닫기
		}
		return entity;
	}
	
	@ResponseBody //뷰로 리턴하지 않고 데이터를 리턴 json 같이..
	@RequestMapping(value = "/upload/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		logger.info("fileName:"+fileName);
		
		//확장자 검사
		String formatName = 
				fileName.substring(fileName.lastIndexOf('.') + 1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) { //이미지파일이면 front + end = 원본파일명
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front + end).replace(
					'/', File.pathSeparatorChar)).delete();
		}
		
		//기타종류 원본파일(이미지면 썸네일 삭제)
		new File(uploadPath + fileName.replace(
				'/', File.pathSeparatorChar)).delete();
		
		//레코드 삭제 기능 추가
		tboardService.deleteFile(fileName);
		gameService.deleteFile(fileName);
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		// 여기 deleted 는 uploadAjax.jsp 에서 
		// ajax success에 정의해놓은 result=="deleted" 다.
	}


}
