package com.example.boardinfo.model.game.dao.designer;

import com.example.boardinfo.model.game.dto.designer.DesignerDTO;

import java.util.List;

public interface DesignerDAO {

	public int check_designer(String designer);
	public void insert_designer(String designer);
	public void insert_designer_mapping();
	public int designernum(String designer);
	public void insert_designer_mapping(int dnum);
    public List<DesignerDTO> getAutoDesigner(String input);
}
