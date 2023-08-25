package com.example.boardinfo.model.tboard.dao;

import com.example.boardinfo.model.tboard.dto.TBAttachDTO;
import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
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
			TradeSearchDTO sDto) {
		return sqlSession.selectOne("tboard.countArticle", sDto);
	}

	@Override
	public List<TBoardDTO> list(TradeSearchDTO sDto) {
		return sqlSession.selectList("tboard.selectBoardList", sDto);
	}

	@Override
	public int insert(TBoardDTO dto) {
		return sqlSession.insert("tboard.insertBoard", dto);
	}


	@Override
	public TBoardDTO viewPost(String tb_num) {
		return sqlSession.selectOne("tboard.viewPost", tb_num);
	}

	@Override
	public int update(TBoardDTO dto) {
		return sqlSession.update("tboard.updatePost", dto);
    }

	@Override
	public void delete(String tb_num) {
		sqlSession.delete("tboard.deletePost", tb_num);
	}
	

	@Override
	public void increaseViewcnt(String tb_num) {
		sqlSession.update("tboard.increaseViewcnt", tb_num);
	}

	@Override
	public List<String> getAttach(String tb_num) {
		return sqlSession.selectList("tboard.getAttachList", tb_num);
	}

	@Override
	public int deleteFile(String tb_num) {
		sqlSession.delete("tboard.deleteAttach", tb_num);
		return 0;
	}

	@Override
	public int fileAttach(TBAttachDTO fDto) {
		return sqlSession.insert("tboard.insertFile", fDto);
	}

	/*mypageDao로 옮김*/

	@Override
	public List<TBoardDTO> getHomeList(Integer size) {
		return sqlSession.selectList("tboard.getHomeList", size);
	}

	@Override
	public List<TBoardDTO> totalSearch(Map<String, Object> map) {
		return sqlSession.selectList("tboard.totalSearch", map);
	}

	@Override
	public int totalSearchCount(Map<String, Object> map) {
		return sqlSession.selectOne("tboard.totalSearchCount", map);
	}

	/*좋아요*/
	@Override
	public int addLike(Map<String, Object> map) {
		return sqlSession.insert("tboard.addLike", map);
	}

	@Override
	public int deleteLike(String goodkey) {
		return sqlSession.delete("tboard.deleteLike", goodkey);
	}

	@Override
	public int checkLike(String goodkey) {
		return sqlSession.selectOne("tboard.checkLike", goodkey);
	}
}
