package com.plays.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.*;


/**
 * The persistent class for the SENSOR_READINGS database table.
 * 
 */
@Entity
@Table(name="SENSOR_READINGS")
@NamedQueries({
	@NamedQuery(name="SensorReading.recent",
        	  query="select s from SensorReading s where s.readingId in (select MAX(st.readingId) from SensorReading st group by st.userId) "),
    @NamedQuery(name="SensorReading.findAll", query="SELECT s FROM SensorReading s")
})
public class SensorReading implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="READING_ID")
	private int readingId;

	private String bssid;

	private String capabilities;

	private int frequency;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	private int signallevel;

	@Column(name="SQUARE_ID")
	private int squareId;

	private String ssid;

	@Column(name="USER_ID")
	private int userId;
	
	@Column(name="CREATED_TIME")
	private Timestamp createdTime;

	public SensorReading() {
	}

	public int getReadingId() {
		return this.readingId;
	}

	public void setReadingId(int readingId) {
		this.readingId = readingId;
	}

	public String getBssid() {
		return this.bssid;
	}

	public void setBssid(String bssid) {
		this.bssid = bssid;
	}

	public String getCapabilities() {
		return this.capabilities;
	}

	public void setCapabilities(String capabilities) {
		this.capabilities = capabilities;
	}

	public int getFrequency() {
		return this.frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
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

	public int getSignallevel() {
		return this.signallevel;
	}

	public void setSignallevel(int signallevel) {
		this.signallevel = signallevel;
	}

	public int getSquareId() {
		return this.squareId;
	}

	public void setSquareId(int squareId) {
		this.squareId = squareId;
	}

	public String getSsid() {
		return this.ssid;
	}

	public void setSsid(String ssid) {
		this.ssid = ssid;
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Timestamp getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Timestamp timestamp) {
		this.createdTime = timestamp;
	}

}