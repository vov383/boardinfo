package com.example.boardinfo.model.game.dao.mechanic;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

public interface MechanicDAO {

	int check_mechanic(String mechanic);
	int check_mechanic(String mechanic, int gnum);
	void insert_mechanic(String mechanic);
	void insert_mechanic_mapping();
	int mechanicnum(String mechanic);
	void insert_mechanic_mapping(int mnum);
    List<MechanicDTO> list();
    List<MechanicDTO> view(int gnum);
	void insert_mechanic_mapping(int gnum, int mnum);
}
