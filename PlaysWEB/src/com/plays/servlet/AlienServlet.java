package com.plays.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.plays.json.JData;
import com.plays.json.JWiFiData;
import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.model.SensorReading;
import com.plays.model.Sentinel;
import com.plays.model.User;
import com.plays.services.AlienServicesLocal;
import com.plays.services.GameStrategyServicesLocal;
import com.plays.util.GoogleMapsProjection2;
import com.plays.util.Point;

/**
 * Servlet implementation class AlienServlet
 */
@WebServlet("/AlienServlet")
public class AlienServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String ALIEN_SEARCH = "alienSearch";
	private static final String ALIEN_SHOT = "alienShot";
	private static final String ALIEN_HINTS = "alienHints";
	private static final String SENTINEL_SEARCH = "sentinelSearch";
	
	private static final double NJIT_LAT = 40.741675;
	private static final double NJIT_LNG = -74.177552;
       
	@EJB(name="com.plays.services.AlienServices")
	AlienServicesLocal alienServicesLocal;
	
	@EJB(name="com.plays.services.GameStrategyServices")
	GameStrategyServicesLocal gameStrategyServicesLocal;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlienServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String meid = request.getParameter("meid");
		String requestType = request.getParameter("requestType");
		String searchLat = request.getParameter("searchLat");
		String searchLng = request.getParameter("searchLng");
		String foundAlienLat = "0";
		String foundAlienLng = "0";
		if(ALIEN_SEARCH.equalsIgnoreCase(requestType)){
			//save sensor readings
//			saveSensorReadings();
			//search alien near the user loc
//			searchAlien();
		} else if(ALIEN_SHOT.equalsIgnoreCase(requestType)){
			//move alien to new location and update user scores
//			moveAlien();
		} else if(ALIEN_HINTS.equalsIgnoreCase(requestType)){
			//return up to 3 near by aliens
//			searchAlien();
		}
	}

	private JData moveAlien(JData jData, Area area) {
//		System.out.println("Alien shot and moved.");

		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		
		if(area!=null){
			if(area.getCoveredInd() == null || area.getCoveredInd().equalsIgnoreCase("N")) {
				area.setCoveredInd("Y");
				alienServicesLocal.updateArea(area);
			}
			Area nearestSquare = gameStrategyServicesLocal.getNearestAvailableSquare(area);
			User p = alienServicesLocal.findUser(jData.getMeid());
			if(area.getAlien()!=null){
				Alien alien = area.getAlien();
				if(alien.getShotCount()<2){
					alien.setShotCount(alien.getShotCount()+1);
					alien.setArea(nearestSquare);
					if(p!=null)
						alien.setUserId(p.getUserId());
					alienServicesLocal.update(alien);
					if(nearestSquare!=null){
						nearestSquare.setAlien(alien);
						alienServicesLocal.updateArea(nearestSquare);
					}
				} else if(alien.getShotCount()==2) {
					alien.setShotCount(alien.getShotCount()+1);
					alienServicesLocal.update(alien);
				}
			} else {
				Alien alien = alienServicesLocal.findAvailableAlienByShotCnt(1);
				if(alien==null)
					alien = alienServicesLocal.findAvailableAlienByShotCnt(2);
				
				if(alien!=null){
					alien.setShotCount(alien.getShotCount()+1);
					alien.setArea(nearestSquare);
					if(p!=null)
						alien.setUserId(p.getUserId());
					alienServicesLocal.update(alien);
					if(nearestSquare!=null){
						nearestSquare.setAlien(alien);
						alienServicesLocal.updateArea(nearestSquare);
					}
				}
				
			}
			
			if(jData.getAlienRunCounter()<2){
//				System.out.println("Next available sqaure: "+nearestSquare);
				if(nearestSquare!=null){
					newJData.setCurrentLat(nearestSquare.getGpsLat());
					newJData.setCurrentLng(nearestSquare.getGpsLng());
					newJData.setFloorNum(nearestSquare.getFloorNum());
				}
			}
			
		} else if (isLocAtNJIT(jData.getCurrentLat(), jData.getCurrentLng())) {
			//TODO only for testing everywhere not in NJIT. comment this after testing
//			newJData.setCurrentLat(jData.getCurrentLat() + Math.random()/1000);
//			newJData.setCurrentLng(jData.getCurrentLng() + Math.random()/1000);
		}
		
		return newJData;
	}

	private JData alienHints(JData jData, Area area) {
//		System.out.println("Searching Alien.");
		
		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		if(area!=null){
			Area nearestSquare = gameStrategyServicesLocal.getNearestAvailableAlien(area);
			
			newJData.setCurrentLat(nearestSquare.getGpsLat());
			newJData.setCurrentLng(nearestSquare.getGpsLng());
			newJData.setFloorNum(nearestSquare.getFloorNum());
		} else if(isLocAtNJIT(jData.getCurrentLat(), jData.getCurrentLng())) {
			//TODO only for testing everywhere not in NJIT. comment this after testing
//			newJData.setCurrentLat(jData.getCurrentLat() + Math.random()/1000);
//			newJData.setCurrentLng(jData.getCurrentLng() + Math.random()/1000);
		}
		return newJData;
	}
	
	private JData searchAlienLocation(JData jData, Area area) {
		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		
//		System.out.println("Searching monster, Player: "+jData.getEmail()+", at point x,y: "+point.x+","+ point.y+", area found: "+area);
		if(area!=null){
			if(area.getCoveredInd() == null || area.getCoveredInd().equalsIgnoreCase("N")) {
				area.setCoveredInd("Y");
				alienServicesLocal.updateArea(area);
			}

//			System.out.println("Alien: "+area.getAlien());
			if(area.getAlien()!=null && area.getAlien().getShotCount() < 2){
				newJData.setCurrentLat(area.getGpsLat());
				newJData.setCurrentLng(area.getGpsLng());
				newJData.setFloorNum(area.getFloorNum());
			} else if(isLocAtNJIT(jData.getCurrentLat(), jData.getCurrentLng()) && jData.getBustedAliens()==0){
				newJData.setCurrentLat(jData.getCurrentLat() );
				newJData.setCurrentLng(jData.getCurrentLng() );
			}
		} else if(isLocAtNJIT(jData.getCurrentLat(), jData.getCurrentLng()) && !JData.SENTINEL_SEARCH.equalsIgnoreCase(jData.getRequestType()) && jData.getCollectedPowerCount()%2==0){
			//TODO only for testing everywhere not in NJIT. comment this after testing
//			newJData.setCurrentLat(jData.getCurrentLat() );
//			newJData.setCurrentLng(jData.getCurrentLng() );
		}
		
		return newJData;
	}	

	private void saveSentinel(JData jData) {
		Sentinel p = alienServicesLocal.findSentinel(jData.getMeid());
		if (p != null) {
			p.setGpsLat(jData.getCurrentLat());
			p.setGpsLng(jData.getCurrentLng());
		} else {
			p = new Sentinel();
			p.setUserEmail(jData.getEmail());
			p.setUserMeid(jData.getMeid());
			p.setGpsLat(jData.getCurrentLat());
			p.setGpsLng(jData.getCurrentLng());
		}

		alienServicesLocal.updateSentinel(p);
	}

	private void saveSensorReadings(JData jData, Area area) {
//		System.out.println("Sensor readings saved.");
		// System.out.println(jData.getEmail()+", "+jData.getMeid()+", "+jData.getScore());
					// System.out.println("Sensor readings saved.");
					User p = alienServicesLocal.findUser(jData.getMeid());
					if (p != null) {
						p.setUserEmail(jData.getEmail());
						p.setAliensKilled(jData.getBustedAliens());
						p.setBullets(jData.getCollectedPowerCount() < 50 ? 100 : jData.getCollectedPowerCount());
						p.setScore(jData.getScore());
						p.setStatusLevel(jData.getLevel() + "");
						alienServicesLocal.updateUser(p);

					}

					List<JWiFiData> jWiFiDataList = jData.getjWiFiData();
					for (JWiFiData jWiFiData : jWiFiDataList) {
						// System.out.println(jWiFiData.getBSSID()+", "+jWiFiData.getSSID());
						SensorReading sensorReading = new SensorReading();
						sensorReading.setBssid(jWiFiData.getBSSID());
						sensorReading.setSsid(jWiFiData.getSSID());
						sensorReading.setCapabilities(jWiFiData.getCapabilities());
						sensorReading.setFrequency(jWiFiData.getFrequency());
						sensorReading.setSignallevel(jWiFiData.getLevel());
						sensorReading.setGpsLat(jData.getCurrentLat());
						sensorReading.setGpsLng(jData.getCurrentLng());
						sensorReading.setCreatedTime(new Timestamp(System.currentTimeMillis()));
						sensorReading.setAltitude(jWiFiData.getAltitude());
						if (p != null)
							sensorReading.setUserId(p.getUserId());
						if(area!=null)
							sensorReading.setSquareId(area.getSqaureId());
						else 
							sensorReading.setSquareId(-1);
						alienServicesLocal.addSensorReading(sensorReading);
					}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String jsonString = "";

		String requestType = request.getParameter("requestType");
		
//		System.out.println(requestType);
		
		BufferedReader in = new BufferedReader(new InputStreamReader(
		                request.getInputStream()));
		String line = in.readLine();
		while (line != null) {
			jsonString += line;
		    line = in.readLine();
		}
		
		//Parse Response into our object
        Type collectionType = new TypeToken<JData>() {
        }.getType();
        System.out.println("jsonstring: "+jsonString);
		if (jsonString != null && !jsonString.equals("")) {
			JData jData = new Gson().fromJson(jsonString, collectionType);
			jData.setRequestType(requestType);
			JData newJData = null;

			GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
			Point point = gmap2.fromLatLngToPoint(jData.getCurrentLat(), jData.getCurrentLng(), GoogleMapsProjection2.ZOOM);
			Area area = null;
			if(point.x!=0 && point.y!=0)
			     area = alienServicesLocal.findAreaByXY(point.x, point.y);
			
			if(ALIEN_SEARCH.equalsIgnoreCase(requestType)){
				//save sensor readings
				saveSensorReadings(jData, area);
				//search alien near the user loc
				newJData = searchAlienLocation(jData, area);
			} else if(ALIEN_SHOT.equalsIgnoreCase(requestType)){
				//move alien to new location and update user scores
				newJData = moveAlien(jData, area);
			} else if(ALIEN_HINTS.equalsIgnoreCase(requestType)){
				//return up to 3 near by aliens
				newJData = alienHints(jData, area);
			} else if(SENTINEL_SEARCH.equalsIgnoreCase(requestType)){
				saveSentinel(jData);
				newJData = searchAlienLocation(jData, area);
			}
			
			String jsonStringNewJData = new Gson().toJson(newJData);
			out.println(jsonStringNewJData);
		}
        
	}	
	
	private boolean isLocAtNJIT(double lat, double lng){
		double distance = distance(NJIT_LAT, NJIT_LNG, lat, lng, 'K');
//		System.out.println("distance from NJIT:" + distance);
		if(distance<1){//1 kilometers is 0.6 mile
			return true;
		} else {
			return false;
		}
	}
	
	
	public double distance(double lat1, double lon1, double lat2, double lon2,
			char unit) {
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2))
				* Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
		if (unit == 'K') {//'K' is kilometers (default)  
			dist = dist * 1.609344;
		} else if (unit == 'N') {//'N' is nautical miles
			dist = dist * 0.8684;
		}
		return (dist);
	}
	
	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	/* :: This function converts decimal degrees to radians : */
	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	private double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	/* :: This function converts radians to decimal degrees : */
	/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */
	private double rad2deg(double rad) {
		return (rad * 180.0 / Math.PI);
	}

}
