package com.example.boardinfo.model.game.dao.mechanic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
  public void insert_mechanic(String mechanic, String userid) {
    Map<String, Object> map = new HashMap<>();
    map.put("mechanic",mechanic);
    map.put("userid",userid);
    sqlSession.insert("mechanic.insert", map);

  }

  @Override
  public void insert_mechanic_mapping() {
    sqlSession.insert("mechanic.insertmapping");

  }

  @Override
  public void insert_mechanic_mapping(int mnum) {
    sqlSession.insert("mechanic.insertmapping_mnum", mnum);

  }

  public List<MechanicDTO> list() {
    return sqlSession.selectList("mechanic.list");
  }

  public List<MechanicDTO> view(int gnum) { return sqlSession.selectList("mechanic.view", gnum); }

  public int check_mechanic(String mechanic, int gnum){
    Map<String, Object> map = new HashMap<>();
    map.put("mechanic", mechanic);
    map.put("gnum",gnum);
    return sqlSession.selectOne("mechanic.updatecheck", map);
  }

  public void insert_mechanic_mapping(int gnum, int mnum){
    Map<String, Object> map = new HashMap<>();
    map.put("mnum", mnum);
    map.put("gnum",gnum);
    sqlSession.insert("mechanic.insertmapping_update", map);
  }

  @Override
  public List<String> viewMechanic(int gnum) {
    return sqlSession.selectList("mechanic.viewMechanic", gnum);
  }

  @Override
  public void deleteGame_Mechanic(String value, int gnum) {
    Map<String, Object> map = new HashMap<>();
    map.put("mechanic", value);
    map.put("gnum",gnum);
    sqlSession.delete("mechanic.deleteGame_Mechanic", map);
  }

  @Override
  public List<MechanicDTO> confirmList(Map<String, Object> map) {
    return sqlSession.selectList("mechanic.confirmList", map);
  }
  @Override
  public void deleteitem(int num) {
    sqlSession.delete("mechanic.deleteitem", num);
  }
}
