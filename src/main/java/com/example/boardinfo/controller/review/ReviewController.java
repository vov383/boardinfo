package com.example.boardinfo.controller.review;

import com.example.boardinfo.model.review.dto.ReviewDTO;
import com.example.boardinfo.model.review.dto.TestDTO;
import com.example.boardinfo.model.review.dto.reviewSerchDTO;
import com.example.boardinfo.service.review.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

@Controller
@RequestMapping("review/*")
public class ReviewController {
	@Inject
	ReviewService reviewservice;

	// 리뷰 리스트 페이지
	@RequestMapping("reviewlist.do")
	public ModelAndView revewlist(@ModelAttribute reviewSerchDTO reviewserchDTO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/gameReviewMain");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
//		System.out.println("reviewservice.reviewlist().get(0).getCreateDate() : " + reviewservice.reviewlist().get(0).getCreateDate());
		return mav;
	}

	// 리뷰 상세 페이지
	@RequestMapping("reviewdetail.do")
	public ModelAndView revewDetail(@ModelAttribute reviewSerchDTO reviewserchDTO) {
		ModelAndView mav = new ModelAndView();

/*
		System.out.println("testestestestest");
		System.out.println("testestestestest");
		System.out.println("testestestestest");
		System.out.println("reviewserchDTO : " + reviewserchDTO.getReviewDetailKey());
*/

		mav.setViewName("review/reviewDetail");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
		return mav;
	}

	// 리뷰 입력할 페이지
	@RequestMapping("reviewInsert.do")
	public String insert(@ModelAttribute ReviewDTO reviewDTO){
		return "/review/ReviewInsert";
	}



	// 체크 에디터 적용 테스트
	public class ImageUploadController {
		// 이미지 업로드
		// product_edit페이지에서 맵핑되는 메소드
		@RequestMapping("imageUpload.do")

		// 이미지를 저장하고, 불러오고, 업로드하기위해 매개변수를 선언
		public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload)
		//MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하게 된다
				throws Exception {

			// 한글깨짐을 방지하기위해 문자셋 설정
			response.setCharacterEncoding("utf-8");

			// 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
			response.setContentType("text/html; charset=utf-8");

			// 업로드한 파일 이름
			String fileName = upload.getOriginalFilename();

			// 파일을 바이트 배열로 변환
			byte[] bytes = upload.getBytes();

			// 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
			String uploadPath = "C:\\Users\\taw\\IdeaProjects\\board-info\\src\\main\\webapp\\WEB-INF\\views\\images\\reviewTest";
/*
			프로젝트는 개발 디렉토리에 저장이 되는데 이미지를 업로드할 디렉토리를 개발 디렉토리로 설정하면 일일이 새로고침을 해주어야되서
			불편하기 때문에 이미지를 업로드할 디렉토리를 배포 디렉토리로 설정한다.
*/
			OutputStream out = new FileOutputStream(new File(uploadPath + fileName));

			// 서버로 업로드
			// write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
			// 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
			out.write(bytes);

			// 클라이언트에 결과 표시
			String callback = request.getParameter("CKEditorFuncNum");

			// 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
			PrintWriter printWriter = response.getWriter();
			String fileUrl = request.getContextPath() + "/images/" + fileName;
			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
					+ "','이미지가 업로드되었습니다.')" + "</script>");
			printWriter.flush();
		}
	}






	// 리뷰 저장후 페이지
	@RequestMapping("reviewinsertsave.do")
	public String insertPage(@ModelAttribute ReviewDTO reviewDTO){
		/*System.out.println("testtesttesttesttest");*/
		reviewservice.reviewCreate(reviewDTO);
		return "/review/gameReviewMain";
	}

	// 수정 및 삭제 할 페이지
	@RequestMapping("reviewedit.do")
	public ModelAndView edit(@ModelAttribute reviewSerchDTO reviewserchDTO){
		ModelAndView mav = new ModelAndView();

/*
		System.out.println("testestestestest");
		System.out.println("testestestestest");
		System.out.println("testestestestest");
		System.out.println("reviewserchDTO : " + reviewserchDTO.getReviewDetailKey());
*/

		mav.setViewName("review/reviewEdit");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
		return mav;
	}

	// 수정 후 페이지
	@RequestMapping("revieweditsave.do")
	public ModelAndView editSave(@ModelAttribute ReviewDTO reviewDTO){
		ModelAndView mav = new ModelAndView();
		/*System.out.println("testtesttesttesttest");*/
		reviewservice.reviewUpdate(reviewDTO);
		reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
		reviewserchDTO.setReviewDetailKey(reviewDTO.getRegNum());
		mav.setViewName("/review/reviewDetail");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));

		return mav;
	}


	// 삭제 후 페이지
	@RequestMapping("reviewdelsave.do")
	public ModelAndView reviewDelSave(@ModelAttribute reviewSerchDTO reviewserchDTO){
		ModelAndView mav = new ModelAndView();
		System.out.println("testtesttesttesttest");
		System.out.println("testtesttesttesttest");
		System.out.println("testtesttesttesttest");
		System.out.println("reviewserchDTO.getReviewDetailKey() : "+ reviewserchDTO.getReviewDetailKey());

		reviewservice.reviewDel(reviewserchDTO);
		reviewserchDTO = new reviewSerchDTO();
		mav.setViewName("/review/gameReviewMain");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));

		return mav;
	}






	// Blob Test, 입력P
    @RequestMapping("reviewBlobInsert.do")
    public String insert(@ModelAttribute TestDTO testdto){
        return "/review/ReviewBlobInsert";
    }

    // Blob Test, 저장P
    @RequestMapping("reviewBlobInsertPage.do")
    public String insertPage(@ModelAttribute TestDTO testdto){
        reviewservice.create(testdto);
        return "/review/ReviewBlobInsert";
    }





	/*
	@RequestMapping("reviewInTest.do")
	public String insert(@ModelAttribute TestDTO testdto){
		return "/review/reviewinset";
	}*/


/*	// 페이지 열기
	@RequestMapping("reviewInTest.do")
	public String insert(@ModelAttribute TestDTO testdto){

		return "/review/reviewinset";

	}

	// 저장
	@RequestMapping("reviewInTestInsertPage.do")
	public String insertPage(@ModelAttribute TestDTO testdto){
		reviewservice.create(testdto);
		return "/review/reviewInTest";

	}
*/


}