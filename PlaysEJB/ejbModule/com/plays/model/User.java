package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the USERS database table.
 * 
 */
@Entity
@Table(name="USERS")
@NamedQueries({
	@NamedQuery(name="User.loginCheck",
        	  query="Select e from User e where e.userMeid = :meid"),
	@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
})
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="USER_ID")
	private int userId;

	@Column(name="USER_ACCESS")
	private String userAccess;
	
	@Column(name="ALIENS_KILLED")
	private int aliensKilled;

	@Column(name="BULLETS")
	private int bullets;

	@Column(name="SCORE")
	private int score;

	@Column(name="STATUS_LEVEL")
	private String statusLevel;

	@Column(name="USER_EMAIL")
	private String userEmail;

	@Column(name="USER_MEID")
	private String userMeid;

	public User() {
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserAccess() {
		return userAccess;
	}

	public void setUserAccess(String userAccess) {
		this.userAccess = userAccess;
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

	public String getUserMeid() {
		return userMeid;
	}

	public void setUserMeid(String userMeid) {
		this.userMeid = userMeid;
	}

}