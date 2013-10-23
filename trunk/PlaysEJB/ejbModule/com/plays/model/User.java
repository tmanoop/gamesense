package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the USERS database table.
 * 
 */
@Entity
@Table(name="USERS")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="USER_ID")
	private int userId;

	@Column(name="ALIENS_KILLED")
	private int aliensKilled;

	private int bullets;

	private int score;

	@Column(name="STATUS_LEVEL")
	private String statusLevel;

	@Column(name="USER_EMAIL")
	private String userEmail;

	@Column(name="USER_PSWD")
	private String userPswd;

	public User() {
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAliensKilled() {
		return this.aliensKilled;
	}

	public void setAliensKilled(int aliensKilled) {
		this.aliensKilled = aliensKilled;
	}

	public int getBullets() {
		return this.bullets;
	}

	public void setBullets(int bullets) {
		this.bullets = bullets;
	}

	public int getScore() {
		return this.score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getStatusLevel() {
		return this.statusLevel;
	}

	public void setStatusLevel(String statusLevel) {
		this.statusLevel = statusLevel;
	}

	public String getUserEmail() {
		return this.userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPswd() {
		return this.userPswd;
	}

	public void setUserPswd(String userPswd) {
		this.userPswd = userPswd;
	}

}