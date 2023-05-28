package com.example.boardinfo.model.game.dao.designer;

import com.example.boardinfo.model.game.dto.designer.DesignerDTO;

import java.util.List;

public interface DesignerDAO {

	int check_designer(String designer);
	void insert_designer(String designer);
	void insert_designer_mapping();
	int designernum(String designer);
	void insert_designer_mapping(int dnum);
    List<DesignerDTO> getAutoDesigner(String input);
	List<DesignerDTO> view(int gnum);
}
