package com.example.boardinfo.service.game;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

public interface GameService {

  Map<String, Object> gamelist(int curPage, String sort);
  void gameinsert(GameDTO dto);
  void increaseViewcnt(int gnum, HttpServletRequest request, HttpServletResponse response) throws Exception;
  Map<String, Object> view(int gnum) throws Exception;
  List<CategoryDTO> categorylist();
  List<MechanicDTO> mechaniclist();
  List<ArtistDTO> getAutoArtist(String input);
  List<DesignerDTO> getAutoDesigner(String input);
  List<PublisherDTO> getAutoPublisher(String input);
  List<GameDTO> getAutoGame(String input);
  void deleteFile(String fileName);
  Map<String, Object> filteredGamelist(String filter,int num, int curPage, String sort);
  GameDTO updateView(int gnum);
  void gameupdate(GameDTO dto);
  void deleteGame(int gnum, String userid);
  Map<String, Object> parseInsert(int bggnum);
  Map<String, Object> getExRe(String origin, String filter, int num);
  void autoUpdate_delete(String value, int gnum, String filter);
  Map<String, Object> gameListMain();
  Map<String, Object> totalSearch(String gameKeyword);
  Map<String, Object> totalSearchMore(Map<String, Object> map);
  List<String> attachlist(int gnum);
  Map<String, Object> game_list_category(int curPage);
  Map<String, Object> game_list_theme(int curPage, String sort);
}
