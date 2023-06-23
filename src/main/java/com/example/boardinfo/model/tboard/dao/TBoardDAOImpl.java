package com.example.boardinfo.model.tboard.dao;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

@Repository
public class TBoardDAOImpl implements TBoardDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public int countArticle(
			Map<String, Object> map) {
		return sqlSession.selectOne("tboard.countArticle", map);
	}

	@Override
	public List<TBoardDTO> list(Map<String, Object> map) {
		return sqlSession.selectList("tboard.selectBoardList", map);
	}
	@Override
	public int insert(TBoardDTO dto) {
		return sqlSession.insert("tboard.insertBoard", dto);
	}



	@Override
	public TBoardDTO viewPost(int tb_num) {
		return sqlSession.selectOne("tboard.viewPost", tb_num);
	}

	@Override
	public void update(TBoardDTO dto) {
		sqlSession.update("tboard.updatePost", dto);
	}

	@Override
	public void delete(int tb_num) {
		sqlSession.delete("tboard.deletePost", tb_num);
	}
	


	@Override
	public void increaseViewcnt(int tb_num) {
		sqlSession.update("tboard.increaseViewcnt", tb_num);
	}

	@Override
	public void increaseRecnt(int tb_num) {
		sqlSession.update("tboard.increaseRecnt", tb_num);
	}

	@Override
	public List<String> getAttach(int tb_num) {
		return sqlSession.selectList("tboard.getAttachList", tb_num);
	}

	@Override
	public void deleteFile(String fileName) {
		sqlSession.delete("tboard.deleteAttach", fileName);
	}

	@Override
	public int fileAttach(TBAttachDTO fDto) {
		return sqlSession.insert("tboard.insertFile", fDto);
	}

	/*중고거래 list by userid*/
	@Override
	public List<TBoardDTO> getTbListByUserid(String userid) {
		return sqlSession.selectList("tboard.getTbList",userid);
	}

	@Override
	public List<TBoardDTO> getHomeList(Integer size) {
		return sqlSession.selectList("tboard.getHomeList", size);
	}

}
