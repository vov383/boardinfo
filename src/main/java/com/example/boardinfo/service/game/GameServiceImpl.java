package com.example.boardinfo.service.game;

import com.example.boardinfo.model.game.dao.GameDAO;
import com.example.boardinfo.model.game.dao.artist.ArtistDAO;
import com.example.boardinfo.model.game.dao.category.CategoryDAO;
import com.example.boardinfo.model.game.dao.designer.DesignerDAO;
import com.example.boardinfo.model.game.dao.gameRating.GameRatingDAO;
import com.example.boardinfo.model.game.dao.mechanic.MechanicDAO;
import com.example.boardinfo.model.game.dao.publisher.PublisherDAO;
import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;
import com.example.boardinfo.util.GameUtils;
import com.example.boardinfo.util.Pager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

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
  @Inject
  GameRatingDAO gameRatingDao;

  @Override
  public Map<String, Object> gamelist(int curPage, String sort) {
    int count = gameDao.countList();

    Pager pager = new Pager(count, curPage, 10);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();

    Map<String, Object> map = new HashMap<>();
    map.put("start",start);
    map.put("end",end);
    map.put("sort", sort);

    List<GameDTO> list = gameDao.gamelist(map);

    map.put("count",count);
    map.put("list",list);
    map.put("pager",pager);

    return map;
  }

  @Transactional
  @Override
  public void gameinsert(GameDTO dto) {

    //게임테이블에 insert
    gameDao.gameinsert(dto);
    String userid = dto.getCreate_user();

    //카테고리테이블 insert
    //dto의 값을 배열로 쪼갬
    String[] gamecategories = GameUtils.checkNullnSplit(dto.getGamecategory());

    for(String str : gamecategories) {
      int cnum = categoryDao.check_category(str);
      
      if (cnum == 0) { // 해당 카테고리가 db에 없다면
        categoryDao.insert_category(str,userid);
        categoryDao.insert_category_mapping();
      } else { // db에 존재하는 카테고리라면
        categoryDao.insert_category_mapping(cnum);
      }
    }
    
    //아티스트테이블 insert
    //dto의 값을 배열로 쪼갬
    String[] artists = GameUtils.checkNullnSplit(dto.getArtist());

    for(String str : artists) {
      int anum = artistDao.check_artist(str);

      if (anum == 0) { // 해당 아티스트가 db에 없다면
        artistDao.insert_artist(str,userid);
        artistDao.insert_artist_mapping();
      } else { // db에 존재하는 아티스트라면
        artistDao.insert_artist_mapping(anum);
      }
    }

   //메카닉테이블 insert
    //dto의 값을 배열로 쪼갬
    String[] mechanics = GameUtils.checkNullnSplit(dto.getMechanic());

    for(String str : mechanics) {
      int mnum = mechanicDao.check_mechanic(str);

      if (mnum == 0) { // 해당 매카니즘이 db에 없다면
        mechanicDao.insert_mechanic(str, userid);
        mechanicDao.insert_mechanic_mapping();
      } else { // db에 존재하는 매카니즘이라면
        mechanicDao.insert_mechanic_mapping(mnum);
      }
    }

    //퍼블리셔테이블 insert
    //dto의 값을 배열로 쪼갬
    String[] publishers = GameUtils.checkNullnSplit(dto.getPublisher());

    for(String str : publishers) {
      int pnum = publisherDao.check_publisher(str);

      if (pnum == 0) { // 해당 제작자가 db에 없다면
        publisherDao.insert_publisher(str,userid);
        publisherDao.insert_publisher_mapping();
      } else { // db에 존재하는 제작자라면
        publisherDao.insert_publisher_mapping(pnum);
      }
    }

    //디자이너테이블 insert
    //dto의 값을 배열로 쪼갬
    String[] designers = GameUtils.checkNullnSplit(dto.getDesigner());

    for(String str : designers) {
      int dnum = designerDao.check_designer(str);

      if (dnum == 0) { // 해당 디자인이 db에 없다면
        designerDao.insert_designer(str,userid);
        designerDao.insert_designer_mapping();
      } else { // db에 존재하는 디자인이라면
        designerDao.insert_designer_mapping(dnum);
      }
    }

    //attach 테이블에 레코드 추가(게임사진테이블)
    String[] files=dto.getFiles();//첨부파일 이름 배열
    if(files==null) return; //첨부파일이 없으면 skip
    for(String name : files) {
      gameDao.addAttach(name,userid);//attach테이블에 insert
    }

    //확장게임 테이블에 insert
    String expansion = dto.getExpansion();
    if(expansion != null && expansion != "") {
      //확장게임 배열
      String[] expansions = expansion.split(",");
      for (String str : expansions) {
        gameDao.insert_expansion(str, userid);
      }
    }else return;

    //재구현게임 테이블에 insert
    String reimplement = dto.getReimplement();
    if(reimplement != null && reimplement != ""){
      //재구현게임 배열
      String[] reimplements = reimplement.split(",");
      for(String str : reimplements){
        gameDao.insert_reimplement(str,userid);
      }
    }else return;
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
  public Map<String, Object> view(int gnum){

    //game테이블 데이터
    GameDTO dto = gameDao.view(gnum);

    List<ArtistDTO> alist = artistDao.view(gnum);
    List<CategoryDTO> clist = categoryDao.view(gnum);
    List<DesignerDTO> dlist = designerDao.view(gnum);
    List<MechanicDTO> mlist = mechanicDao.view(gnum);
    List<PublisherDTO> plist = publisherDao.view(gnum);
    
    Map<String, Object> map = new HashMap<>();

    map.put("dto",dto);
    map.put("alist", alist);
    map.put("clist", clist);
    map.put("dlist", dlist);
    map.put("mlist", mlist);
    map.put("plist", plist);

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

  //top의 검색창 게임 검색목록, 리뷰에서도 사용.
  public List<GameDTO> getAutoGame(String input){
    return gameDao.getAutoGame(input);
  }

  @Override
  public void autoUpdate_delete(String value, int gnum, String filter) {
    switch (filter){
      case "category":
        int checknum = categoryDao.check_category(value, gnum);
        if(checknum > 0){
          categoryDao.deleteGame_Category(value, gnum);
          break;
        }
      case "artist":
        checknum = artistDao.check_artist(value, gnum);
        if(checknum > 0){
          artistDao.deleteGame_Artist(value, gnum);
          break;
        }
      case "designer":
        checknum = designerDao.check_designer(value, gnum);
        if(checknum > 0){
          designerDao.deleteGame_Designer(value, gnum);
          break;
        }
      case "mechanic":
        checknum = mechanicDao.check_mechanic(value, gnum);
        if(checknum > 0){
          mechanicDao.deleteGame_Mechanic(value, gnum);
          break;
        }
      case "publisher":
        checknum = publisherDao.check_publisher(value, gnum);
        if(checknum > 0){
          publisherDao.deleteGame_Publisher(value, gnum);
          break;
        }
    }


  }

  //게임등록페이지의 사진 드롭 후 제거시 사진경로 삭제
  public void deleteFile(String fileName){
    gameDao.delteFile(fileName);
  }


  //아티스트,카테고리,디자이너,메카닉,퍼블리셔 개별 항목에 대응하는 게임목록 출력

  public Map<String, Object> filteredGamelist(String filter,int num, int curPage, String sort){

    Map<String, Object> map = new HashMap<>();
    map.put("filter",filter);
    map.put("num", num);


    int count = gameDao.countList(map);

    Pager pager = new Pager(count, curPage, 10);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();
    map.put("start",start);
    map.put("end",end);
    map.put("sort", sort);

    List<GameDTO> list = gameDao.filteredGamelist(map);

    map.put("count", count);
    map.put("list", list);
    map.put("pager", pager);

    return map;
  }

  //게임수정페이지로 이동
  public GameDTO updateView(int gnum){
    //게임테이블의 게임정보
    GameDTO dto = gameDao.view(gnum);

    //아티스트
    List<String> alist = artistDao.viewArtist(gnum);
    String artist = GameUtils.listToStr(alist);
    artist = GameUtils.removeLastChar(artist);
    dto.setArtist(artist);

    //카테고리
    List<String> clist = categoryDao.viewGamecategory(gnum);
    String gamecategory = GameUtils.listToStr(clist);
    gamecategory = GameUtils.removeLastChar(gamecategory);
    dto.setGamecategory(gamecategory);

    //디자이너
    List<String> dlist = designerDao.viewDesigner(gnum);
    String designer = GameUtils.listToStr(dlist);
    designer = GameUtils.removeLastChar(designer);
    dto.setDesigner(designer);

    //메카닉
    List<String> mlist = mechanicDao.viewMechanic(gnum);
    String mechanic = GameUtils.listToStr(mlist);
    mechanic = GameUtils.removeLastChar(mechanic);
    dto.setMechanic(mechanic);

    //퍼블리셔
    List<String> plist = publisherDao.viewPublisher(gnum);
    String publisher = GameUtils.listToStr(plist);
    publisher = GameUtils.removeLastChar(publisher);
    dto.setPublisher(publisher);

    //확장
    List<String> exlist = gameDao.viewExpansion(gnum);
    String expansion = GameUtils.listToStr(exlist);
    expansion = GameUtils.removeLastChar(expansion);
    dto.setExpansion(expansion);

    //재구현
    List<String> relist = gameDao.viewReimplement(gnum);
    String reimplement = GameUtils.listToStr(relist);
    reimplement = GameUtils.removeLastChar(reimplement);
    dto.setReimplement(reimplement);

    return dto;
  }

  @Transactional
  @Override
  public void gameupdate(GameDTO dto) {

    //게임테이블에 update
    gameDao.gameupdate(dto);
    int gnum = dto.getGnum();
    String userid = dto.getUpdate_user();

    //카테고리테이블 update
    //dto의 값을 배열로 쪼갬
    String[] gamecategories = GameUtils.checkNullnSplit(dto.getGamecategory());

    for(String str : gamecategories) {
      //해당 번호의 게임에 해당 카테고리가 존재하느냐
      int check_game_category = categoryDao.check_category(str,gnum);

      if (check_game_category == 0) { // 해당 카테고리가 해당번호의 게임에 없다면
        //해당 카테고리가 db에 존재하느냐
        int cnum = categoryDao.check_category(str);
        if (cnum == 0) { //해당 카테고리가 db에 존재하지 않는다면
          categoryDao.insert_category(str,userid);
          categoryDao.insert_category_mapping();
        }else { //해당 카테고리가 db에 존재하면
          categoryDao.insert_category_mapping(gnum,cnum);
        }
      }
    }

    //아티스트테이블 update
    //dto의 값을 배열로 쪼갬
    String[] artists = GameUtils.checkNullnSplit(dto.getArtist());

    for(String str : artists) {
      //해당 번호의 게임에 해당 아티스트가 존재하느냐
      int check_artist = artistDao.check_artist(str,gnum);

      if (check_artist == 0) { // 해당 아티스트가 해당번호의 게임에 없다면
        //해당 아티슽츠가 db에 존재하느냐
        int anum = artistDao.check_artist(str);
        if(anum == 0) { //해당 아티스트가 해당번호의 게임에 없다면
          artistDao.insert_artist(str,userid);
          artistDao.insert_artist_mapping();
        }else { // db에 존재하는 아티스트라면
          artistDao.insert_artist_mapping(gnum,anum);
        }
      }
    }

    //메카닉테이블 update
    //dto의 값을 배열로 쪼갬
    String[] mechanics = GameUtils.checkNullnSplit(dto.getMechanic());

    for(String str : mechanics) {
      //해당 번호의 게임에 해당 메카닉이 존재하느냐
      int check_mechanic = mechanicDao.check_mechanic(str,gnum);

      if (check_mechanic == 0) { // 해당 매카니즘이 해당번호의 게임에 없다면
        //해당 메카닉이 db에 존재하느냐
        int mnum = mechanicDao.check_mechanic(str);
        if(mnum == 0){ //해당 메카닉이 db에 존재하지 않는다면
          mechanicDao.insert_mechanic(str,userid);
          mechanicDao.insert_mechanic_mapping();
        }else { //해당 메카닉이 db에 존재하면
          mechanicDao.insert_mechanic_mapping(gnum,mnum);
        }
      }
    }

    //퍼블리셔테이블 update
    //dto의 값을 배열로 쪼갬
    String[] publishers = GameUtils.checkNullnSplit(dto.getPublisher());

    for(String str : publishers) {
      //해당 번호의 게임에 해당 퍼블리셔가 존재하느냐
      int check_publisher = publisherDao.check_publisher(str,gnum);

      if (check_publisher == 0) { // 해당 제작자가 해당번호의 게임에 없다면
        //해당 제작자가 db에 존재하느냐
        int pnum = publisherDao.check_publisher(str);
        if(pnum == 0){ //해당 제작자가 db에 존재하지 않는다면
          publisherDao.insert_publisher(str, userid);
          publisherDao.insert_publisher_mapping();
        }else { // 해당 제작자가 db에 존재하면
          publisherDao.insert_publisher_mapping(gnum,pnum);
        }
      }
    }

    //디자이너테이블 update
    //dto의 값을 배열로 쪼갬
    String[] designers = GameUtils.checkNullnSplit(dto.getDesigner());

    for(String str : designers) {
      //해당 번호의 게임에 해당 디자이너가 존재하느냐
      int check_designer = designerDao.check_designer(str,gnum);

      if (check_designer == 0) { // 해당 디자이너가 해당번호의 게임에 없다면
        //해당 디자이너가 db에 존재하느냐
        int dnum = designerDao.check_designer(str);
        if(dnum == 0){ //해당 디자이너가 db에 존재하지 않는다면
          designerDao.insert_designer(str, userid);
          designerDao.insert_designer_mapping();
        }else { //해당 디자이너가 db에 존재하면
          designerDao.insert_designer_mapping(gnum,dnum);
        }

      }
    }

    //확장게임 테이블에 update
    String expansion = dto.getExpansion();
    if(expansion != null && expansion != "") {
      //확장게임 배열
      String[] expansions = dto.getExpansion().split(",");
      for (String str : expansions) {
        int exnum = gameDao.getExnum(gnum, str);
        if (exnum == 0) {
          gameDao.insert_expansion(gnum, str, userid);
        }
      }
    }



    //재구현게임 테이블에 update
    String reimplement = dto.getReimplement();
    if(reimplement != null && expansion != "") {
      //재구현게임 배열
      String[] reimplements = dto.getReimplement().split(",");
      for (String str : reimplements) {
        int renum = gameDao.getRenum(gnum, str);
        if (renum == 0) {
          gameDao.insert_reimplement(gnum, str, userid);
        }
      }
    }
  }

  public void deleteGame(int gnum, String userid){
    gameDao.deleteGame(gnum, userid);
  }


  @Override
  public Map<String, Object> parseInsert(int bggnum) {
    Map<String, Object> map = new HashMap<>();

    //게임영문명
    String gametitle_eng = GameUtils.setStr(bggnum,"name");
    //플레이인원
    String minplayers = GameUtils.setStr(bggnum,"minplayers");
    String maxplayers = GameUtils.setStr(bggnum,"maxplayers");
    String players = minplayers + " - " + maxplayers;
    //플레이시간
    String minplaytime = GameUtils.setStr(bggnum,"minplaytime");
    String maxplaytime = GameUtils.setStr(bggnum,"maxplaytime");
    String playtime = minplaytime + " - " + maxplaytime;
    //사용연령
    String ages = GameUtils.setStr(bggnum,"minage") + "세 이상";
    //발매년도
    int release_year = Integer.parseInt(Objects.requireNonNull(GameUtils.setStr(bggnum, "yearpublished")));

    //아트웍
    List<String> alist = GameUtils.setList(bggnum,"boardgameartist");
    String artist = GameUtils.listToStr(alist);
    artist = GameUtils.removeLastChar(artist);
    //카테고리
    List<String> clist = GameUtils.setList(bggnum,"boardgamecategory");
    String gamecategory = GameUtils.listToStr(clist);
    gamecategory = GameUtils.removeLastChar(gamecategory);
    //디자이너
    List<String> dlist = GameUtils.setList(bggnum,"boardgamedesigner");
    String designer = GameUtils.listToStr(dlist);
    designer = GameUtils.removeLastChar(designer);
    //메카니즘
    List<String> mlist = GameUtils.setList(bggnum,"boardgamemechanic");
    String mechanic = GameUtils.listToStr(mlist);
    mechanic = GameUtils.removeLastChar(mechanic);
    //퍼블리셔
    List<String> plist = GameUtils.setList(bggnum,"boardgamepublisher");
    String publisher = GameUtils.listToStr(plist);
    publisher = GameUtils.removeLastChar(publisher);

    map.put("gametitle_eng",gametitle_eng);
    map.put("players",players);
    map.put("playtime",playtime);
    map.put("ages",ages);
    map.put("release_year",release_year);
    map.put("artist",artist);
    map.put("gamecategory",gamecategory);
    map.put("designer",designer);
    map.put("mechanic",mechanic);
    map.put("publisher",publisher);

    return map;
  }


  //게임정보창의 확장재구현게임 목록 표시
  public Map<String,Object> getExRe(String origin, String filter, int num){
    Map<String, Object> map = new HashMap<>();
    map.put("origin", origin);  //child or parent
    map.put("filter", filter);  //ex or re
    map.put("num", num);

    List<GameDTO> list = gameDao.ExReList(map);

    map.clear();

    map.put("list",list);
    return map;
  }

  @Override
  public Map<String, Object> gameListMain() {
    Map<String, Object> map = new HashMap<>();
    map.put("str","carousel");
    List<GameDTO> weeklyList = gameDao.weeklyList(map);
    List<GameDTO> newbieList = gameDao.newbieList(map);


    map.clear();
    map.put("weeklyList", weeklyList);
    map.put("newbieList", newbieList);


    return map;
  }

  @Override
  public Map<String, Object> totalSearch(String gameKeyword) {
    Map<String, Object> map = new HashMap<>();
    map.put("gameKeyword", gameKeyword);

    int gcount = gameDao.totalSearchCount(map);
    int acount = artistDao.totalSearchCount(map);
    int dcount = designerDao.totalSearchCount(map);
    int pcount = publisherDao.totalSearchCount(map);

    map.put("gcount", gcount);
    map.put("acount", acount);
    map.put("dcount", dcount);
    map.put("pcount", pcount);

    map.put("filter", "none");

    List<GameDTO> glist = gameDao.totalSearch(map);
    List<ArtistDTO> alist = artistDao.totalSearch(map);
    List<DesignerDTO> dlist = designerDao.totalSearch(map);
    List<PublisherDTO> plist = publisherDao.totalSearch(map);

    map.put("glist", glist);
    map.put("alist", alist);
    map.put("dlist", dlist);
    map.put("plist", plist);

    return map;
  }

  @Override
  public Map<String, Object> totalSearchMore(Map<String, Object> map) {
    String filter = (String)map.get("filter");
    int curPage = Integer.parseInt(String.valueOf(map.get("curPage")));

    if(filter.indexOf("게임") != -1){
      int count = gameDao.totalSearchCount(map);

      Pager pager = new Pager(count, curPage, 10);
      int start = pager.getPageBegin();
      int end = pager.getPageEnd();

      map.put("start",start);
      map.put("end",end);

      List<GameDTO> list = gameDao.totalSearch(map);

      map.put("count",count);
      map.put("list",list);
      map.put("pager",pager);

    }else if(filter.indexOf("아티스트") != -1){
      int count = artistDao.totalSearchCount(map);

      Pager pager = new Pager(count, curPage, 60);
      int start = pager.getPageBegin();
      int end = pager.getPageEnd();

      map.put("start",start);
      map.put("end",end);

      List<ArtistDTO> list = artistDao.totalSearch(map);

      map.put("count", count);
      map.put("alist",list);
      map.put("pager",pager);

    }else if(filter.indexOf("디자이너") != -1){
      int count = designerDao.totalSearchCount(map);

      Pager pager = new Pager(count, curPage, 60);
      int start = pager.getPageBegin();
      int end = pager.getPageEnd();

      map.put("start",start);
      map.put("end",end);

      List<DesignerDTO> list = designerDao.totalSearch(map);

      map.put("count", count);
      map.put("dlist",list);
      map.put("pager",pager);

    }else if(filter.indexOf("퍼블리셔") != -1){
      int count = publisherDao.totalSearchCount(map);

      Pager pager = new Pager(count, curPage, 60);
      int start = pager.getPageBegin();
      int end = pager.getPageEnd();

      map.put("start",start);
      map.put("end",end);

      List<PublisherDTO> list = publisherDao.totalSearch(map);

      map.put("count", count);
      map.put("pager",pager);
      map.put("plist",list);
    }
    return map;
  }

  @Override
  public List<String> attachlist(int gnum) {
    List<String> list = gameDao.attachlist(gnum);
    return list;
  }

  @Override
  public Map<String, Object> game_list_category(int curPage) {
    Map<String, Object> map =new HashMap<>();

    int count = categoryDao.game_list_categoryCount();

    Pager pager = new Pager(count, curPage, 40);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();

    map.put("start",start);
    map.put("end",end);

    List<CategoryDTO> list = categoryDao.game_list_category(map);

    map.put("count", count);
    map.put("pager",pager);
    map.put("list",list);

    return map;
  }

  @Override
  public Map<String, Object> game_list_theme(int curPage, String sort) {
    Map<String, Object> map =new HashMap<>();
    map.put("sort",sort);

    int count = gameDao.game_list_themeCount(map);

    Pager pager = new Pager(count, curPage, 10);
    int start = pager.getPageBegin();
    int end = pager.getPageEnd();

    map.put("start",start);
    map.put("end",end);

    List<GameDTO> list = gameDao.game_list_theme(map);
    map.put("count", count);
    map.put("pager",pager);
    map.put("list",list);

    return map;
  }
}
