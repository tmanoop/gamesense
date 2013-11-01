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

	@Column(name="SHOT_COUNT")
	private int shotCount;
	
	@OneToOne
	@PrimaryKeyJoinColumn(name="CURRENT_SQUARE_ID",referencedColumnName="SQAURE_ID")
	private Area area;

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

	public int getShotCount() {
		return this.shotCount;
	}

	public void setShotCount(int shotCount) {
		this.shotCount = shotCount;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
}