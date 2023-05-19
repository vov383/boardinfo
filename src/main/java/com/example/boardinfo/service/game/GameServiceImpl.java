package com.example.boardinfo.service.game;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.boardinfo.model.game.dao.GameDAO;
import com.example.boardinfo.model.game.dao.artist.ArtistDAO;
import com.example.boardinfo.model.game.dao.category.CategoryDAO;
import com.example.boardinfo.model.game.dao.designer.DesignerDAO;
import com.example.boardinfo.model.game.dao.mechanic.MechanicDAO;
import com.example.boardinfo.model.game.dao.publisher.PublisherDAO;
import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

@Service
public class GameServiceImpl implements GameService {

  @Inject
  GameDAO gameDao;
  @Inject
  ArtistDAO artistDao;
  @Inject
  CategoryDAO categoryDao;
  @Inject
  DesignerDAO designerDao;
  @Inject
  MechanicDAO mechanicDao;
  @Inject
  PublisherDAO publisherDao;

  @Override
  public List<GameDTO> gamelist() {
    return gameDao.gamelist();
  }

  @Transactional
  @Override
  public void gameinsert(GameDTO dto) {
    
    // 아티스트,카테고리,퍼블리셔,디자이너,메카닉 동일값 있는지 확인
    int check_artist = artistDao.check_artist(dto.getArtist());
//    int check_category = categoryDao.check_category(dto.getGamecategory());
    int check_publisher = publisherDao.check_publisher(dto.getPublisher());
    int check_designer = designerDao.check_designer(dto.getDesigner());
    int check_mechanic = mechanicDao.check_mechanic(dto.getMechanic());
    gameDao.gameinsert(dto);
    
    String[] gamecategories = dto.getGamecategory().split(",");
    for(String str : gamecategories) {
      int check_category = categoryDao.check_category(str);
      
      if (check_category == 0) { // 해당 카테고리가 db에 없다면
        categoryDao.insert_category(str);
        categoryDao.insert_category_mapping();
      } else { // db에 존재하는 카테고리라면
        int cnum = categoryDao.categorynum(str);
        categoryDao.insert_category_mapping(cnum);
      }
    }
    
    

    if (check_artist == 0) { // 해당 아티스트가 db에 없다면
      artistDao.insert_artist(dto.getArtist());
      artistDao.insert_artist_mapping();
    } else { // db에 존재하는 아티스트라면
      int anum = artistDao.artistnum(dto.getArtist());
      artistDao.insert_artist_mapping(anum);
    }
    
    
//    if (check_category == 0) { // 해당 카테고리가 db에 없다면
//      categoryDao.insert_category(dto.getGamecategory());
//      categoryDao.insert_category_mapping();
//    } else { // db에 존재하는 카테고리라면
//      int cnum = categoryDao.categorynum(dto.getGamecategory());
//      categoryDao.insert_category_mapping(cnum);
//    }
    
    
    if (check_publisher == 0) { // 해당 제작자가 db에 없다면
      publisherDao.insert_publisher(dto.getPublisher());
      publisherDao.insert_publisher_mapping();
    } else { // db에 존재하는 제작자라면
      int pnum = publisherDao.publishernum(dto.getPublisher());
      publisherDao.insert_publisher_mapping(pnum);
    }
    if (check_designer == 0) { // 해당 디자인이 db에 없다면
      designerDao.insert_designer(dto.getDesigner());
      designerDao.insert_designer_mapping();
    } else { // db에 존재하는 디자인이라면
      int dnum = designerDao.designernum(dto.getDesigner());
      designerDao.insert_designer_mapping(dnum);
    }
    if (check_mechanic == 0) { // 해당 매카니즘이 db에 없다면
      mechanicDao.insert_mechanic(dto.getMechanic());
      mechanicDao.insert_mechanic_mapping();
    } else { // db에 존재하는 매카니즘이라면
      int mnum = mechanicDao.mechanicnum(dto.getMechanic());
      mechanicDao.insert_mechanic_mapping(mnum);
    }
  }

  public void increaseViewcnt(int gnum, HttpSession session) throws Exception {
    long update_time = 0;
    if (session.getAttribute("update_time_" + gnum) != null) {
      // 최근에 조회수를 올린 시간
      update_time = (long) session.getAttribute("update_time_" + gnum);
    }
    long current_time = System.currentTimeMillis();
    // 일정 시간(5초)이 경과한 후 조회수 증가 처리
    if (current_time - update_time > 24 * 60 * 60 * 100) {// 24*60*60*100(하루)
      // 조회수 증가 처리
      gameDao.increaseViewcnt(gnum);
      // 조회수를 올린 시간 저장
      session.setAttribute("update_time_" + gnum, current_time);
    }
  }

  public Object view(int gnum) throws Exception {
    return gameDao.view(gnum);
  }
  
  public List<CategoryDTO> categorylist() {
    return categoryDao.list();
  }
  public List<MechanicDTO> mechaniclist() {
    return mechanicDao.list();
  }
  
  public List<String> getAuto(String query){
    return artistDao.getAuto(query);
  }
}
