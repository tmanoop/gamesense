package com.plays.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
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
import com.plays.services.GameStrategyServicesLocal;
import com.plays.util.GoogleMapsProjection2;
import com.plays.util.Point;

/**
 * Servlet implementation class ControlServlet
 */
@WebServlet("/ControlServlet")
public class ControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB(name="com.plays.services.AlienServices")
	AlienServicesLocal alienServicesLocal;
	@EJB(name="com.plays.services.GameStrategyServices")
	GameStrategyServicesLocal gameStrategyServicesLocal;
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
		String tileX = request.getParameter("tileX");
		String tileY = request.getParameter("tileY");
		if(test.equals("alien")){
			if(action.equals("add")){
				if(tileX!=null && tileY!=null){
					Alien a = new Alien();
					Area area = alienServicesLocal.findAreaByXY(Double.parseDouble(tileX), Double.parseDouble(tileY));
					a.setArea(area);
					a.setShotCount(0);
					int id = alienServicesLocal.add(a).getAlienId();
					out.println("<BR> Alien added!! " +id);
					area.setAlien(a);
					alienServicesLocal.updateArea(area);
				} else {
					Alien a = null;
					List<Area> areasList = alienServicesLocal.allAreas();
					for(Area area : areasList){
						if(area.getAlien()==null){
							System.out.println("area: "+area.getSqaureId());
							a = new Alien();
							a.setArea(area);
							a.setShotCount(0);
							int id = alienServicesLocal.add(a).getAlienId();
							out.println("<BR> Alien added!! " +id);
							area.setAlien(a);
							alienServicesLocal.updateArea(area);
							break;
						} 
					}	
					if(a==null){
						out.println("<BR> Square not available!! ");					
					}
				}
				
			} else if(action.equals("select")){
				List<Alien> aliensList = alienServicesLocal.allAliens();
				for(Alien a : aliensList){
					out.println(a.getAlienId());
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
				Area nextSquare = null;
				//call alien movement algorithm to move alien
				//testing
				//get alien
				Alien alien = alienServicesLocal.findAlienByID(Integer.parseInt(alienId.trim()));
				int shotCount = alien.getShotCount();//a.getShotCount()
				Area currentSquare = alien.getArea();
				int currentSquareId = alien.getSquareId();
				System.out.println("currentSquare: "+currentSquareId);
				if(shotCount < 2){
					//update square ID and next square lat lng and shot count
					List<Area> areasList = alienServicesLocal.allAreas();
					
					for(Area area : areasList){
						if(area.getCoveredInd().equalsIgnoreCase("N") && area.getAlien()==null){
							nextSquare = area;
							System.out.println("nextSquare: "+nextSquare.getSqaureId());
							int square = gameStrategyServicesLocal.getNearestAvailableSquare(1);
							System.out.println("nearest square: "+square);
							break;
						}
					}
				}
				//if shotCount is 2 then the alien is killed now with the current shot. 
				//Then the alien sqaure and next lat lng are marked zeros. 
				alien.setArea(nextSquare);
				alien.setShotCount(++shotCount);//shotCount++
				System.out.println("shotCount: "+alien.getShotCount()+" shotCountvar: "+shotCount);
				alienServicesLocal.update(alien);
				if(nextSquare!=null){
					nextSquare.setAlien(alien);
					alienServicesLocal.updateArea(nextSquare);					
				}

				//update the square cov ind
//				Area area = alienServicesLocal.findAreaByID(currentSquareId);
				currentSquare.setCoveredInd("Y");
				alienServicesLocal.updateArea(currentSquare);
				
				System.out.println("aliendId: "+alienId);
				response.sendRedirect("pages/GameStatus.jsp");
			}
		} else if(submit!=null && submit.equals("Load Tile Coordinates")){
//			String myJsonTiles = request.getParameter("myJsonTilesValue");
//			System.out.println("myJsonTiles: "+myJsonTiles);
//			JsonElement jelement = new JsonParser().parse(myJsonTiles);
//			JsonArray jarray = jelement.getAsJsonArray();
			List<Area> areaList1 = alienServicesLocal.allAreas();
	  		
			for(int i=0;i<areaList1.size();i++){
//				JsonObject jobject = areaList1.get(i).getAsJsonObject();			
//				String squareId = jobject.get("squareId").toString();
//				JsonObject jobject1 = jobject.getAsJsonObject("latLng");
//				String lat = jobject1.get("lb").toString();
//				String lng = jobject1.get("mb").toString();

				Area area = areaList1.get(i);
				
				Point point = new Point(area.getTileX(), area.getTileY());
				GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
		        Point point1 = gmap2.fromPointToLatLng(point,GoogleMapsProjection2.ZOOM);
				
				area.setGpsLat(point1.x);
				area.setGpsLng(point1.y);
				alienServicesLocal.updateArea(area);
			}
			
			out.println("<BR> All Tile coordinates are updated!!");
		} else {
			out.println("<BR> Test Success!!");
		}
	}

}
