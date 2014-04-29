package com.plays.model;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Timestamp;


/**
 * The persistent class for the MCSENSE_READINGS database table.
 * 
 */
@Entity
@Table(name="MCSENSE_READINGS")
@NamedQueries({
	@NamedQuery(name="McsenseReading.recent",
        	  query="select s from McsenseReading s where s.readingId in (select MAX(st.readingId) from McsenseReading st group by st.userId) "),
    @NamedQuery(name="McsenseReading.findAll", query="SELECT s FROM McsenseReading s"),
    @NamedQuery(name="McsenseReading.count", query="SELECT count(s) FROM McsenseReading s"),
    @NamedQuery(name="McsenseReading.findById", query="SELECT s FROM McsenseReading s where s.readingId between :start and :end")
   // @NamedQuery(name="SensorReading.findNJITCovSquares", query="SELECT s.squareId, max(s.signallevel) FROM SensorReading s where (s.ssid like ('%NJIT%') or s.ssid like ('%njit%')) and s.squareId >= 0 group by s.squareId order by s.squareId "),
//    @NamedQuery(name="SensorReading.findNoNJITCovSquares", query="SELECT s1.squareId FROM SensorReading s1 where s1.squareId >= 0 group by s1.squareId "
//    		+ "EXCEPT "
//    		+ "SELECT s2.squareId FROM SensorReading s2 where (s2.ssid like ('%NJIT%') or s2.ssid like ('%njit%')) and s2.squareId >= 0 group by s2.squareId ")
})
public class McsenseReading implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="READING_ID")
	private int readingId;

	private String bssid;

	private String capabilities;

	@Column(name="CREATED_TIME")
	private Timestamp createdTime;

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

	public McsenseReading() {
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

	public Timestamp getCreatedTime() {
		return this.createdTime;
	}

	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
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

}