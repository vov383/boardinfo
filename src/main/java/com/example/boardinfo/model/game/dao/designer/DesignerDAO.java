package com.example.boardinfo.model.game.dao.designer;

import com.example.boardinfo.model.game.dto.designer.DesignerDTO;

import java.util.List;
import java.util.Map;

public interface DesignerDAO {

	int check_designer(String designer);
	int check_designer(String designer, int gnum);
	void insert_designer(String designer, String userid);
	void insert_designer_mapping();
	void insert_designer_mapping(int dnum);
    List<DesignerDTO> getAutoDesigner(String input);
	List<DesignerDTO> view(int gnum);
	void insert_designer_mapping(int gnum, int dnum);
    List<String> viewDesigner(int gnum);
    void deleteGame_Designer(String value, int gnum);
    List<DesignerDTO> totalSearch(Map<String, Object> map);
    int totalSearchCount(Map<String, Object> map);
    List<DesignerDTO> confirmList(Map<String, Object> map);
    void deleteitem(int num);

    void update_designer_mapping(int gnum);
    void update_designer_mapping(int gnum, int dnum);
}
