package com.plays.model;

import java.io.Serializable;

import javax.persistence.*;


/**
 * The persistent class for the SENTINELS database table.
 * 
 */
@Entity
@Table(name="SENTINELS")
@NamedQueries({
	@NamedQuery(name="Sentinel.findByMeid",
      	  query="Select e from Sentinel e where e.userMeid = :meid"),
	@NamedQuery(name="Sentinel.findAll", query="SELECT s FROM Sentinel s")
})
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

	@Column(name="USER_MEID")
	private String userMeid;

	@Column(name="USER_EMAIL")
	private String userEmail;

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

	public String getUserMeid() {
		return userMeid;
	}

	public void setUserMeid(String userMeid) {
		this.userMeid = userMeid;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}	
}