package com.example.boardinfo.service.game;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.boardinfo.model.game.dto.GameDTO;
import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.category.CategoryDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

public interface GameService {

  public List<GameDTO> gamelist();
  public void gameinsert(GameDTO dto);
  public void increaseViewcnt(int gnum, HttpSession session) throws Exception;
  public Object view(int gnum) throws Exception;
  public List<CategoryDTO> categorylist();
  public List<MechanicDTO> mechaniclist();
  public List<String> getAuto(String query);

}
