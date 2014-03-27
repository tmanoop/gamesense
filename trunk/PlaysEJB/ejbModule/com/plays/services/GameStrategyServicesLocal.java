package com.plays.services;

import javax.ejb.Local;

import com.plays.model.Alien;
import com.plays.model.Area;

@Local
public interface GameStrategyServicesLocal {
	
	void moveAlien(Alien alien1);
	
	Alien getAlien(Area choosenSquare);
	
	int getNearestAvailableSquare(int currentSquareId);

	Area getNearestAvailableSquare(Area area);
	
	Area getNearestAvailableAlien(Area currentSquare);

}
