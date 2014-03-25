package com.plays.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.plays.json.JData;
import com.plays.json.JWiFiData;

/**
 * Servlet implementation class AlienServlet
 */
@WebServlet("/AlienServlet")
public class AlienServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String ALIEN_SEARCH = "alienSearch";
	private static final String ALIEN_SHOT = "alienShot";
	private static final String ALIEN_HINTS = "alienHints";
       
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
			saveSensorReadings();
			//search alien near the user loc
			searchAlien();
		} else if(ALIEN_SHOT.equalsIgnoreCase(requestType)){
			//move alien to new location and update user scores
			moveAlien();
		} else if(ALIEN_HINTS.equalsIgnoreCase(requestType)){
			//return up to 3 near by aliens
			searchAlien();
		}
	}

	private void moveAlien() {
		System.out.println("Alien shot and moved.");
		
	}

	private void searchAlien() {
		System.out.println("Searching Alien.");
		
	}

	private void saveSensorReadings() {
		System.out.println("Sensor readings saved.");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonString = "";

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
        JData jData = new Gson().fromJson(jsonString, collectionType);
        System.out.println(jData.getEmail()+", "+jData.getMeid()+", "+jData.getScore());
        
        List<JWiFiData> jWiFiDataList = jData.getjWiFiData();
        for(JWiFiData jWiFiData : jWiFiDataList){
        	System.out.println(jWiFiData.getBSSID()+", "+jWiFiData.getSSID());
        }
	}

}
