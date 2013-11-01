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

	@Column(name="SQUARE_ID", insertable = false, updatable = false)
	private int squareId;

	@Column(name="SHOT_COUNT")
	private int shotCount;
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="SQUARE_ID")
	private Area area;

	public Alien() {
	}

	public int getAlienId() {
		return this.alienId;
	}

	public void setAlienId(int alienId) {
		this.alienId = alienId;
	}

	public int getSquareId() {
		return this.squareId;
	}

	public void setSquareId(int squareId) {
		this.squareId = squareId;
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