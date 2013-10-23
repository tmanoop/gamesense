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

	@Column(name="FLOOR_NUM")
	private int floorNum;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Column(name="ROOM_NUM")
	private String roomNum;

	@Column(name="SQUARE_DESC")
	private String squareDesc;

	public Area() {
	}

	public int getSqaureId() {
		return this.sqaureId;
	}

	public void setSqaureId(int sqaureId) {
		this.sqaureId = sqaureId;
	}

	public int getFloorNum() {
		return this.floorNum;
	}

	public void setFloorNum(int floorNum) {
		this.floorNum = floorNum;
	}

	public double getGpsLat() {
		return this.gpsLat;
	}

	public void setGpsLat(double gpsLat) {
		this.gpsLat = gpsLat;
	}

	public double getGpsLng() {
		return this.gpsLng;
	}

	public void setGpsLng(double gpsLng) {
		this.gpsLng = gpsLng;
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

}