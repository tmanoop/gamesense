package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the ALIENS database table.
 * 
 */
@Entity
@Table(name="ALIENS")
@NamedQuery(name="Alien.findAll", query="SELECT a FROM Alien a")
public class Alien implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="ALIEN_ID")
	private int alienId;

	@Column(name="CURRENT_SQUARE_ID")
	private int currentSquareId;

	@Column(name="NEXT_GPS_LAT")
	private double nextGpsLat;

	@Column(name="NEXT_GPS_LNG")
	private double nextGpsLng;

	@Column(name="SHOT_COUNT")
	private int shotCount;

	public Alien() {
	}

	public int getAlienId() {
		return this.alienId;
	}

	public void setAlienId(int alienId) {
		this.alienId = alienId;
	}

	public int getCurrentSquareId() {
		return this.currentSquareId;
	}

	public void setCurrentSquareId(int currentSquareId) {
		this.currentSquareId = currentSquareId;
	}

	public double getNextGpsLat() {
		return this.nextGpsLat;
	}

	public void setNextGpsLat(double nextGpsLat) {
		this.nextGpsLat = nextGpsLat;
	}

	public double getNextGpsLng() {
		return this.nextGpsLng;
	}

	public void setNextGpsLng(double nextGpsLng) {
		this.nextGpsLng = nextGpsLng;
	}

	public int getShotCount() {
		return this.shotCount;
	}

	public void setShotCount(int shotCount) {
		this.shotCount = shotCount;
	}

}