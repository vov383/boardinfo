package com.example.boardinfo.model.game.dao.mechanic;

import java.util.List;
import java.util.Map;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;
import com.example.boardinfo.model.game.dto.mechanic.MechanicDTO;

public interface MechanicDAO {

	int check_mechanic(String mechanic);
	int check_mechanic(String mechanic, int gnum);
	void insert_mechanic(String mechanic, String userid);
	void insert_mechanic_mapping();
	void insert_mechanic_mapping(int mnum);
    List<MechanicDTO> list();
    List<MechanicDTO> view(int gnum);
	void insert_mechanic_mapping(int gnum, int mnum);
    List<String> viewMechanic(int gnum);

    void deleteGame_Mechanic(String value, int gnum);

    List<MechanicDTO> confirmList(Map<String, Object> map);

    void deleteitem(int num);
}
