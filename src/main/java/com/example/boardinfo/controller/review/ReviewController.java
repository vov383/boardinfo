package com.example.boardinfo.controller.review;

import com.example.boardinfo.model.review.dto.*;
import com.example.boardinfo.service.review.ReviewService;
import com.example.boardinfo.service.review.paging;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("review/*")
public class ReviewController {
	@Inject
	ReviewService reviewservice;

	// 리뷰 리스트 페이지
	@RequestMapping("reviewlist.do")
	public ModelAndView revewlist(@ModelAttribute reviewSerchDTO reviewserchDTO, HttpSession session, PageDTO page, @RequestParam(name="freeFlag") String freeFlag) {

		String userid = (String) session.getAttribute("userid");
		ModelAndView mav = new ModelAndView();

		/*조회 쿼리 이전에 페이징 처리 먼저 작업 → 조회 쿼리 이전에 불러와야 하기 때문임*/
/*
		System.out.println("pagepagepagepagepagepagepagepagepagepage : " + new Gson().toJson(page));
		→ 0값으로 조회됨
*/
//		System.out.println("freeFlag : " + freeFlag);
		if ("Y".equals(freeFlag) || "N".equals(freeFlag)) {
			reviewserchDTO.setFreeFlag(freeFlag);
		}

		if ("Y".equals(reviewserchDTO.getFreeFlag())) {
			reviewserchDTO.setBoardDivision("'자유게시판'");
		} else {
			reviewserchDTO.setBoardDivision("'게임후기', '노하우', '질문'");
		}


		page = paging.Paging(page);

		mav.setViewName("review/gameReviewMain");

		/*내가 보는 리스트의 총개수*/
		int cnt = reviewservice.reviewListCnt(reviewserchDTO);
		page = paging.PagingMath(page, cnt);

		reviewserchDTO.setStart(page.getStart());
		reviewserchDTO.setEnd(page.getEnd());

		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
		mav.addObject("page", page);
		mav.addObject("freeFlag", reviewserchDTO.getFreeFlag());

		return mav;
	}

