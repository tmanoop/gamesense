package com.plays.services;
import javax.ejb.Local;

import com.plays.model.User;

@Local
public interface LoginServicesLocal {
	
	User loginCheck(String meid);

	User register(User p);

}
