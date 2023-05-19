package com.example.boardinfo.controller.tboard;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;

@Controller
@RequestMapping("tbComment/*")
public class TBCommentController {
	
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
		return mav; 
	}
	
	//@Transactional
	@RequestMapping("insert.do")
	public void commentInsert(
			@RequestParam("content") String content,
			@RequestParam("tb_num") int tb_num,
			HttpSession session) {
		//세션에 저장된 아이디객체 가져와
//		String create_user = (String)session.getAttribute("userid");
		String create_user = "test_replyer";
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
}