	// 리뷰 상세 페이지
	@RequestMapping("reviewdetail.do")
	public ModelAndView revewDetail(@ModelAttribute reviewSerchDTO reviewserchDTO, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		String userid = (String) session.getAttribute("userid");

		mav.setViewName("review/reviewDetail");
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
		mav.addObject("userid", userid);

		/*댓글 출력*/
		mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));
		mav.addObject("freeFlag", reviewserchDTO.getFreeFlag());

		/*게임 목록 출력*/
		mav.addObject("gameList", reviewservice.gameListOut(reviewserchDTO));

		return mav;
	}


	// 리뷰 좋아요 페이지
	@RequestMapping("reviewdetailGood.do")
	public ModelAndView reviewdetailGood(@ModelAttribute reviewSerchDTO reviewserchDTO, HttpSession session) {

		//좋아요
		reviewservice.reviewGoodCreate(reviewserchDTO, session);

		String userid = (String) session.getAttribute("userid");
		ModelAndView mav = new ModelAndView();

		/*userid가 null이면 로그인 페이지로 이동*/
		if (null == userid){
			mav.setViewName("member/login");

			/*userid가 null이 아니면 좋아요 적용*/
		} else {
			mav.setViewName("review/reviewDetail");
			mav.addObject("userid", userid);
			mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));

			/*댓글 출력*/
			mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));
		}

		return mav;
	}

	// 리뷰 댓글 페이지
	@RequestMapping("reviewreplysave.do")
	public ModelAndView reviewReply(@ModelAttribute ReplyCommentsDTO replyCommentsDTO, HttpSession session) {

		String userid = (String) session.getAttribute("userid");
		ModelAndView mav = new ModelAndView();

		/*userid가 null이면 로그인 페이지로 이동*/
		if (null == userid){
			mav.setViewName("member/login");

			/*userid가 null이 아니면 댓글 입력 페이지 이동*/
		} else {

			/*댓글 입력*/
			reviewservice.reviewReply(replyCommentsDTO, session);

			/*댓글의 상단 리뷰 내용 출력*/
			reviewSerchDTO review = new reviewSerchDTO();
			review.setReviewDetailKey(replyCommentsDTO.getRegNum());
			review.setFreeFlag(replyCommentsDTO.getFreeFlag());
			mav = revewDetail(review, session);




//
//			/*댓글의 상단 리뷰 내용 출력*/
//			mav.setViewName("review/reviewDetail");
//			reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
//			reviewserchDTO.setReviewDetailKey(replyCommentsDTO.getRegNum());
//			mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
//
//			/*댓글 출력*/
//			mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));
//
//			mav.addObject("userid", userid);
		}

		return mav;
	}

	// 리뷰 대댓글 입력
	@RequestMapping("topreplyinsetsave.do")
	public ModelAndView topreplyinsetsave(@ModelAttribute ReplyCommentsDTO replyCommentsDTO, HttpSession session) {
//		System.out.println("1");

		String userid = (String) session.getAttribute("userid");
		ModelAndView mav = new ModelAndView();

		/*userid가 null이면 로그인 페이지로 이동*/
		if (null == userid){
			mav.setViewName("member/login");

		/*userid가 null이 아니면 답글 입력 페이지 이동*/
		} else {
			/*답글 입력*/
			reviewservice.topreplyinsetsave(replyCommentsDTO, session);
//			System.out.println("2");

			reviewSerchDTO review = new reviewSerchDTO();
			review.setReviewDetailKey(replyCommentsDTO.getRegNum());
			review.setFreeFlag(replyCommentsDTO.getFreeFlag());
			mav = revewDetail(review, session);
//
//			/*댓글의 상단 리뷰 내용 출력*/
//			mav.setViewName("review/reviewDetail");
//			reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
//			reviewserchDTO.setReviewDetailKey(replyCommentsDTO.getRegNum());
//			reviewserchDTO.setFreeFlag(replyCommentsDTO.getFreeFlag());
//			mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
//
//			/*댓글 출력*/
//			mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));
//
//			mav.addObject("userid", userid);
		}
		return mav;
	}


	// 리뷰 입력 및 수정할 페이지
	@RequestMapping("reviewInsert.do")
	public ModelAndView reviewInsert(@ModelAttribute reviewSerchDTO reviewserchDTO, HttpSession session){

		String userid = (String) session.getAttribute("userid");
		ModelAndView mav = new ModelAndView();

		/*userid가 null이면 로그인 페이지로 이동*/
		if (null == userid){
			mav.setViewName("member/login");

			/*userid가 null이 아니면 답글 입력 페이지 이동*/
		} else {

			/*첫 입력 페이지*/
			mav.setViewName("review/ReviewInsert");

		if (null == reviewserchDTO.getReviewDetailKey()) reviewserchDTO.setReviewDetailKey("1");

			/*수정 페이지*/
			mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
			mav.addObject("freeFlag", reviewserchDTO.getFreeFlag());
		}

		return mav;
	}


	// 댓글 수정할 페이지
	@RequestMapping("reviewreplyedit.do")
	public ModelAndView reviewreplyedit(@ModelAttribute ReplyCommentsDTO replycommentsDTO, HttpSession session){

		/*댓글 수정*/
		reviewservice.reviewReplyUpdate(replycommentsDTO, session);

		/*댓글의 상단 리뷰 내용 출력*/
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/reviewDetail");

		String userid = (String) session.getAttribute("userid");
		mav.addObject("userid", userid);

		reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
		reviewserchDTO.setReviewDetailKey(replycommentsDTO.getRegNum());
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));

		/*댓글 출력*/
		mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));

		return mav;

	}

	// 댓글 삭제
	@RequestMapping("reviewreplydel.do")
	public ModelAndView reviewreplydel(@ModelAttribute ReplyCommentsDTO replycommentsDTO, HttpSession session){

		/*댓글 입력*/
		reviewservice.reviewReplyDel(replycommentsDTO, session);

		/*댓글의 상단 리뷰 내용 출력*/
		ModelAndView mav = new ModelAndView();
		mav.setViewName("review/reviewDetail");

		String userid = (String) session.getAttribute("userid");
		mav.addObject("userid", userid);

		reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
		reviewserchDTO.setReviewDetailKey(replycommentsDTO.getRegNum());
		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));

		/*댓글 출력*/
		mav.addObject("commentList", reviewservice.reviewReplyOut(reviewserchDTO));

		return mav;

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


	// 리뷰 저장 후 페이지
	@RequestMapping("reviewinsertsave.do")
	public String insertPage(@ModelAttribute ReviewDTO reviewDTO, ChoiceGameDTO choiceGameDTO, HttpSession session){

		reviewservice.reviewCreate(reviewDTO, choiceGameDTO, session);

//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("review/gameReviewMain");
//
//		reviewSerchDTO reviewserchDTO = new reviewSerchDTO();
//		mav.addObject("list", reviewservice.reviewlist(reviewserchDTO));
//		return mav;

		return "redirect:/review/reviewlist.do?freeFlag="+reviewDTO.getFreeFlag();
	}


	// 수정 후 페이지
	@RequestMapping("revieweditsave.do")
	public String editSave(@ModelAttribute ReviewDTO reviewDTO){
		reviewservice.reviewUpdate(reviewDTO);
		return "redirect:/review/reviewlist.do?freeFlag="+reviewDTO.getFreeFlag();
	}

	// 삭제 후 페이지
	@RequestMapping("reviewdelsave.do")
	public String reviewDelSave(@ModelAttribute reviewSerchDTO reviewserchDTO){

		reviewservice.reviewDel(reviewserchDTO);

		return "redirect:/review/reviewlist.do?freeFlag="+reviewserchDTO.getFreeFlag();

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


	@ResponseBody
	@GetMapping("/homeList")
	public Map<String, List<ReviewDTO>> getHomeList(
			@RequestParam(value="size", required=false) Integer size){

		if(size == null) size = 8;
		List<ReviewDTO> list = reviewservice.getHomeList(size);

		Map<String, List<ReviewDTO>> map = new HashMap<>();
		map.put("list", list);

		return map;
	}


	@ResponseBody
	@GetMapping("/hotList")
	public Map<String, List<ReviewDTO>> getHotList(
			@RequestParam(value="size", required=false) Integer size
			){

		if(size == null) size = 8;
		List<ReviewDTO> list = reviewservice.getHotList(size);

		Map<String, List<ReviewDTO>> map = new HashMap<>();
		map.put("list", list);

		return map;
	}

	@GetMapping("hotAll.do")
	public ModelAndView getHotAll(ModelAndView mav, @RequestParam(required = false, defaultValue = "1") int curPage){
		Map<String, Object> map = new HashMap<>();

		map = reviewservice.getHotList(curPage);
		mav.setViewName("review/reviewMain_hot");
		mav.addObject("map", map);
		return mav;
	}
}