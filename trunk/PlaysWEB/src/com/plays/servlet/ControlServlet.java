package com.plays.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.services.AlienServicesLocal;

/**
 * Servlet implementation class ControlServlet
 */
@WebServlet("/ControlServlet")
public class ControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB(name="com.plays.services.AlienServices")
	AlienServicesLocal alienServicesLocal;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControlServlet() {
        super();
//        alienServicesLocal = GameUtility.lookupEJB("java:global/Plays/PlaysEJB/AlienSerices!com.plays.services.AlienServicesLocal");
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String test = request.getParameter("test");
		String action = request.getParameter("action");
		if(test.equals("alien")){
			if(action.equals("add")){
				Alien a = new Alien();
				a.setCurrentSquareId(0);
				a.setShotCount(0);
				int id = alienServicesLocal.add(a).getAlienId();
				out.println("<BR> Alien added!! " +id);
			} else if(action.equals("select")){
				List<Alien> aliensList = alienServicesLocal.allAliens();
				for(Alien a : aliensList){
					out.println(a.getNextGpsLat()+","+a.getNextGpsLng());
				}
			}
			out.println("<BR> Test Success!!");
		}
		if(test.equals("area")){
			if(action.equals("select")){
				List<Area> areasList = alienServicesLocal.allAreas();
				for(Area a : areasList){
					out.println(a.getTileX()+","+a.getTileY());
				}
			}
			out.println("<BR> Test Success!!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String submit = request.getParameter("submit");
		System.out.println("submit: "+submit);
		if(submit!=null && submit.equals("Shoot the alien")){
			//get alien ID
			String alienId = request.getParameter("alienId");
			if(alienId!=null){
				int nextSquareId = 0;
				double nextGpsLat = 0;
				double nextGpsLng = 0;
				//call alien movement algorithm to move alien
				//testing
				//get alien
				Alien alien = alienServicesLocal.findAlienByID(Integer.parseInt(alienId.trim()));
				int shotCount = 0;//a.getShotCount()
				int currentSquare = alien.getCurrentSquareId();
				if(shotCount < 2){
					//update square ID and next square lat lng and shot count
					nextSquareId = 4;
					nextGpsLat = 40.744601;//originial 40.744601,-74.179771
					nextGpsLng = -74.179771;//new 40.744459, -74.179766
//					nextGpsLat = 40.744459;
//					nextGpsLng = -74.179766;
				}
				//if shotCount is 2 then the alien is killed now with the current shot. 
				//Then the alien sqaure and next lat lng are marked zeros. 
				alien.setCurrentSquareId(nextSquareId);
				alien.setNextGpsLat(nextGpsLat);
				alien.setNextGpsLng(nextGpsLng);
				alien.setShotCount(0);//shotCount++
				alienServicesLocal.update(alien);

				//update the square cov ind
				Area area = alienServicesLocal.findAreaByID(currentSquare);
				area.setCoveredInd("Y");
				alienServicesLocal.updateArea(area);
				
				System.out.println("aliendId: "+alienId);
				response.sendRedirect("pages/GameStatus.jsp");
			}
		} else if(submit!=null && submit.equals("Load Tile Coordinates")){
			String myJsonTiles = request.getParameter("myJsonTilesValue");
			System.out.println("myJsonTiles: "+myJsonTiles);
			JsonElement jelement = new JsonParser().parse(myJsonTiles);
			JsonArray jarray = jelement.getAsJsonArray();
			JsonObject jobject = jarray.get(0).getAsJsonObject();			
			String squareId = jobject.get("squareId").toString();
			JsonObject jobject1 = jobject.getAsJsonObject("latLng");
			String lat = jobject1.get("lb").toString();
			String lng = jobject1.get("mb").toString();
			
			System.out.println("jobject: "+jobject);
			out.println("<BR> All Tile coordinates are updated!!");
		} else {
			out.println("<BR> Test Success!!");
		}
	}

}
