package com.example.boardinfo.service.tboard;

import java.util.List;    

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;

@Service
public class TBoardServiceImpl implements TBoardService {

	@Inject
	TBoardDAO tboardDao;
	
	@Override
	public List<TBoardDTO> list(String select_category, String search_option, String keyword, int start, int end) {
		return tboardDao.list(select_category, search_option, keyword, start, end);
	}

	@Override
	public void insert(TBoardDTO dto) {
		tboardDao.insert(dto);
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
		return tboardDao.countArticle(select_category, search_option, keyword);
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
