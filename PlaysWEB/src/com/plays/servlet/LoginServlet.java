package com.plays.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plays.model.User;
import com.plays.services.LoginServicesLocal;
import com.plays.util.Emailer;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String REGISTRATION = "registration";
	private static final String ACCESS = "access";
	private static final String NO = "N";
	private static final String YES = "Y";
       
	@EJB(name="com.plays.services.LoginServices")
	LoginServicesLocal loginServicesLocal;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//on sign-in, send consent form to user email ID
		String emailId = request.getParameter("emailId");
		String meid = request.getParameter("meid");
		String requestType = request.getParameter("requestType");
		System.out.println("registration");
		User p = loginServicesLocal.loginCheck(meid);
		if(REGISTRATION.equalsIgnoreCase(requestType)){
			if(p == null){
				p = new User();
				p.setUserEmail(emailId);
				p.setUserMeid(meid);
				loginServicesLocal.register(p);
				
				emailToAdmin(emailId, meid);
				//email consent form to user
				emailToPlayer(emailId);
				out.println(NO);
			} else {
				String access = (p.getUserAccess() == null || p.getUserAccess().equalsIgnoreCase(NO)) ? NO : YES;
					System.out.println(access);
				out.println(access);
			}
		} else if(ACCESS.equalsIgnoreCase("access")){
			if(p != null){
				p.setUserAccess(YES);
				loginServicesLocal.register(p);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	private void emailToAdmin(String emailId, String meid) {
		String body = "User Details:" +
						"\n\n Email Address: "+emailId +
						"\n\n Meid: "+meid;
		Emailer.sendEmail(Emailer.SENDER, "mt57@njit.edu", "New Player registered", body);
	}
	
	private void emailToPlayer(String emailId) {
		String body = "Hello," +
						"\n\n Thanks for installing the Monster Vs. NJIT game." +
						"\n\n Below are the game registration steps:" +
						"\n\n\t 1. Please completely fill the attached consent form and sign it." +
						"\n\n\t 2. Please scan the signed consent form and email the scanned copy to \"mt57@njit.edu\"." +
						"\n\n After completing the registration steps, you will recieve another confirmation email to access the game." +
						"\n\n " +
						"\n\n Regards," +
						"\n\n Game Administrator" +
						"\n\n mt57@njit.edu";
		Emailer.sendEmailWithAttachment(Emailer.SENDER, emailId, "Monster Vs. NJIT game registration details", body);
	}

}