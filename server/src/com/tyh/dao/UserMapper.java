package com.tyh.dao;

import java.util.List;

import com.tyh.entity.User;

public interface UserMapper {
	List<User> listAllUser();
	
	User getUser(String username);
	
	int getCount(String username);
	
	int insertUser(User user);
	
	int updateUser(User user);
	
	int getId_cardCount(User user);
	int getPhoneCount(User user);
	int getNick_nameCount(User user);
}