package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ruanko.model.Customer;

public class CustomerDao {
	
	/**
	 * 添加客户
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public void addCustomer(Connection con,Customer customer)throws Exception{
		Statement stmt=null;
		 stmt = con.createStatement();
		 String SQL="INSERT INTO customer(mailbox,name,address,tel,fax,code,bank,account) VALUES('"+customer.getMailbox()+"','"
		    		+customer.getName()+"','"+customer.getAddress()+"','"+customer.getTel()+"','"+customer.getFax()+"','"+
		    		customer.getCode()+"','"+customer.getBank()+"','"+customer.getAccount()+"')";
		    stmt.execute(SQL);
		    
		  //日志管理
			  SQL="insert into log(content) values('"+"系统管理员添加新客户"+customer.getName()+"')";
			    stmt.execute(SQL);
	}
	/**
	 * 判断客户是否存在
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public boolean isExistcustomer(Connection con,String customer){
		
		String sql="select * from customer where name='"+customer+"'";
		PreparedStatement pstmt=null;
		try {
			pstmt = con.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ResultSet rs;
		try {
			rs = pstmt.executeQuery();
			if(rs.next()){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
return false;
}
	/**
	 * 修改客户信息
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */	
public void modifyCustomer(Connection con,Customer customer)throws Exception{
		Statement stmt=null;
		 stmt = con.createStatement();
		 //删除原数据
		 String SQL="delete from customer where id='"+customer.getId()+"'";
		 stmt.execute(SQL);
		 
		 
		 
		 SQL="INSERT INTO customer(mailbox,name,address,tel,fax,code,bank,account) VALUES('"+customer.getMailbox()+"','"
		    		+customer.getName()+"','"+customer.getAddress()+"','"+customer.getTel()+"','"+customer.getFax()+"','"+
		    		customer.getCode()+"','"+customer.getBank()+"','"+customer.getAccount()+"')";
		 
		    stmt.execute(SQL);
		    
		  //日志管理
	
			  SQL="insert into log(content) values('"+"系统管理员修改了客户"+customer.getName()+"的信息"+"')";
			    stmt.execute(SQL);
	}
	
/**
 * 删除客户
 * @param con
 * @param user
 * @return
 * @throws Exception
 */
public void deleteCustomer(Connection con,String customername) throws Exception{

	
	Statement stmt=null; //创建声明
    stmt = con.createStatement();

	String SQL="delete from customer where name='"+customername+"'";
       stmt.execute(SQL);
       
     //日志管理
	
		  SQL="insert into log(content) values('"+"系统管理员删除客户"+customername+"的记录信息"+"')";
		    stmt.execute(SQL);
		
	}
}
