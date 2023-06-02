package com.example.boardinfo.service.tboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.util.Pager;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

@Service
public class TBoardServiceImpl implements TBoardService {

	@Inject
	TBoardDAO tboardDao;
	
	@Override
	public Map<String, Object> list(String select_category, String search_option, String keyword, int curPage) {
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");

		int count = tboardDao.countArticle(map);

		Pager pager = new Pager(count, curPage, 10);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		map.put("start", start);
		map.put("end", end);

		List<TBoardDTO> list = tboardDao.list(map);
		map.put("list", list);
		map.put("pager", pager);

		return map;
	}

	@Override
	public void insert(TBoardDTO dto) {
		tboardDao.insert(dto);
	}

	@Override
	public void fileAttach(TBAttachDTO f_dto) {
		tboardDao.fileAttach(f_dto);
	}

	@Override
	public TBoardDTO viewPost(int tb_num) {
		return tboardDao.viewPost(tb_num);
	}

	@Override
	public void update(TBoardDTO dto) {
		tboardDao.update(dto);
	}

	@Override
	public void delete(int tb_num) {
		tboardDao.delete(tb_num);
	}

	@Override
	public int countArticle(String select_category, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return tboardDao.countArticle(map);
	}
	@Override
	public void increaseViewCount(int tb_num, HttpSession session) {
		long update_time=0;
		if(session.getAttribute("update_time_" + tb_num) != null) {
			//최근에 조회수 올린 시간
			update_time = (long)session.getAttribute("update_time_" + tb_num);
		}
		long current_time = System.currentTimeMillis();
		//일정 시간(5초)이 경과하면 조회수 증가 처리
		if(current_time - update_time > 5 * 1000) {//24*60*60*1000(하루)
			//조회수 증가 처리
			tboardDao.increaseViewcnt(tb_num); 
			//세션은 service까지 가져오면 됨.. dao로 안 가져가도 됨
			
			//조회수 올린 시간 저장
			session.setAttribute("update_time_"+tb_num, current_time);
		}
	}

	@Override
	public void deleteFile(String fileName) {
		tboardDao.deleteFile(fileName);
	}

	@Override
	public void increaseRecnt(int tb_num) {
		tboardDao.increaseRecnt(tb_num);
	}

	@Override
	public List<String> getAttach(int tb_num) {
		return tboardDao.getAttach(tb_num);
	}



}
