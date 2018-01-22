package com.tyh.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tyh.dao.UserMapper;
import com.tyh.entity.User;
import com.tyh.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	private UserMapper userMapper;

	@Override
	public User getUser(String username) {
		User user=userMapper.getUser(username);
		return user;
	}

	@Override
	public boolean insertUser(User user) {
		boolean state=false;
		int a=userMapper.insertUser(user);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
		
		
	}

	@Override
	public boolean updateUser(User user) {
		boolean state=false;
		int a=userMapper.updateUser(user);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
	}

	@Override
	public boolean getCount(String username) {
		boolean state=false;
		int a=userMapper.getCount(username);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
	}

	@Override
	public boolean getId_cardCount(User user) {
		boolean state=false;
		int a=userMapper.getId_cardCount(user);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
	}

	@Override
	public boolean getPhoneCount(User user) {
		boolean state=false;
		int a=userMapper.getPhoneCount(user);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
	}

	@Override
	public boolean getNick_nameCount(User user) {
		boolean state=false;
		int a=userMapper.getNick_nameCount(user);
		if(a>0){//大于0成功
			state=true;
		}
		return state;
	}

	

	
}
