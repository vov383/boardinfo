package com.example.boardinfo.service.game;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.controller.game.GameController;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.util.BggParser;
import com.example.boardinfo.util.Pager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

@Service
public class GameServiceImpl implements GameService {
  private static final Logger logger=
          LoggerFactory.getLogger(GameServiceImpl.class);
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
  public Map<String, Object> gamelist(int curPage) {
    int count = gameDao.countList();

    Pager pager = new Pager(count, curPage, 10);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();

    Map<String, Object> map = new HashMap<>();
    map.put("start",start);
    map.put("end",end);

    List<GameDTO> list = gameDao.gamelist(map);

    for(GameDTO dto : list){
      int bggnum = dto.getBggnum();
      BggParser bggParser = new BggParser();
      bggParser.setBgg_thumbnail(bggnum);
      dto.setBgg_thumbnail(bggParser.getBgg_thumbnail());
    }

    map.put("list",list);
    map.put("pager",pager);

    return map;
  }

  @Transactional
  @Override
  public void gameinsert(GameDTO dto) {

    //게임테이블에 insert
    gameDao.gameinsert(dto);

    //카테고리테이블 insert
    //카테고리배열
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
    
    //아티스트테이블 insert
    //아티스트배열
    String[] artists = dto.getArtist().split(",");

    for(String str : artists) {
      int check_artist = artistDao.check_artist(str);

      if (check_artist == 0) { // 해당 아티스트가 db에 없다면
        artistDao.insert_artist(str);
        artistDao.insert_artist_mapping();
      } else { // db에 존재하는 아티스트라면
        int anum = artistDao.artistnum(str);
        artistDao.insert_artist_mapping(anum);
      }
    }

   //메카닉테이블 insert
   //메카닉배열
    String[] mechanics = dto.getMechanic().split(",");

    for(String str : mechanics) {
      int check_mechanic = mechanicDao.check_mechanic(str);

      if (check_mechanic == 0) { // 해당 매카니즘이 db에 없다면
        mechanicDao.insert_mechanic(str);
        mechanicDao.insert_mechanic_mapping();
      } else { // db에 존재하는 매카니즘이라면
        int mnum = mechanicDao.mechanicnum(str);
        mechanicDao.insert_mechanic_mapping(mnum);
      }
    }

    //퍼블리셔테이블 insert
    //퍼블리셔배열
    String[] publishers = dto.getPublisher().split(",");

    for(String str : publishers) {
      int check_publisher = publisherDao.check_publisher(str);

      if (check_publisher == 0) { // 해당 제작자가 db에 없다면
        publisherDao.insert_publisher(str);
        publisherDao.insert_publisher_mapping();
      } else { // db에 존재하는 제작자라면
        int pnum = publisherDao.publishernum(str);
        publisherDao.insert_publisher_mapping(pnum);
      }
    }

    //디자이너테이블 insert
    //디자이너배열
    String[] designers = dto.getDesigner().split(",");

    for(String str : designers) {
      int check_designer = designerDao.check_designer(str);

      if (check_designer == 0) { // 해당 디자인이 db에 없다면
        designerDao.insert_designer(str);
        designerDao.insert_designer_mapping();
      } else { // db에 존재하는 디자인이라면
        int dnum = designerDao.designernum(str);
        designerDao.insert_designer_mapping(dnum);
      }
    }

    //attach 테이블에 레코드 추가(게임사진테이블)
    String[] files=dto.getFiles();//첨부파일 이름 배열
    if(files==null) return; //첨부파일이 없으면 skip
    for(String name : files) {
      gameDao.addAttach(name);//attach테이블에 insert
    }
  }

  //게임정보페이지 조회수 증가
  public void increaseViewcnt(int gnum, HttpServletRequest request, HttpServletResponse response) throws Exception {

    boolean updateViewCount = true;

    // 쿠키를 통한 중복 조회 막기
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
      for (Cookie cookie : cookies) {
        if (cookie.getName().equals("gameView_"+gnum)) {
          updateViewCount = false; // 이미 조회한 쿠키가 존재하면 조회 막기
          break;
        }
      }
    }

