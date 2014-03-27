package com.plays.services;

import java.util.List;

import javax.ejb.Local;

import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.model.SensorReading;
import com.plays.model.User;

@Local
public interface AlienServicesLocal {

	List<Alien> allAliens();

	Alien findAlienByID(int ID);

	Alien add(Alien alien);

	boolean delete(int ID);

	void update(Alien alien);
	
	List<Area> allAreas();

	Area findAreaByID(int ID);
	
	void updateArea(Area area);

	SensorReading addSensorReading(SensorReading rv);

	User updateUser(User p);

	User findUser(String meid);

	Area findAreaByXY(double tileX, double tileY);

	List<Area> findAreasByInd(String coveredInd);

	List<Alien> findAliensByShotCnt();
}