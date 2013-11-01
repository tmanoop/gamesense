package com.plays.model;

import java.io.Serializable;

import javax.persistence.*;


/**
 * The persistent class for the AREA database table.
 * 
 */
@Entity
@NamedQuery(name="Area.findAll", query="SELECT a FROM Area a")
public class Area implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="SQAURE_ID")
	private int sqaureId;

	@Column(name="COVERED_IND")
	private String coveredInd;

	@Column(name="FLOOR_NUM")
	private int floorNum;

	@Column(name="ROOM_NUM")
	private String roomNum;

	@Column(name="SQUARE_DESC")
	private String squareDesc;

	@Column(name="TILE_X")
	private double tileX;

	@Column(name="TILE_Y")
	private double tileY;
	
	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Transient
	private double distance;
	
	@OneToOne(orphanRemoval=true,mappedBy="area",cascade = {CascadeType.REMOVE,CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	private Alien alien;
	
	public Area() {
	}

	public int getSqaureId() {
		return this.sqaureId;
	}

	public void setSqaureId(int sqaureId) {
		this.sqaureId = sqaureId;
	}

	public String getCoveredInd() {
		return this.coveredInd;
	}

	public void setCoveredInd(String coveredInd) {
		this.coveredInd = coveredInd;
	}

	public int getFloorNum() {
		return this.floorNum;
	}

	public void setFloorNum(int floorNum) {
		this.floorNum = floorNum;
	}

	public String getRoomNum() {
		return this.roomNum;
	}

	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}

	public String getSquareDesc() {
		return this.squareDesc;
	}

	public void setSquareDesc(String squareDesc) {
		this.squareDesc = squareDesc;
	}

	public double getTileX() {
		return this.tileX;
	}

	public void setTileX(double tileX) {
		this.tileX = tileX;
	}

	public double getTileY() {
		return this.tileY;
	}

	public void setTileY(double tileY) {
		this.tileY = tileY;
	}	

	public double getGpsLat() {
		return gpsLat;
	}

	public void setGpsLat(double gpsLat) {
		this.gpsLat = gpsLat;
	}

	public double getGpsLng() {
		return gpsLng;
	}

	public void setGpsLng(double gpsLng) {
		this.gpsLng = gpsLng;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public Alien getAlien() {
		return alien;
	}

	public void setAlien(Alien alien) {
		this.alien = alien;
	}	
	
}