    if (updateViewCount) {
      // 조회수 증가 처리
      gameDao.increaseViewcnt(gnum);

      // 조회를 한 쿠키 생성
      Cookie viewedCookie = new Cookie("gameView_"+gnum, "true");
      viewedCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 기간 설정 (24시간)
      response.addCookie(viewedCookie);
    }

  }

  //게임정보페이지
  @Transactional
  public Map<String, Object> view(int gnum) throws Exception {
    Map<String, Object> map = new HashMap<>();
    //game테이블 데이터
    GameDTO dto = gameDao.view(gnum);
    //사진
    String str = dto.getGamephoto_url();
    if(str != null) {
      String front = str.substring(0, 12);
      String end = str.substring(14);
      dto.setGamephoto_url(front+end);
    }
    List<ArtistDTO> alist = artistDao.view(gnum);
    List<CategoryDTO> clist = categoryDao.view(gnum);
    List<DesignerDTO> dlist = designerDao.view(gnum);
    List<MechanicDTO> mlist = mechanicDao.view(gnum);
    List<PublisherDTO> plist = publisherDao.view(gnum);

    int bggnum = dto.getBggnum();

    BggParser bggParser = new BggParser();
    bggParser.setBgg_thumbnail(bggnum);
    bggParser.setBgg_rank(bggnum);
    bggParser.setBgg_rate(bggnum);
    bggParser.setBgg_weight(bggnum);


    map.put("dto",dto);
    map.put("alist", alist);
    map.put("clist", clist);
    map.put("dlist", dlist);
    map.put("mlist", mlist);
    map.put("plist", plist);

    map.put("bgg_thumbnail", bggParser.getBgg_thumbnail());
    map.put("bgg_rank", bggParser.getBgg_rank());
    map.put("bgg_rate", bggParser.getBgg_rate());
    map.put("bgg_weight", bggParser.getBgg_weight());

    return map;
  }

  //게임등록페이지의 카테고리목록
  public List<CategoryDTO> categorylist() {
    return categoryDao.list();
  }
  //게임등록페이지의 메카닉목록
  public List<MechanicDTO> mechaniclist() {
    return mechanicDao.list();
  }
  //게임등록페이지의 아티스트검색목록
  public List<ArtistDTO> getAutoArtist(String input){
    return artistDao.getAutoArtist(input);
  }
  //게임등록페이지의 디자이너검색목록
  public List<DesignerDTO> getAutoDesigner(String input) {
    return designerDao.getAutoDesigner(input);
  }
  //게임등록페이지의 퍼블리셔검색목록
  public List<PublisherDTO> getAutoPublisher(String input){
    return publisherDao.getAutoPublisher(input);
  }
  //top의 검색창 검색목록
  public List<GameDTO> getAutoGame(String input){
    return gameDao.getAutoGame(input);
  }
  //게임등록페이지의 사진 드롭 후 제거시 사진경로 삭제
  public void deleteFile(String fileName){
    gameDao.delteFile(fileName);
  }


  //아티스트,카테고리,디자이너,메카닉,퍼블리셔 개별 항목에 대응하는 게임목록 출력
  public Map<String, Object> filteredGamelist(String filter,int num, int curPage){
    Map<String, Object> map = new HashMap<>();
    map.put("filter",filter);
    map.put("num", num);

    int count = gameDao.countList(map);

    Pager pager = new Pager(count, curPage, 10);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();
    map.put("start",start);
    map.put("end",end);

    List<GameDTO> list = gameDao.filteredGamelist(map);

    for(GameDTO dto : list){
      int bggnum = dto.getBggnum();
      BggParser bggParser = new BggParser();
      bggParser.setBgg_thumbnail(bggnum);
      logger.info("과연 : " + dto );
      dto.setBgg_thumbnail(bggParser.getBgg_thumbnail());
    }

    map.put("count", count);
    map.put("list", list);
    map.put("pager", pager);

    return map;
  }
}
