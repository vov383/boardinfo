package com.example.boardinfo.controller.tboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.service.tboard.Pager;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;

@Controller
@RequestMapping("tboard/*")
public class TBoardController {
	
	//로깅
	private static final Logger logger 
			= LoggerFactory.getLogger(TBoardController.class);
	
	@Inject
	TBoardService tboardService;
	
	@Inject
	TBCommentService tbcommentService;
	
	@RequestMapping("list.do")
	public ModelAndView list(
			@RequestParam(defaultValue = "all") String select_category,
			@RequestParam(defaultValue = "all") String search_option,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "1") int curPage) 
					throws Exception{
		//레코드 갯수 계산
		int count=tboardService.countArticle(
				select_category, search_option, keyword);
		System.out.println("총 게시물 갯수 :"+count);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		List<TBoardDTO> list = tboardService.list(
				select_category, search_option, keyword, start, end);
		ModelAndView mav=new ModelAndView();
		System.out.println("리스트 : "+list);
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", keyword);
		map.put("pager", pager);
		map.put("count", count);
		map.put("list", list);
		mav.setViewName("tboard/list");
		mav.addObject("map", map);
		System.out.println("맵 데이터 : "+map);
		return mav;
	}
	
	@RequestMapping("write.do")
	public String write() {
		//글쓰기 폼 페이지로 이동
		return "tboard/write";
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute TBoardDTO dto) 
			throws Exception{
		//modelAttribute 는 생략해도 되지만.. 써주는 것도 좋음
		//로그인 한 사람만 들어올 수 있으니까 HttpSession 써야함
		
		//이름이 없기 때문에 session에서 id를 가져와야 한다.
//		String create_user = (String)session.getAttribute("userid");
		dto.setCreate_user("testuser");
				
		//레코드 저장
		tboardService.insert(dto);
		
		//게시물 목록 갱신처리
		return "redirect:/tboard/list.do";
	}
	
	@RequestMapping("view/{tb_num}")
	public ModelAndView view(@PathVariable("tb_num") int tb_num, 
			HttpSession session) throws Exception {
		//조회수 증가처리
		tboardService.increaseViewCount(tb_num, session);
		TBoardDTO dto = tboardService.viewPost(tb_num);
		
//		int re_count = tbcommentService.getCommentCount(tb_num);
//		dto.setRe_count(re_count);
//		Map<String, Object> map = new HashMap<>();
//		map.put("dto", dto);
//		map.put("re_count", re_count);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("tboard/viewPost");
//		mav.addObject("map", map);
		mav.addObject("dto", dto);
		
		return mav;
		
	}
	
	@RequestMapping("change.do")
	public ModelAndView moveUpdatePage(int tb_num) {
		
		TBoardDTO dto = tboardService.viewPost(tb_num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tboard/updatePost");
		mav.addObject("dto", dto);
		return mav;
		
	}
	@RequestMapping("update.do")
	public String update(TBoardDTO dto, HttpSession session) 
			throws Exception{
		tboardService.update(dto);
		return "redirect:/tboard/list.do";
	}
	
	@RequestMapping("getAttach")
	@ResponseBody
	public List<String> getAttach(
			@RequestParam("tb_num") int tb_num){
		return tboardService.getAttach(tb_num);
	}
			
	
	@RequestMapping("delete.do")
	public String delete(int tb_num, HttpSession session) {
		tboardService.delete(tb_num);
		return "redirect:/tboard/list.do";
	}
}
