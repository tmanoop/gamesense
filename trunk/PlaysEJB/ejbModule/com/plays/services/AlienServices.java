package com.plays.services;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.model.SensorReading;
import com.plays.model.User;

/**
 * Session Bean implementation class BankAdminServices
 */
@Stateless
public class AlienServices implements AlienServicesLocal {

	@EJB(name="com.plays.services.DataServices")
	DataServicesLocal dataServicesLocal;
    /**
     * Default constructor. 
     */
    public AlienServices() {
//    	dataServicesLocal = GameUtility.lookupEJB("java:global/Plays/PlaysEJB/DataServices!com.plays.services.DataServicesLocal");
    }

    @Override
    public List<Alien> allAliens(){
    	List<Alien> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("Alien.findAll");
    	pList = (List<Alien>) q.getResultList();
		return pList;
    }
    
    @Override
    public Alien findAlienByID(int ID){
    	Alien alien = null;
		try {

			alien = (Alien)dataServicesLocal.findEntity(Alien.class, new Integer(ID));
			
			//dataServicesLocal.test();
						
		} catch (Exception e) {
			System.out.println("Alien not found.");
			e.printStackTrace();
		}
		
		if (alien==null) {
			System.out.println("Alien not found.");
		}
		return alien;
    }
    
    @Override
    public List<Alien> findAliensByShotCnt(){
		List<Alien> pList = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("Alien.findAliensByShotCnt").setParameter("shotCount", 2);
			
			pList = (List<Alien>) q.getResultList();
			
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return pList;
    }
    
    @Override
    public Alien add(Alien alien){
    	try {
			dataServicesLocal.persist(alien);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		return alien;
    	
    }
    
    @Override
    public boolean delete(int id) {
    	Alien a = findAlienByID(id);
    	try {
			dataServicesLocal.remove(a);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
    }

    @Override
    public void update(Alien alien){
    	try {
			dataServicesLocal.merge(alien);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

	@Override
	public List<Area> allAreas() {
    	List<Area> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("Area.findAll");
    	pList = (List<Area>) q.getResultList();
		return pList;
	}

	@Override
	public Area findAreaByID(int ID) {
		Area area = null;
		try {

			area = (Area)dataServicesLocal.findEntity(Area.class, new Integer(ID));
			
			//dataServicesLocal.test();
						
		} catch (Exception e) {
			System.out.println("Area not found.");
			e.printStackTrace();
		}
		
		if (area==null) {
			System.out.println("Area not found.");
		}
		return area;
	}
	
	@Override
    public Area findAreaByXY(double tileX, double tileY){
    	Area p = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("Area.findByXY").setParameter("tileX", tileX).setParameter("tileY", tileY);
			
			p = (Area)q.getSingleResult();
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return p;
    }
	
	@Override
    public List<Area> findAreasByInd(String coveredInd){
		List<Area> pList = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("Area.findAreaByInd").setParameter("coveredInd", coveredInd);
			
			pList = (List<Area>) q.getResultList();
			
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return pList;
    }

	@Override
	public void updateArea(Area area) {
		try {
			dataServicesLocal.merge(area);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public SensorReading addSensorReading(SensorReading rv) {
		try {
			
			dataServicesLocal.merge(rv);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rv;
	}
	
	@Override
	public User updateUser(User p) {
		try {
			
			dataServicesLocal.merge(p);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}

	@Override
    public User findUser(String meid){
    	User p = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("User.loginCheck").setParameter("meid", meid);
			
			p = (User)q.getSingleResult();
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return p;
    }
}