package com.example.boardinfo.service.game;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.designer.DesignerDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;
import com.example.boardinfo.model.game.dto.publisher.PublisherDTO;

public interface GameService {

  public List<GameDTO> gamelist();
  public void gameinsert(GameDTO dto);
  public void increaseViewcnt(int gnum, HttpSession session) throws Exception;
  public GameDTO view(int gnum) throws Exception;
  public List<CategoryDTO> categorylist();
  public List<MechanicDTO> mechaniclist();
  public List<ArtistDTO> getAutoArtist(String input);
  public List<DesignerDTO> getAutoDesigner(String input);
  public List<PublisherDTO> getAutoPublisher(String input);
  public List<GameDTO> getAutoGame(String input);
  public void deleteFile(String fileName);
}
