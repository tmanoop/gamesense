package com.plays.services;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.Query;

import com.plays.model.Alien;
import com.plays.model.Area;
import com.plays.model.McsenseReading;
import com.plays.model.SensorReading;
import com.plays.model.Sentinel;
import com.plays.model.User;
import com.plays.model.WiFiMap;

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
    public List<Sentinel> allSentinels(){
    	List<Sentinel> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("Sentinel.findAll");
    	pList = (List<Sentinel>) q.getResultList();
		return pList;
    }
    
    @Override
    public List<SensorReading> allSensorReadings(){
    	List<SensorReading> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.findAll");
    	pList = (List<SensorReading>) q.getResultList();
		return pList;
    }
    
    @Override
    public List<SensorReading> allSensorReadingsBetweenIDs(long start, long end){
    	List<SensorReading> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.findById").setParameter("start", start).setParameter("end", end);
    	pList = (List<SensorReading>) q.getResultList();
		return pList;
    }
    
    @Override
    public List<McsenseReading> allMcsenseReadingsBetweenIDs(long start, long end){
    	List<McsenseReading> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("McsenseReading.findById").setParameter("start", start).setParameter("end", end);
    	pList = (List<McsenseReading>) q.getResultList();
		return pList;
    }
    
    @Override
    public long allSensorReadingsCount(){
    	Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.count");
    	List<Long> count = (List<Long>) q.getResultList();
		return count.get(0);
    }
    
    @Override
    public List<SensorReading> allRecentReadings(){
    	List<SensorReading> pList = null;
    	Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.recent");
    	pList = (List<SensorReading>) q.getResultList();
		return pList;
    }
    
    @Override
    public List<WiFiMap> findNJITCovSquares(){
    	List<WiFiMap> wiFiMapList = new ArrayList<WiFiMap>();
    	
    	//Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.findNJITCovSquares");
    	
    	String sqlScript = "select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.SENSOR_READINGS " 
							+" where (SSID like ('%NJIT%') or SSID like ('%njit%')) "
								+" and square_id >= 0 "
								+" group by square_id "
								+" order by square_id ";
		Query q = dataServicesLocal.getEM().createNativeQuery(sqlScript);
//    	q.getResultList();
    	
    	List<Object[]> results = q.getResultList();
    	
    	for (Object[] result : results) {
    	    int squareId = (Integer) result[0];
    	    Area area = findAreaByID(squareId);
    	    int maxSignalLevel = ((Number) result[1]).intValue();
    	    WiFiMap wiFiMap = new WiFiMap();
    	    wiFiMap.setArea(area);
    	    wiFiMap.setMaxSignalLevel(maxSignalLevel);
    	    wiFiMapList.add(wiFiMap);
    	}
    	
		return wiFiMapList;
    }
    
    @Override
    public List<WiFiMap> findMcsenseNJITCovSquares(){
    	List<WiFiMap> wiFiMapList = new ArrayList<WiFiMap>();
    	
    	//Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.findNJITCovSquares");
    	
    	String sqlScript = "select square_id, max(SIGNALLEVEL) as avg_signal_level from APP.MCSENSE_READINGS " 
							+" where SSID = 'njit' "
								+" and square_id >= 0 "
								+" group by square_id "
								+" order by square_id ";
		Query q = dataServicesLocal.getEM().createNativeQuery(sqlScript);
//    	q.getResultList();
    	
    	List<Object[]> results = q.getResultList();
    	
    	for (Object[] result : results) {
    	    int squareId = (Integer) result[0];
    	    Area area = findAreaByID(squareId);
    	    int maxSignalLevel = ((Number) result[1]).intValue();
    	    WiFiMap wiFiMap = new WiFiMap();
    	    wiFiMap.setArea(area);
    	    wiFiMap.setMaxSignalLevel(maxSignalLevel);
    	    wiFiMapList.add(wiFiMap);
    	}
    	
		return wiFiMapList;
    }
    
    @Override
    public List<WiFiMap> findNoNJITCovSquares(){
    	List<WiFiMap> wiFiMapList = new ArrayList<WiFiMap>();
    	
//    	Query q = dataServicesLocal.getEM().createNamedQuery("SensorReading.findNoNJITCovSquares");
    	String sqlScript = "select square_id from APP.SENSOR_READINGS " 
								+" where square_id > 0 "
								+" group by square_id "
								+" EXCEPT "
								+" select square_id as avg_signal_level from APP.SENSOR_READINGS " 
								+" where (SSID like ('%NJIT%') or SSID like ('%njit%')) "
								+" 	and square_id >= 0 "
								+" 	group by square_id ";
    	Query q = dataServicesLocal.getEM().createNativeQuery(sqlScript);
    	
    	List<Integer> results = (List<Integer>)q.getResultList();
    	
    	for (Integer result : results) {
    	    Integer squareId = result;
    	    Area area = findAreaByID(squareId);
    	    WiFiMap wiFiMap = new WiFiMap();
    	    wiFiMap.setArea(area);
    	    wiFiMapList.add(wiFiMap);
    	}
    	
		return wiFiMapList;
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
    public Alien findAvailableAlienByShotCnt(int shotCount){
		List<Alien> pList = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("Alien.findAliensByShotCnt").setParameter("shotCount", shotCount);
			
			pList = (List<Alien>) q.getResultList();
			
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	if(pList.size()>0)
    	    return pList.get(0);
    	else
    		return null;
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
    		DecimalFormat df = new DecimalFormat("#");
    		tileX = Double.parseDouble(df.format(tileX));
    		tileY = Double.parseDouble(df.format(tileY));
//            System.out.println(tileX+"   "+tileY);
            
			Query q = dataServicesLocal.getEM().createNamedQuery("Area.findByXY").setParameter("tileX", tileX).setParameter("tileY", tileY);
			
			p = (Area)q.getSingleResult();
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return p;
    }
	
	@Override
    public Area findAreaByXYFloor(double tileX, double tileY, int floor){
    	Area p = null;
    	try {
    		DecimalFormat df = new DecimalFormat("#");
    		tileX = Double.parseDouble(df.format(tileX));
    		tileY = Double.parseDouble(df.format(tileY));
//            System.out.println(tileX+"   "+tileY);
            
			Query q = dataServicesLocal.getEM().createNamedQuery("Area.findByXYFloor").setParameter("tileX", tileX).setParameter("tileY", tileY).setParameter("floor", floor);;
			
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
	public McsenseReading addMcsenseReading(McsenseReading rv) {
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
	public Sentinel updateSentinel(Sentinel p) {
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
	
	@Override
    public Sentinel findSentinel(String meid){
		Sentinel p = null;
    	try {

			Query q = dataServicesLocal.getEM().createNamedQuery("Sentinel.findByMeid").setParameter("meid", meid);
			
			p = (Sentinel)q.getSingleResult();
						
		} catch (Exception e) {
//			System.out.println("Player not found.");
		}
    	return p;
    }
}