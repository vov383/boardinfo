package com.example.boardinfo.controller.tboard;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("tbComment/*")
public class TBCommentController {
	
	//로거
	private static final Logger logger
			= LoggerFactory.getLogger(TBCommentController.class);
	@Inject
	TBCommentService tbcommentService;

	@Inject
	TBoardService tboardService;

	@RequestMapping("list.do")
	public ModelAndView getList(
			@RequestParam("tb_num") int tb_num,
			ModelAndView mav){

		List<TBCommentDTO> re_list = tbcommentService.getCommentList(tb_num);
		mav.setViewName("tboard/tbComment_list"); //포워딩 뷰
		mav.addObject("re_list", re_list);

//		logger.info("re_list가 리턴되기 전까지 잘 나오는지 체크 :");
		return mav;
	}

	@RequestMapping("insert.do")
	public void commentInsert(
			@RequestParam("content") String content,
			@RequestParam("tb_num") int tb_num,
			HttpSession session) {
		//세션에 저장된 아이디객체 가져와
		String create_user = (String)session.getAttribute("userid");
		TBCommentDTO re_dto = new TBCommentDTO();
		re_dto.setContent(content);
		re_dto.setTb_num(tb_num);
		re_dto.setCreate_user(create_user);

		//테이블에 저장 처리
		tbcommentService.insertComment(re_dto);
		//게시물 댓글 개수 증가 처리
		tboardService.increaseRecnt(tb_num);

		//ajax로 값만 넘기면 끝
	}
	@RequestMapping("/update/{tb_num}")
//	public String commentUpdate(
	public ModelAndView commentUpdate(
			@PathVariable("tb_num") int tb_num,
			@RequestParam("reply_reg_num") int reply_reg_num,
			@RequestParam("content") String content
	){
//		logger.info("tb_num 확인 : "+tb_num);
//		logger.info("reply_reg_num 확인 : "+reply_reg_num);
//		logger.info("content 확인 : "+content);
		tbcommentService.updateComment(reply_reg_num, content);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tboard/viewPost");
		mav.addObject("dto", tboardService.viewPost(tb_num));
		return mav;
		//undefined
	}
	@RequestMapping("/delete/{tb_num}")
	public ModelAndView commentDelete(
			@RequestParam("reply_reg_num") int reply_reg_num,
			@PathVariable("tb_num") int tb_num
	){
		logger.info("tb_num 확인 : "+tb_num);
		logger.info("reply_reg_num 확인 : "+reply_reg_num);
		tbcommentService.deleteComment(reply_reg_num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tboard/viewPost");
		mav.addObject("dto", tboardService.viewPost(tb_num));
		return mav;
	}
}
