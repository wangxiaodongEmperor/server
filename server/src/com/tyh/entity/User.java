package com.tyh.entity;

import java.util.Date;

public class User {
	/*
	 *   user_id VARCHAR (100),
   user_name VARCHAR (100),
   id_card VARCHAR (100),
   phone VARCHAR (100),
   password VARCHAR (100),
   nick_name VARCHAR (100),
   gesture_password VARCHAR (100),
   gesturepassword_flag VARCHAR (100),
	 * */
    private String user_id;//客户唯一标识
    private String user_name;
    private String id_card;
    private String phone;
    private String password;
    private String nick_name;
    private String gesture_password;
    private String gesturepassword_flag;//true    false
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public String getGesture_password() {
		return gesture_password;
	}
	public void setGesture_password(String gesture_password) {
		this.gesture_password = gesture_password;
	}
	public String getGesturepassword_flag() {
		return gesturepassword_flag;
	}
	public void setGesturepassword_flag(String gesturepassword_flag) {
		this.gesturepassword_flag = gesturepassword_flag;
	}
	
    
}