package com.example.boardinfo.model.tboard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.tboard.dto.TBCommentDTO;

@Repository
public class TBCommentDAOImpl implements TBCommentDAO {
    //로거
    private static final Logger logger
            = LoggerFactory.getLogger(TBCommentDAOImpl.class);
    @Inject
    SqlSession sqlSession;

    @Override
    public List<TBCommentDTO> getReplyList(int tb_num) {
        return sqlSession.selectList("tbComment.getReplyList", tb_num);
    }

    @Override
    public int getReplyCount(int tb_num) {
        return sqlSession.selectOne("tbComment.replyCount", tb_num);
    }

    @Override
    public int getTargetReplyOrder(TBCommentDTO re_dto) {
        int target = 0;

        if (re_dto.getParent_reply() == null) {
            int tb_num = re_dto.getTb_num();
            target = sqlSession.selectOne("tbComment.getLast", tb_num);
        } else {
            target = sqlSession.selectOne("tbComment.getTargetReplyOrder", re_dto);
        }
        return target;
    }


    @Override
    public int insertReply(TBCommentDTO re_dto) {
        //mybatis는 insert, update, delete문을 실행했을 경우 resultType이 없고 수정에 성공한 row의 갯수를 반환한다.
        /*여기서 댓글 500에러 발생*/
        int result = sqlSession.insert("tbComment.insertReply", re_dto);
        return result;
    }

    @Override
    
    public TBCommentDTO getMotherObject(Integer mother_reply) {
        return sqlSession.selectOne("tbComment.getMotherDto", mother_reply);
    }

    @Override
    public void replyOrderUpdate(int parent_reply, int inner_order) {

        Map<String, Integer> map = new HashMap<>();
        map.put("parent_reply", parent_reply);
        map.put("inner_order", inner_order);
        logger.info("map 테스트 : " +map);
        //대댓글 댓글달기 실패지점
        sqlSession.update("tbComment.replyOrderUpdate", map);
    }

    @Override
    public String getReplyContent(int reply_reg_num) {
        return sqlSession.selectOne("tbComment.getReplyContent", reply_reg_num);

    }

    @Override
    public int editReply(TBCommentDTO re_dto) {
        return sqlSession.update("tbComment.editReply", re_dto);
    }

    @Override
    public int deleteReply(Map map) {
        return sqlSession.delete("tbComment.deleteReply", map);
    }





}
