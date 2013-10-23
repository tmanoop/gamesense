package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the BULLETS database table.
 * 
 */
@Entity
@Table(name="BULLETS")
@NamedQuery(name="Bullet.findAll", query="SELECT b FROM Bullet b")
public class Bullet implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="BULLET_ID")
	private int bulletId;

	@Column(name="BULLET_COUNT")
	private int bulletCount;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Column(name="SQUARE_ID")
	private int squareId;

	public Bullet() {
	}

	public int getBulletId() {
		return this.bulletId;
	}

	public void setBulletId(int bulletId) {
		this.bulletId = bulletId;
	}

	public int getBulletCount() {
		return this.bulletCount;
	}

	public void setBulletCount(int bulletCount) {
		this.bulletCount = bulletCount;
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

}