package com.plays.services;

import java.util.List;

import javax.ejb.Local;

import com.plays.model.Alien;

@Local
public interface AlienServicesLocal {

	List<Alien> allAliens();

	Alien findAlienByID(int ID);

	Alien add(Alien alien);

	boolean delete(int ID);

	void update(Alien alien);
}