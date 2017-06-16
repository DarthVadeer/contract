package com.ruanko.model;

/**
 * ”√ªßModel¿‡
 * @author www.java1234.com
 *
 */
public class User {

	private int id;
	private String userName;
	private String oldusername;
	private String password;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String userName, String password) {
		super();
		this.userName = userName;
		this.password = password;
	}
	public User(String userName) {
		super();
		this.userName = userName;
	
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public String getOldUserName() {
		return oldusername;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public void setOldusername(String username) {
		this.oldusername = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
