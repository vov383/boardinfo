package com.example.boardinfo.service.tboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.util.Pager;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class TBoardServiceImpl implements TBoardService {

	//로깅
	private static final Logger logger = LoggerFactory.getLogger(TBoardServiceImpl.class);
	@Inject
	TBoardDAO tboardDao;

	@Override
	public int countArticle(String select_category, String search_option, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		return tboardDao.countArticle(map);
	}
	@Override
	public Map<String, Object> list(String select_category, String search_option, String keyword, int curPage) {
		Map<String, Object> map = new HashMap<>();
		map.put("select_category", select_category);
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");

		int count = tboardDao.countArticle(map);
		Pager pager = new Pager(12, curPage, 10);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		map.put("start", start);
		map.put("end", end);

		List<TBoardDTO> list = tboardDao.list(map);
		map.put("keyword", keyword);
		map.put("list", list);
		map.put("pager", pager);

		return map;
	}

	@Transactional
	@Override
	public void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception {
			int result =  tboardDao.insert(dto);
			if(result == 1){/*insert에 성공하면*/
				if(files==null) return; //첨부파일이 없으면 skip

				for(int i=0; i< files.length; i++) {
					String fileName = files[i].getOriginalFilename();
					byte[] fileData = files[i].getBytes();
					//파일 업로드
					String uploadedFileName = UploadFileUtils.uploadFile(uploadPath, fileName, fileData);
					logger.info("uploadedFileName :" + uploadedFileName);
					TBAttachDTO fDto = new TBAttachDTO();
					fDto.setFullName(uploadedFileName);
					fDto.setFileData(fileData);
					fDto.setFormatName(uploadedFileName.substring(uploadedFileName.lastIndexOf(".")+1));
					fDto.setCreate_user(dto.getCreate_user());
					int result2 = tboardDao.fileAttach(fDto);
				}
		}

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

//    @Override
//    public void fileAttach(String create_user, List<MultipartFile> files, String uploadPath) throws Exception {
//			for (int i = 0; i < files.size(); i++) {
//				String fileName = files.get(i).getOriginalFilename();
//				//파일을 바이트 배열로 변환
//				byte[] fileData = files.get(i).getBytes();
//
//				String uploadedFileName = UploadFileUtils. uploadFile(uploadPath, fileName, fileData);
//
//				TBAttachDTO fDto = new TBAttachDTO();
//
//				fDto.setCreate_user(create_user);
//				fDto.setFullName(uploadedFileName);
//				fDto.setFormatName(uploadedFileName.substring(uploadedFileName.lastIndexOf(".")+1));
//				fDto.setFileData(fileData);
//				tboardDao.fileAttach(fDto);
//			}
//    }


    @Override
	public void increaseRecnt(int tb_num) {
		tboardDao.increaseRecnt(tb_num);
	}

	@Override
	public List<String> getAttach(int tb_num) {
		return tboardDao.getAttach(tb_num);
	}


}
