package com.plays.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
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

	private JData moveAlien(JData jData) {
		System.out.println("Alien shot and moved.");

		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
		Point point = gmap2.fromLatLngToPoint(jData.getCurrentLat(), jData.getCurrentLng(), GoogleMapsProjection2.ZOOM);
		Area area = alienServicesLocal.findAreaByXY(point.x, point.y);
		if(area!=null){
			if(area.getCoveredInd() == null || area.getCoveredInd().equalsIgnoreCase("N")) {
				area.setCoveredInd("Y");
				alienServicesLocal.updateArea(area);
			}

			if(area.getAlien()!=null){
				Alien alien = area.getAlien();
				alien.setShotCount(alien.getShotCount()+1);
				Area nearestSquare = gameStrategyServicesLocal.getNearestAvailableSquare(area);
				alien.setArea(nearestSquare);
				alienServicesLocal.update(alien);
				
				if(nearestSquare!=null){
					nearestSquare.setAlien(alien);
					alienServicesLocal.updateArea(nearestSquare);					
				}
				
				newJData.setCurrentLat(nearestSquare.getGpsLat());
				newJData.setCurrentLng(nearestSquare.getGpsLng());
			}
		}
		
		return newJData;
	}

	private JData alienHints(JData jData) {
		System.out.println("Searching Alien.");
		GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
		Point point = gmap2.fromLatLngToPoint(jData.getCurrentLat(), jData.getCurrentLng(), GoogleMapsProjection2.ZOOM);
		Area area = alienServicesLocal.findAreaByXY(point.x, point.y);
		
		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		if(area!=null){
			Area nearestSquare = gameStrategyServicesLocal.getNearestAvailableAlien(area);
			
			newJData.setCurrentLat(nearestSquare.getGpsLat());
			newJData.setCurrentLng(nearestSquare.getGpsLng());
		}
		return newJData;
	}

	private void saveSensorReadings(JData jData) {
		System.out.println("Sensor readings saved.");
		// System.out.println(jData.getEmail()+", "+jData.getMeid()+", "+jData.getScore());
					// System.out.println("Sensor readings saved.");
					User p = alienServicesLocal.findUser(jData.getMeid());
					if (p != null) {
						p.setUserEmail(jData.getEmail());
						p.setAliensKilled(jData.getBustedAliens());
						p.setBullets(jData.getCollectedPowerCount());
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
						if (p != null)
							sensorReading.setUserId(p.getUserId());
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
		
		System.out.println(requestType);
		
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

			if(ALIEN_SEARCH.equalsIgnoreCase(requestType)){
				//save sensor readings
				saveSensorReadings(jData);
				//search alien near the user loc
				newJData = searchAlienLocation(jData);
			} else if(ALIEN_SHOT.equalsIgnoreCase(requestType)){
				//move alien to new location and update user scores
				newJData = moveAlien(jData);
			} else if(ALIEN_HINTS.equalsIgnoreCase(requestType)){
				//return up to 3 near by aliens
				newJData = alienHints(jData);
			}
			
			String jsonStringNewJData = new Gson().toJson(newJData);
			out.println(jsonStringNewJData);
		}
        
	}

	private JData searchAlienLocation(JData jData) {
		JData newJData = new JData();
		newJData.setRequestType(jData.getRequestType());
		
		GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
		Point point = gmap2.fromLatLngToPoint(jData.getCurrentLat(), jData.getCurrentLng(), GoogleMapsProjection2.ZOOM);
		Area area = alienServicesLocal.findAreaByXY(point.x, point.y);
		if(area!=null){
			if(area.getCoveredInd() == null || area.getCoveredInd().equalsIgnoreCase("N")) {
				area.setCoveredInd("Y");
				alienServicesLocal.updateArea(area);
			}

			
			if(area.getAlien()!=null && area.getAlien().getShotCount() < 2){
				newJData.setCurrentLat(area.getGpsLat());
				newJData.setCurrentLng(area.getGpsLng());
			}
		}
		
		return newJData;
	}

}
