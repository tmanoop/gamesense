package com.plays.services;

import java.util.List;

import javax.ejb.Local;

import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.model.McsenseReading;
import com.plays.model.SensorReading;
import com.plays.model.Sentinel;
import com.plays.model.User;
import com.plays.model.WiFiMap;

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

	Sentinel findSentinel(String meid);

	Sentinel updateSentinel(Sentinel p);

	List<SensorReading> allRecentReadings();

	List<Sentinel> allSentinels();

	List<SensorReading> allSensorReadings();

	List<SensorReading> allSensorReadingsBetweenIDs(long start, long end);

	long allSensorReadingsCount();

	List<WiFiMap> findNJITCovSquares();

	List<WiFiMap> findNoNJITCovSquares();

	Alien findAvailableAlienByShotCnt(int shotCount);

	Area findAreaByXYFloor(double tileX, double tileY, int floor);

	List<McsenseReading> allMcsenseReadingsBetweenIDs(long start, long end);

	McsenseReading addMcsenseReading(McsenseReading rv);

	List<WiFiMap> findMcsenseNJITCovSquares();

	List<WiFiMap> findNoMcsenseNJITCovSquares();
}