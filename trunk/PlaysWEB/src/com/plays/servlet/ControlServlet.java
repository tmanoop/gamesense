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

import com.plays.model.Alien;
import com.plays.services.AlienServicesLocal;
import com.plays.util.GameUtility;

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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
