package com.example.boardinfo.controller.tboard;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("tbComment/*")
public class TBCommentController {
	
	//로거
	private static final Logger logger
			= LoggerFactory.getLogger(TBCommentController.class);
	@Inject
	TBCommentService tbcommentService;

	@Inject
	TBoardService tboardService;

	@RequestMapping("replyList")
	@ResponseBody
	public Map<String, Object> getList(
			@RequestParam int tb_num){
//		logger.info("tb_num 잘 넘어오니 : "+tb_num);
		List<TBCommentDTO> re_list = tbcommentService.getCommentList(tb_num);
		Map<String, Object> map = new HashMap<>();
		map.put("re_list", re_list);
//		logger.info("list가 리턴되기 전까지 잘 나오는지 체크 :"+re_list.toString());
		return map;
	}

	@RequestMapping("insertReply.do")
	public boolean replyInsert(
			@ModelAttribute TBCommentDTO re_dto,
			HttpSession session) {
		//세션에 저장된 아이디객체 가져와
		String create_user = (String)session.getAttribute("userid");
		re_dto.setCreate_user(create_user);

		boolean result = tbcommentService.insertReply(re_dto);
		logger.info("댓글입력 테스트" + re_dto.toString());


		return result;


	}

	@RequestMapping("changeReply.do")
	@ResponseBody
	public Map<String, Object> changeReply(
			@RequestParam int reply_reg_num
	){
		String content = tbcommentService.getReplyContent(reply_reg_num);
		Map<String, Object> map = new HashMap<>();
			map.put("reply_reg_num", reply_reg_num);
		map.put("content", content);
		return map;
	}


	@RequestMapping("editReply.do")
	@ResponseBody
	public boolean editeReply(
			@ModelAttribute TBCommentDTO re_dto,
			HttpSession session
	){
		//세션에 저장된 아이디객체 가져와
		String update_user = (String)session.getAttribute("userid");
		re_dto.setUpdate_user(update_user);
		boolean result = tbcommentService.editReply(re_dto);
		return result;
	}
	@RequestMapping("deleteReply.do")
	@ResponseBody
	public boolean deleteReply(
			@ModelAttribute TBCommentDTO re_dto,
			HttpSession session
	){
		int reply_reg_num = re_dto.getReply_reg_num();
		//세션에 저장된 아이디 가져와
		String update_user = (String)session.getAttribute("userid");

		boolean result = tbcommentService.deleteReply(reply_reg_num, update_user);
		logger.info("댓글삭제 테스트");
		return result;

	}

}
