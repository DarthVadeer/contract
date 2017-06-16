package com.ruanko.model;

/**
 * ∫œÕ¨Model¿‡
 */
public class Contract {
	private String num;
	private String contractname;
	private String username;
	private String customername;
	private String content;
	private String beginTime;
	private String endTime;
	private String id;
	
	public Contract(){
		super();
	}
	
	public Contract(String username,String contractname,String customername,String beginTime,String endTime,String content){
		super();
		this.username=username;
		this.contractname=contractname;
		this.customername=customername;
		this.beginTime=beginTime;
		this.endTime=endTime;
		this.content=content;
	}
	public Contract(String contractid,String content){
		this.id=contractid;
		this.content=content;
		
	}
	public String getID(){
		return id;
	}
	public void setNum(String num){
		this.num=num;
	}
	
	public String getNum(){
		return num;
	}
	
	public void setName(String name){
		this.contractname=name;
	}
	
	public String getName(){
		return contractname;
	}
	
	public void setUsername(String name){
		this.username=name;
	} 
	
	public String getUsername(){
		return username;
	}
	
	public void setCustomer(String customer){
		this.customername=customer;
	}
	
	public String getCustomer(){
		return customername;
	}
	
	public void setContent(String content){
		this.content=content;
	}
	
	public String getContent(){
		return content;
	}
	
	public void setBeginTime(String beginTime){
		this.beginTime=beginTime;
	}
	
	public String getBeginTime(){
		return beginTime;
	}
	
	public void setEndTime(String endTime){
		this.endTime=endTime;
	}
	
	public String getEndTime(){
		return endTime;
	}
	}
