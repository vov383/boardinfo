package com.example.boardinfo.model.game.dao.category;

import java.util.List;

import com.example.boardinfo.model.game.dto.category.CategoryDTO;

public interface CategoryDAO {

  public int check_category(String gamecategory);
  public void insert_category(String gamecategory);
  public void insert_category_mapping();
  public int categorynum(String gamecategory);
  public void insert_category_mapping(int cnum);
  public List<CategoryDTO> list();

}
