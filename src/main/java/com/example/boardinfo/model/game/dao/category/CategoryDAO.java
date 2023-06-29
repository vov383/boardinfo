package com.example.boardinfo.model.game.dao.category;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.category.CategoryDTO;

public interface CategoryDAO {

  int check_category(String category);
  int check_category(String category, int gnum);
  void insert_category(String category, String userid);
  void insert_category_mapping();
  void insert_category_mapping(int gnum,int cnum);
  void insert_category_mapping(int cnum);
  List<CategoryDTO> list();
  List<CategoryDTO> view(int gnum);
  List<String> viewGamecategory(int gnum);

  void deleteGame_Category(String category, int gnum);

    List<CategoryDTO> confirmList(Map<String, Object> map);

    void deleteitem(int num);

    int game_list_categoryCount();

  List<CategoryDTO> game_list_category(Map<String, Object> map);
}
