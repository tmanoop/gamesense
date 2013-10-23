package com.plays.services;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.plays.model.Alien;

/**
 * Session Bean implementation class DataServices
 */
@Stateless
@LocalBean
public class DataServices implements DataServicesLocal {

	@PersistenceContext(name = "PlaysEJB", unitName = "PlaysEJB")
	private EntityManager emTransaction;
    /**
     * Default constructor. 
     */
    public DataServices() {
        // TODO Auto-generated constructor stub
    }
    
	@Override
	public EntityManager getEM() {
		// TODO Auto-generated method stub
		return emTransaction;
	}

	@Override
	public <E extends Object> E findEntity(Class<E> entityType,
			Object primaryKey) {
		return emTransaction.find(entityType, primaryKey);
	}

	@Override
	public <T> T merge(T entity) {
		return getEM().merge(entity);
	}

	@Override
	public void persist(Object entity) {
		getEM().persist(entity);
	}

	@Override
	public void remove(Object entity) {
		getEM().remove(getEM().merge(entity));
		//getEM().refresh(entity);
	}

	@Override
	public void test() {
		try {
			Query q = emTransaction.createQuery("select e from Alien e");
			Alien p = (Alien) q.getSingleResult();
			System.out.println(p.getAlienId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
