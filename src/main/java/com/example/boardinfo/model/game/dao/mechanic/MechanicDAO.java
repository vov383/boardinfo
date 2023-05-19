package com.example.boardinfo.model.game.dao.mechanic;

import java.util.List;

import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

public interface MechanicDAO {

	public int check_mechanic(String mechanic);
	public void insert_mechanic(String mechanic);
	public void insert_mechanic_mapping();
	public int mechanicnum(String mechanic);
	public void insert_mechanic_mapping(int mnum);
    public List<MechanicDTO> list();
    
}
