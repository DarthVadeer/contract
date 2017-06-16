package com.ruanko.model;

public class Customer {
	private int id;
	private String mailbox;
	private String name;
	private String address;
	private String tel;
	private String fax;
	private String code;
	private String bank;
	private String account;
	
	public Customer(){
		super();
	}
	
	public Customer(String mailbox,String name,String address,String tel,String fax,
			String code,String bank,String account){
		super();
		this.mailbox=mailbox;
		this.name=name;
		this.address=address;
		this.tel=tel;
		this.fax=fax;
		this.code=code;
		this.bank=bank;
		this.account=account;
	
	}
	
	public Customer(int id,String mailbox,String name,String address,String tel,String fax,
			String code,String bank,String account){
		super();
		this.mailbox=mailbox;
		this.name=name;
		this.address=address;
		this.tel=tel;
		this.fax=fax;
		this.code=code;
		this.bank=bank;
		this.account=account;
	    this.id=id;
	}
	
	public void setId(int id){
		this.id=id;
	}
	
	public int getId(){
		return id;
	}
	
	public void setmailbox(String mailbox){
		this.mailbox=mailbox;
	}
	
	public String getMailbox(){
		return mailbox;
	}
	
	public void setNmae(String name){
		this.name=name;
	}
	
	public String getName(){
		return name;
	}

	public void setAddress(String address){
		this.address=address;
	}
	
	public String getAddress(){
		return address;
	}
	
	public void setTel(String tel){
		this.tel=tel;
	}
	
	public String getTel(){
		return tel;
	}
	
	public void setFax(String fax){
		this.fax=fax;
	}
	
	public String getFax(){
		return fax;
	}
	
	public void setCode(String code){
		this.code=code;
	}
	
	public String getCode(){
		return code;
	}
	
	public void setBank(String bank){
		this.bank=bank;
	}
	
	public String getBank(){
		return bank;
	}
	
	public void setAccount(String account){
		this.account=account;
	}
	
	public String getAccount(){
		return account;
	}
}
