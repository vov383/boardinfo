package com.example.boardinfo.controller.tboard;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.springframework.jdbc.support.JdbcUtils.isNumeric;

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
	public boolean commentInsert(
			@ModelAttribute TBCommentDTO re_dto,
			HttpSession session) {
		//세션에 저장된 아이디객체 가져와
		String create_user = (String)session.getAttribute("userid");
		re_dto.setCreate_user(create_user);
		boolean result = tbcommentService.insertReply(re_dto);
		logger.info("댓글입력 테스트" + re_dto.toString());
		//댓글 개수 증가
		int tb_num = re_dto.getTb_num();
		tboardService.increaseRecnt(tb_num);

		return result;
	}




}
