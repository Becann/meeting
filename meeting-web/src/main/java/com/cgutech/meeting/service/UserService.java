package com.cgutech.meeting.service;

import java.util.List;

import com.cgutech.meeting.entity.User;
import com.cgutech.meeting.utils.Page;

public interface UserService {
	public User getUser(String username);
	public String getPassword(String username);
	public void changePassword(String username,String password);
	public void createUser(User userEntity);
	public Page getUsersPage(String name,int currentPage,int pageNum);
	public List<User> getUsers(String name);
	public void deleteUser(int id);


}

