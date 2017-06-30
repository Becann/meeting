package com.cgutech.meeting.Dao;

import java.util.List;

import com.cgutech.meeting.entity.User;


public interface UserDao {
	public User getUser(String username);
	public void changePassword(String username,String password);
	public void addUser(User userEntity);
	public List<User> getUsers(String username,int offset,int limit);
	public int countUser();
	public int countFile();
	public void deleteUser(int id);
	
}

