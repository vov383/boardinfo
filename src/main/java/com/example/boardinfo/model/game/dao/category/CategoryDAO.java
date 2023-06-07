package com.example.boardinfo.model.game.dao.category;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.category.CategoryDTO;

public interface CategoryDAO {

  int check_category(String gamecategory);
  int check_category(String gamecategory, int gnum);
  void insert_category(String gamecategory, String userid);
  void insert_category_mapping();
  void insert_category_mapping(int gnum,int cnum);
  int categorynum(String gamecategory);
  void insert_category_mapping(int cnum);
  List<CategoryDTO> list();
  List<CategoryDTO> view(int gnum);
}
