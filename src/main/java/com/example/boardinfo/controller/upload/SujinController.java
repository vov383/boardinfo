//package com.example.boardinfo.controller.upload;
//
//public class SujinController {
//
//	else if(uri.indexOf("imageUpload.do")!=-1) {
//		String savepath = "C:\\work_java\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Library\\uploads\\image";
//		int sizeLimit = 5 * 1024 * 1024; //5메가로 제한
//		if(request.getContentLength()>sizeLimit) { 
////오류 메시지(5메가 이상 첨부한 경우)
//		}
//		else {
//			MultipartRequest multi = new MultipartRequest(request, savepath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
//			String fileName = multi.getFilesystemName("upload"); //파일의 이름 얻기
//			String fileUrl = request.getContextPath() + "/uploads/image/" + fileName;
//			Map<String, Object> map = new HashMap<>();
//			map.put("uploaded", 1);
//			map.put("fileName", fileName);
//			map.put("url", fileUrl);
//			Gson returnGson = new Gson();
//			String json = returnGson.toJson(map);
//			PrintWriter writer = response.getWriter();
//			writer.write(json.toString());
//			writer.flush();
//			writer.close();
//		}
//	}
//}
