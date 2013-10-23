package com.plays.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the READING_VALUES database table.
 * 
 */
@Entity
@Table(name="READING_VALUES")
@NamedQuery(name="ReadingValue.findAll", query="SELECT r FROM ReadingValue r")
public class ReadingValue implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="READING_VALUE_ID")
	private int readingValueId;

	@Column(name="MAC_ID")
	private String macId;

	@Column(name="MAC_SIGNAL_STRENGTH")
	private double macSignalStrength;

	@Column(name="READING_ID")
	private int readingId;

	public ReadingValue() {
	}

	public int getReadingValueId() {
		return this.readingValueId;
	}

	public void setReadingValueId(int readingValueId) {
		this.readingValueId = readingValueId;
	}

	public String getMacId() {
		return this.macId;
	}

	public void setMacId(String macId) {
		this.macId = macId;
	}

	public double getMacSignalStrength() {
		return this.macSignalStrength;
	}

	public void setMacSignalStrength(double macSignalStrength) {
		this.macSignalStrength = macSignalStrength;
	}

	public int getReadingId() {
		return this.readingId;
	}

	public void setReadingId(int readingId) {
		this.readingId = readingId;
	}

}