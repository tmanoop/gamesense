package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the SENTINELS database table.
 * 
 */
@Entity
@Table(name="SENTINELS")
@NamedQuery(name="Sentinel.findAll", query="SELECT s FROM Sentinel s")
public class Sentinel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="SENTINEL_ID")
	private int sentinelId;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Column(name="SQUARE_ID")
	private int squareId;

	@Column(name="USER_ID")
	private int userId;

	public Sentinel() {
	}

	public int getSentinelId() {
		return this.sentinelId;
	}

	public void setSentinelId(int sentinelId) {
		this.sentinelId = sentinelId;
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

	public int getSquareId() {
		return this.squareId;
	}

	public void setSquareId(int squareId) {
		this.squareId = squareId;
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}