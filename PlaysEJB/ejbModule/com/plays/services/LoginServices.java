package com.plays.services;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import com.plays.model.User;

/**
 * Session Bean implementation class LoginServices
 */
@Stateless
public class LoginServices implements LoginServicesLocal {

	@EJB(name="com.plays.services.DataServices")
	DataServicesLocal dataServicesLocal;
    /**
     * Default constructor. 
     */
    public LoginServices() {
    	
    }

    @Override
    public User loginCheck(String meid){
    	User p = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("User.loginCheck").setParameter("meid", meid);
			
			p = (User)q.getSingleResult();
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return p;
    }

	@Override
	public User register(User p) {
		try {
			
			dataServicesLocal.merge(p);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}
    
}
