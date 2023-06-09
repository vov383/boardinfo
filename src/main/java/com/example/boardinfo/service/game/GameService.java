package com.example.boardinfo.service.game;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

public interface GameService {

  Map<String, Object> gamelist(int curPage);
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
  Map<String, Object> filteredGamelist(String filter,int num, int curPage);
  GameDTO updateView(int gnum);
  void gameupdate(GameDTO dto);
  void deleteGame(int gnum, String userid);
  Map<String, Object> parseInsert(int bggnum);
}
