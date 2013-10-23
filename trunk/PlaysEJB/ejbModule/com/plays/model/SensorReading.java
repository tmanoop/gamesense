package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the SENSOR_READINGS database table.
 * 
 */
@Entity
@Table(name="SENSOR_READINGS")
@NamedQuery(name="SensorReading.findAll", query="SELECT s FROM SensorReading s")
public class SensorReading implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="READING_ID")
	private int readingId;

	@Column(name="GPS_LAT")
	private double gpsLat;

	@Column(name="GPS_LNG")
	private double gpsLng;

	@Column(name="READING_VALUE_ID")
	private int readingValueId;

	@Column(name="SQUARE_ID")
	private int squareId;

	@Column(name="USER_ID")
	private int userId;

	public SensorReading() {
	}

	public int getReadingId() {
		return this.readingId;
	}

	public void setReadingId(int readingId) {
		this.readingId = readingId;
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

	public int getReadingValueId() {
		return this.readingValueId;
	}

	public void setReadingValueId(int readingValueId) {
		this.readingValueId = readingValueId;
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