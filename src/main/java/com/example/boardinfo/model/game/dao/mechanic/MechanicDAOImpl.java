package com.example.boardinfo.model.game.dao.mechanic;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

@Repository
public class MechanicDAOImpl implements MechanicDAO {

  @Inject
  SqlSession sqlSession;

  @Override
  public int check_mechanic(String mechanic) {
    int result = sqlSession.selectOne("mechanic.check", mechanic);
    return result;
  }

  @Override
  public void insert_mechanic(String mechanic) {
    sqlSession.insert("mechanic.insert", mechanic);

  }

  @Override
  public void insert_mechanic_mapping() {
    sqlSession.insert("mechanic.insertmapping");

  }

  @Override
  public int mechanicnum(String mechanic) {
    return sqlSession.selectOne("mechanic.mechanic_num", mechanic);
  }

  @Override
  public void insert_mechanic_mapping(int mnum) {
    sqlSession.insert("mechanic.insertmapping_mnum", mnum);

  }

  public List<MechanicDTO> list() {
    return sqlSession.selectList("mechanic.list");
  }

}
