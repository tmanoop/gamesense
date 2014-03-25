package com.plays.json;

import java.util.List;

public class JData {
	private String email;
	private String meid;
	private String requestType;
	private int score;
	private int bustedAliens;
	private int collectedPowerCount;
	private int level;
	private double currentLat;
	private double currentLng;
	private List<JWiFiData> jWiFiData;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMeid() {
		return meid;
	}
	public void setMeid(String meid) {
		this.meid = meid;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getBustedAliens() {
		return bustedAliens;
	}
	public void setBustedAliens(int bustedAliens) {
		this.bustedAliens = bustedAliens;
	}
	public int getCollectedPowerCount() {
		return collectedPowerCount;
	}
	public void setCollectedPowerCount(int collectedPowerCount) {
		this.collectedPowerCount = collectedPowerCount;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public double getCurrentLat() {
		return currentLat;
	}
	public void setCurrentLat(double d) {
		this.currentLat = d;
	}
	public double getCurrentLng() {
		return currentLng;
	}
	public void setCurrentLng(double currentLng) {
		this.currentLng = currentLng;
	}
	public List<JWiFiData> getjWiFiData() {
		return jWiFiData;
	}
	public void setjWiFiData(List<JWiFiData> jWiFiData) {
		this.jWiFiData = jWiFiData;
	}
	
	
}
