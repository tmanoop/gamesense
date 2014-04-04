package com.plays.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.util.DistanceSortComparator;

/**
 * Session Bean implementation class GameStrategyServices
 */
@Stateless
@LocalBean
public class GameStrategyServices implements GameStrategyServicesLocal {

	@EJB(name="com.plays.services.AlienServices")
	AlienServicesLocal alienServicesLocal;
    /**
     * Default constructor. 
     */
    public GameStrategyServices() {
        // TODO Auto-generated constructor stub
    }
    
    public void moveAlien(Alien alien1){
		int currentSquareId = alien1.getSquareId();
		Area choosenSquare = chooseSquareFromUnpopularRegions(currentSquareId);
		if(choosenSquare == null){
//			4: The targeted area is fully covered and the game is complete
		} else {
			Alien alien2 = getAlien(choosenSquare);
			alien1.setSquareId(choosenSquare.getSqaureId());
			if(alien2 != null){
				alien2.setSquareId(getNearestAvailableSquare(currentSquareId));
			}
			updateCoveredSquare(currentSquareId);
		}
	}
	
	public Alien getAlien(Area choosenSquare) {
		List<Alien> aliensList = alienServicesLocal.allAliens();
		for(Alien a : aliensList){
			if(a.getSquareId() == choosenSquare.getSqaureId())
				return a;
		}
		return null;
	}

	private void updateCoveredSquare(int currentSquareId) {
		Area area = alienServicesLocal.findAreaByID(currentSquareId);
		area.setCoveredInd("Y");
		alienServicesLocal.updateArea(area);
	}

	public int getNearestAvailableSquare(int currentSquareId) {
		Area currentSquare = alienServicesLocal.findAreaByID(currentSquareId);
		List<Area> areaList = alienServicesLocal.allAreas();
		List<Area> availableAreaList = new ArrayList<Area>();
		for(Area area : areaList){
			if(area.getCoveredInd().equalsIgnoreCase("N")){
				// move latlng columns into Area table and update the values with center of tiles
				double distance = distance(area.getGpsLat(), area.getGpsLng(), currentSquare.getGpsLat(), currentSquare.getGpsLng(), 'K');
				area.setDistance(distance);
				availableAreaList.add(area);				
			}
		}
		//get distances to all available squares
		//sort and pick the nearest
		Collections.sort(availableAreaList, new DistanceSortComparator());
//		for(Area area : availableAreaList){
//			System.out.println(area.getSqaureId()+","+area.getDistance());
//		}
		return availableAreaList.get(0).getSqaureId();
	}
	
	public Area getNearestAvailableSquare(Area currentSquare) {
		List<Area> areaList = alienServicesLocal.findAreasByInd("N");
		List<Area> availableAreaList = new ArrayList<Area>();
		for(Area area : areaList){
				// move latlng columns into Area table and update the values with center of tiles
				double distance = distance(area.getGpsLat(), area.getGpsLng(), currentSquare.getGpsLat(), currentSquare.getGpsLng(), 'K');
				area.setDistance(distance);
				availableAreaList.add(area);	
		}
		//get distances to all available squares
		//sort and pick the nearest
		Collections.sort(availableAreaList, new DistanceSortComparator());
//		for(Area area : availableAreaList){
//			System.out.println(area.getSqaureId()+","+area.getDistance());
//		}
		return availableAreaList.get(0);
	}

	public Area getNearestAvailableAlien(Area currentSquare) {
		List<Alien> aliens =  alienServicesLocal.findAliensByShotCnt();
		List<Area> availableAreaList = new ArrayList<Area>();
		for(Alien alien : aliens){
			Area area = alien.getArea();
				// move latlng columns into Area table and update the values with center of tiles
			if(area!=null){
				double distance = distance(area.getGpsLat(), area.getGpsLng(), currentSquare.getGpsLat(), currentSquare.getGpsLng(), 'K');
				area.setDistance(distance);
				availableAreaList.add(area);
			}
		}
		//get distances to all available squares
		//sort and pick the nearest
		Collections.sort(availableAreaList, new DistanceSortComparator());
//		for(Area area : availableAreaList){
//			System.out.println(area.getSqaureId()+","+area.getDistance());
//		}
		return availableAreaList.get(0);
	}

	
	private Area chooseSquareFromUnpopularRegions(int currentSquareId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public double distance(double lat1, double lon1, double lat2, double lon2,
			char unit) {
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2))
				* Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		if (unit == 'K') {
			dist = dist * 1.609344;
		} else if (unit == 'N') {
			dist = dist * 0.8684;
		}
		return (dist);
	}

	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	/* :: This function converts decimal degrees to radians : */
	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	private double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	/* :: This function converts radians to decimal degrees : */
	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	private double rad2deg(double rad) {
		return (rad * 180.0 / Math.PI);
	}

}
