package com.cgutech.meeting.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.xml.crypto.Data;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cgutech.meeting.Dao.UserDao;
import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.service.UserService;
import com.cgutech.meeting.utils.Page;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private Logger log= LoggerFactory.getLogger(UserServiceImpl.class);
	@Override
	public User getUser(String username) {
		
		return userDao.getUser(username);
	}
	@Override
	public String getPassword(String username) {
		if(userDao.getUser(username)==null){
			return "";
		}
		return userDao.getUser(username).getPswd();
	}
	@Override
	public void changePassword(String username, String password) {
		userDao.changePassword(username, password);
		
	}
	@Override
	public void createUser(User userEntity) {
		    userEntity.setRoleUuid(UUID.randomUUID().toString().substring(0, 8));
		    userEntity.setCtime(sf.format(new Date()));
			userDao.addUser(userEntity);
	}
	@Override
	public Page getUsersPage(String name, int currentPage, int pageNum) {
		//System.out.println(pageNum);
		int count=userDao.countUser();
		Page page = new Page(currentPage, count, pageNum);
		page.setTotalnum(count);
		int offset = (currentPage - 1) * pageNum;
		List<User> pageconfig =userDao.getUsers(name,offset, pageNum);
		if(pageconfig!=null){
			for (User user : pageconfig) {
				if(user.getCtime()!=null&&user.getCtime().endsWith(".0")){
					user.setCtime(user.getCtime().substring(0,user.getCtime().length()-2));
				}
			}	
		}
		page.setList(pageconfig);
		return page;
		
	}
	@Override
	public void deleteUser(int id) {
		userDao.deleteUser(id);
	}
	@Override
	public List<User> getUsers(String name) {
		// TODO Auto-generated method stub
		List<User> users = userDao.getUsers(name,0, 0);
		if(users!=null){
			for (User user : users) {
				if(user.getCtime()!=null&&user.getCtime().endsWith(".0")){
					user.setCtime(user.getCtime().substring(0,user.getCtime().length()-2));
				}
				
			}
		}
		
		return users;
	}

}

