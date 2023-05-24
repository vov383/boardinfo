package com.example.boardinfo.controller.tboard;

import com.example.boardinfo.controller.upload.AjaxUploadController;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("tupload/*")
public class TuploadAjaxController {

    //로깅
    private static Logger logger =
            LoggerFactory.getLogger(AjaxUploadController.class);


    //upload 디렉토리 설정
    @Resource(name = "uploadPath") //servlet-context에 설정된 id값과 맞춤
            String uploadPath;

    @ResponseBody //객체를 json형식으로 return can (서버 => 클라이언트)
    // 그 역은 @RequestBody
    @RequestMapping(value = "/uploadAjax",
            method = RequestMethod.POST,
            produces = "text/plain;charset=utf-8") //한글이 깨지지 않도록 보완처리
    // ResponseEntity : 업로드한 파일 정보와 Http 상태 코드를 함께 리턴
    public ResponseEntity<String> uploadAjax(MultipartFile file)
            throws Exception {

        return new ResponseEntity<String>(UploadFileUtils.uploadFile(
                uploadPath, file.getOriginalFilename(),
                file.getBytes()), HttpStatus.OK);
    }
}
