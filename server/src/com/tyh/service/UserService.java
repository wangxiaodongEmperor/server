package com.tyh.service;


import com.tyh.entity.User;

public interface  UserService {
	User getUser(String username);
	boolean insertUser(User user);
	boolean updateUser(User user);
	boolean getCount(String username);
	boolean getId_cardCount(User user);
	boolean getPhoneCount(User user);
	boolean getNick_nameCount(User user);
	/*
		int getId_cardCount(User user);
	int getPhoneCount(User user);
	int getNick_nameCount(User user);*/
	
	
	
}
