package com.plays.webutil;

import java.util.Comparator;

import com.plays.model.Area;

public class DistanceSortComparator implements Comparator<Area> {
	@Override
	public int compare(Area o1, Area o2) {
		// TODO Auto-generated method stub
		return new Double(o1.getDistance()).compareTo(new Double(o2.getDistance()));
	}
}
