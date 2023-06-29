package com.example.boardinfo.service.tboard;

import com.example.boardinfo.model.tboard.dao.TBoardDAO;
import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
import com.example.boardinfo.util.Pager;
import com.example.boardinfo.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TBoardServiceImpl implements TBoardService {

	//로깅
	private static final Logger logger = LoggerFactory.getLogger(TBoardServiceImpl.class);
	@Inject
	TBoardDAO tboardDao;

	@Override
	public int countArticle(TradeSearchDTO sDto) {
		return tboardDao.countArticle(sDto);
	}
	@Override
	public Map<String, Object> list(TradeSearchDTO sDto) {

		int count = tboardDao.countArticle(sDto);
		Pager pager = new Pager(count, sDto.getCurPage(), 9);
		sDto.setStart(pager.getPageBegin());
		sDto.setEnd(pager.getPageEnd());

		List<TBoardDTO> list = tboardDao.list(sDto);
//		logger.info("@@@list 값 : @@@@@@@@ : "+list);
		Map<String, Object> map = new HashMap<>();
		sDto.setKeyword(sDto.getKeyword().substring(1, sDto.getKeyword().length()-1));/*keyword에서 맨앞%, 맨뒤% 제거*/
		map.put("count", count);
		map.put("sDto", sDto);
		map.put("list", list);
//		map.put("fList", fList);
		map.put("pager", pager);
		return map;
	}

	@Transactional
	@Override
	public void insert(TBoardDTO dto, MultipartFile[] files, String uploadPath) throws Exception {
		
		/*spring HtmlUtils를 활용해서 특수문자 처리*/
		String title = HtmlUtils.htmlEscape(dto.getTitle());
		String description = HtmlUtils.htmlEscape(dto.getDescription());
		String price = HtmlUtils.htmlEscape(dto.getPrice());
		dto.setTitle(title);
		dto.setDescription(description);
		dto.setPrice(price);
		
		int result =  tboardDao.insert(dto);
			if(result == 1){/*insert에 성공하면*/

				for(int i=0; i< files.length; i++) {
					String fileName = files[i].getOriginalFilename();
					byte[] fileData = files[i].getBytes();
					/* 이미지를 업로드 안했을 경우 fileName이 ""라서 break로 반복문 탈출! */
					if(fileName == null || fileName.equals("")){
						break;
					}
					//파일 업로드
					/* UploadFileUtils 는 이미지파일이면 썸네일 파일 명을 리턴함 */
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
	public Map<String, Object> viewPost(int tb_num) {
		TBoardDTO dto = tboardDao.viewPost(tb_num);
		Map<String, Object> map = new HashMap<>();
		map.put("dto", dto);
		return map;
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
	public int deleteFile(Map<String, String> map) {
		int result = tboardDao.deleteFile(map);
		return result;
	}


	@Override
	public List<String> getAttach(int tb_num) {
		return tboardDao.getAttach(tb_num);
	}

	@Override
	public List<TBoardDTO> getHomeList(Integer size) {
		List<TBoardDTO> list = tboardDao.getHomeList(size);
		return list;

	}

	@Override
	public List<TBoardDTO> totalSearch(String gameKeyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("gameKeyword", gameKeyword);
		map.put("filter", "none");
		return tboardDao.totalSearch(map);
	}

	@Override
	public Map<String, Object> totalSearchMore(Map<String, Object> map) {
		int curPage = Integer.parseInt(String.valueOf(map.get("curPage")));

		int count = tboardDao.totalSearchCount(map);

		Pager pager = new Pager(count, curPage, 10);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();

		map.put("start",start);
		map.put("end",end);


		List<TBoardDTO> list = tboardDao.totalSearch(map);
		map.put("list",list);
		map.put("count",count);
		map.put("pager",pager);

		return map;
	}


	/*중고거래 좋아요*/
	@Transactional
	@Override
	public int goodCreate(TradeSearchDTO sDto, HttpSession session){
		String userid = (String) session.getAttribute("userid");
		String tb_num = sDto.getTb_num();
		/*좋아요 KEY는 USERID + TB_NUM*/
		String goodkey = userid+tb_num;
		sDto.setGoodkey(goodkey);
		sDto.setCreate_user(userid);
		return tboardDao.goodCreate(sDto);

	}
	@Override
	public int goodDelete(TradeSearchDTO sDto, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		sDto.setCreate_user(userid);
		return tboardDao.goodDelete(sDto);
	}

	
}
