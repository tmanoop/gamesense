package com.plays.util;

import java.sql.Timestamp;

import javax.naming.InitialContext;
import javax.naming.NamingException;

public class GameUtility {
	
	public static <E> E lookupEJB(String binding){
		try { 
			return (E) new InitialContext().lookup(binding);
		} catch(NamingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static Timestamp getTimestamp(){
		return new Timestamp(getCurrentTime());
	}
	
	public static long getCurrentTime(){
		return System.currentTimeMillis();
	}
}
