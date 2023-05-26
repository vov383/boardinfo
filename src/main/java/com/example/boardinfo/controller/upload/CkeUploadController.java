package com.example.boardinfo.controller.upload;

import java.io.File;  
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.boardinfo.util.UploadFileUtils;
import com.google.gson.JsonObject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("ckeditor/*")
public class CkeUploadController {
	//로깅
	private static final Logger logger =
			LoggerFactory.getLogger(CkeUploadController.class);

	//upload 디렉토리 설정
	@Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
	String uploadPath;
	String ckimgPath = "C:\\Work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\boardinfo\\resources\\ckimg\\";

	@ResponseBody //뷰가 아니라 데이터를 리턴
	@RequestMapping("fileAttach.do")
	public void imageUpload(
			@RequestParam MultipartFile upload,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		String fileName = "";
		byte[] fileData = null;
		OutputStream out = null;
		PrintWriter printWriter = null;
		//Json 객체 생성
		JsonObject json = new JsonObject();
		
		//인코딩
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			fileName = upload.getOriginalFilename();
			logger.info("fileName : "+fileName);
			fileData = upload.getBytes();
			logger.info("fileData : "+fileData);
			
			//uuid룰 단 savedName과 datePath를 fileName에 담아서
			//파일을 폴더에 저장
			fileName = UploadFileUtils.uploadFile(ckimgPath, fileName, fileData);
			//fileName에서 연월일 경로만 따로 때
			String datePath = fileName.substring(1, 12);
			logger.info("ckimgPath : "+ckimgPath);
			logger.info("datePath : "+datePath);
			//fileName에서 s_뒤에 있는 uuid와 원래 이름만 잘라
			fileName = fileName.substring(14);
			logger.info("파일명 : "+ fileName);
			logger.info("ckimgPath+datePath+fileName : "+ckimgPath+datePath+fileName);
			
			out = new FileOutputStream(new File(ckimgPath+datePath+fileName));
			out.write(fileData);
			logger.info("fileData 점검 : "+fileData);
			out.flush(); //outputStream에 저장된 데이터를 전송하고 초기화
			
//			String fileUrl ="/ckeditor/ckImgSubmit.do?fileName=" + fileName;  
			String fileUrl = ckimgPath.replace(File.separatorChar, '/') + datePath+ fileName;  
			logger.info("파일유알엘 : "+fileUrl);
			logger.info("리플레이스 한 거 : "+ckimgPath.replace(File.separatorChar, '/'));
			logger.info("datePath : "+datePath);
			// 작성화면
            printWriter = response.getWriter();
//            printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
            
            // 업로드시 메시지 출력
        	//생성된 json 객체를 이용해 파일 업로드 + 이름 + 주소를 CkEditor에 전송
            json.addProperty("uploaded", 1);
            json.addProperty("fileName", fileName);
            json.addProperty("Url", fileUrl);
            logger.info("gson출력 확인 : "+json);
			printWriter.println(json);
			printWriter.flush();
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("파일 업로드 실패??");
		} finally {
			try {
				if(out != null) { out.close(); }
				if(printWriter != null) { printWriter.close(); }
			} catch(IOException e) { e.printStackTrace(); }
		}
	}

	@RequestMapping(value="ckImgSubmit.do")
	public void ckSubmit(
			@RequestParam(value="fileName") String fileName,
			HttpServletRequest request, 
			HttpServletResponse response) 
	   				throws ServletException, IOException{
		
		//서버에 저장된 이미지 경로
		String ckimgPath = "C:\\Work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\boardinfo\\resources\\ckimg";
		String datePath = UploadFileUtils.calcPath(ckimgPath);
		String sDirPath = ckimgPath + datePath + fileName;
		File imgFile = new File(sDirPath);
		
		//사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
		if(imgFile.isFile()){
		    byte[] buf = new byte[1024];
		    int readByte = 0;
		    int length = 0;
		    byte[] imgBuf = null;
		    
		    FileInputStream fileInputStream = null;
		    ByteArrayOutputStream outputStream = null;
		    ServletOutputStream out = null;
		    
		    try{
		        fileInputStream = new FileInputStream(imgFile);
		        outputStream = new ByteArrayOutputStream();
		        out = response.getOutputStream();
		        
		        while((readByte = fileInputStream.read(buf)) != -1){
		            outputStream.write(buf, 0, readByte);
		        }
		        
		        imgBuf = outputStream.toByteArray();
		        length = imgBuf.length;
		        out.write(imgBuf, 0, length);
		        out.flush();
		        
		    }catch(IOException e){
		        e.printStackTrace();
		    }finally {
		        outputStream.close();
		        fileInputStream.close();
		        out.close();
		    }
		}
		
	}

	@RequestMapping("ckAjax")
	@ResponseBody
	public ResponseEntity<String> imageAttach(
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request,
			HttpServletResponse response,
			MultipartHttpServletRequest multiFile) 
					throws Exception{
		
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String fileName="";
		byte[] fileData = null;
			try {
				fileName = file.getOriginalFilename();
				logger.info("fileName : "+fileName);
				fileData = file.getBytes();
				logger.info("fileData : "+fileData);
				
				//파일을 폴더에 저장
				fileName = UploadFileUtils.uploadFile(ckimgPath, fileName, fileData);
				File destFile = new File(ckimgPath + fileName);
				file.transferTo(destFile);
				logger.info("destFile : "+destFile);
				
				//업로드된 이미지의 Url을 반환
				String imageUrl = ckimgPath + "/resources/ckimg" + fileName;
				logger.info(imageUrl);
			return ResponseEntity.ok(imageUrl);
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이미지 업로드 실패");
		}
	}
		
	@ResponseBody    
	@PostMapping("drag.do")
	public void drag(MultipartFile upload, 
			HttpServletRequest request, 
			HttpServletResponse response,
			MultipartHttpServletRequest multiFile) 
					throws Exception{

		OutputStream out = null;
		PrintWriter printWriter = null;

		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String fileName = "";
		String datePath = "";
		try {
			fileName = UploadFileUtils.uploadFile(uploadPath,
					upload.getOriginalFilename(), 
					upload.getBytes());

			datePath = UploadFileUtils.calcPath(uploadPath);

		} catch (IOException e) {
			e.printStackTrace();
		}

		//outputStram에 저장된 데이터를 전송하고 초기화
		try{
			String fileUrl = uploadPath + datePath + fileName;
			out = new FileOutputStream(new File(fileUrl));
			out.write(upload.getBytes());
			out.flush();

			printWriter = response.getWriter();
			// ckEditor 로 전송	        
			fileUrl = request.getContextPath() + datePath + fileName;
			logger.info("fileUrl : "+ fileUrl);

			JsonObject json = new JsonObject();
			json.addProperty("uploaded", 1);
			json.addProperty("fileName", fileName);
			json.addProperty("url", fileUrl);
			printWriter.println(json);

			logger.info("json : "+ json);
			printWriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				if(out != null) {
					out.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			try {
				if(printWriter != null) { 
					printWriter.close(); 
				}			
			} catch(Exception e) { 
				e.printStackTrace(); 
			}
		}
	}
}
	//	@RequestMapping(value="fileupload.do", method=RequestMethod.POST)
	//	@ResponseBody
	//	public String fileUpload(HttpServletRequest req, HttpServletResponse resp, 
	//			MultipartHttpServletRequest multiFile) throws Exception {
	//		JsonObject json = new JsonObject();
	//		PrintWriter printWriter = null;
	//		OutputStream out = null;
	//		MultipartFile file = multiFile.getFile("upload");
	//		if(file != null){
	//			if(file.getSize() > 0 && StringUtils.isNotBlank(file.getName())){
	//				if(file.getContentType().toLowerCase().startsWith("image/")){
	//					try{
	//						String fileName = file.getName();
	//						byte[] bytes = file.getBytes();
	//						String uploadPath = req.getServletContext().getRealPath("/img");
	//						File uploadFile = new File(uploadPath);
	//						if(!uploadFile.exists()){
	//							uploadFile.mkdirs();
	//						}
	//						fileName = UUID.randomUUID().toString();
	//						uploadPath = uploadPath + "/" + fileName;
	//						out = new FileOutputStream(new File(uploadPath));
	//						out.write(bytes);
	//
	//						printWriter = resp.getWriter();
	//						resp.setContentType("text/html");
	//						String fileUrl = req.getContextPath() + "/img/" + fileName;
	//
	//						// json 데이터로 등록
	//						// {"uploaded" : 1, "fileName" : "test.jpg", "url" : "/img/test.jpg"}
	//						// 이런 형태로 리턴이 나가야함.
	//						json.addProperty("uploaded", 1);
	//						json.addProperty("fileName", fileName);
	//						json.addProperty("url", fileUrl);
	//
	//						printWriter.println(json);
	//					}catch(IOException e){
	//						e.printStackTrace();
	//					}finally{
	//						if(out != null){
	//							out.close();
	//						}
	//						if(printWriter != null){
	//							printWriter.close();
	//						}		
	//					}
	//				}
	//			}
	//		}
	//		return null;
	//	}	
	//
	//}	

	//	@ResponseBody
	//	@RequestMapping(value = "/ckeUpload.do", method = RequestMethod.POST)
	//	public void uploadimg(HttpServletRequest request,
	//			HttpServletResponse response,
	//			MultipartFile upload) throws Exception {
	//		logger.info("upload 들어온다! ");
	//		response.setCharacterEncoding("utf-8");
	//        response.setContentType("text/html; charset=utf-8");
	// 
	//        //파일 이름 가져오기
	//        String fileName = upload.getOriginalFilename();
	//        
	//        //파일을 바이트 배열로 변환
	//        byte[] bytes=upload.getBytes();
	//        
	//        OutputStream out =new FileOutputStream(new File(uploadPath+fileName));
	// 
	//        //서버에 write
	//        out.write(bytes);
	//        logger.info("out : "+out);
	//        //성공여부 가져오기
	//        String callback=request.getParameter("CKEditorFuncNum");
	//        
	//        //클라이언트에 이벤트 추가 (자바스크립트 실행)
	//        PrintWriter printWriter=response.getWriter(); //자바스크립트 쓰기위한 도구
	// 
	//        String fileUrl= request.getContextPath()+"/ckEimg/"+fileName;
	//        logger.info("fileUrl : "+fileUrl);
	//        JsonObject json = new JsonObject();
	//        json.addProperty("uploaded", 1);
	//        json.addProperty("fileName", fileName);
	//        json.addProperty("url", fileUrl);
	//        printWriter.println(json);
	//        
	//        if(!callback.equals("1")) { //실패시... callback이 1일 경우만 성공한 것
	//        	 printWriter.println("<script>alert('이미지 업로드에 실패했습니다.');"+"</script>");
	//        	 
	//        }else {
	//        	 logger.info("upload img 들어온다! "+fileUrl);
	//             
	//             printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("+callback+",'"+fileUrl+"','이미지가 업로드되었습니다.')"+"</script>");
	//        }
	//        printWriter.flush();
	//        
	//	}
//}
//}