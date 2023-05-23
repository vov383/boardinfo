package com.example.boardinfo.controller.upload;

import java.io.File;  
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ImageUploadController {
	//로깅
	private static final Logger logger = 
			LoggerFactory.getLogger(ImageUploadController.class);
	
	
	@ResponseBody
	@RequestMapping("imageUpload.do")
	public Map<String, Object> imageUpload(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam MultipartFile upload) throws Exception {
		
		OutputStream out = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		Map<String, Object> map = null;
		
		try {
			//업로드한 파일 이름
			String fileName=upload.getOriginalFilename();
			//파일을 바이트 배열로 변환
			byte[] bytes=upload.getBytes();
			String uploadPath = "D:\\sj\\board_info_진짜\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\boardinfo\\resources\\uploaded_images\\";
			//String uploadPath="C:\\Work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\boardinfo\\resources\\uploaded_images\\";
			out = new FileOutputStream(new File(uploadPath+fileName));
			//서버로 업로드
			out.write(bytes);
			
			//서버=>클라이언트로 텍스트 전송
			String fileUrl=request.getContextPath()+"/uploaded_images/"+fileName;
			
			map = new HashMap<String, Object>();
			map.put("filename", fileName);
			map.put("uploaded", 1);
			map.put("url", fileUrl);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(out != null) {
					out.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return map;
	}
}
