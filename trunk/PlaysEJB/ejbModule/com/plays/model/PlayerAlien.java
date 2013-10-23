package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the PLAYER_ALIENS database table.
 * 
 */
@Entity
@Table(name="PLAYER_ALIENS")
@NamedQuery(name="PlayerAlien.findAll", query="SELECT p FROM PlayerAlien p")
public class PlayerAlien implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="PLAYER_ALIEN_ID")
	private int playerAlienId;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Column(name="SHOT_ALIEN_ID")
	private int shotAlienId;

	@Column(name="SHOT_SQUARE_ID")
	private int shotSquareId;

	@Column(name="USER_ID")
	private int userId;

	public PlayerAlien() {
	}

	public int getPlayerAlienId() {
		return this.playerAlienId;
	}

	public void setPlayerAlienId(int playerAlienId) {
		this.playerAlienId = playerAlienId;
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

	public int getShotAlienId() {
		return this.shotAlienId;
	}

	public void setShotAlienId(int shotAlienId) {
		this.shotAlienId = shotAlienId;
	}

	public int getShotSquareId() {
		return this.shotSquareId;
	}

	public void setShotSquareId(int shotSquareId) {
		this.shotSquareId = shotSquareId;
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}