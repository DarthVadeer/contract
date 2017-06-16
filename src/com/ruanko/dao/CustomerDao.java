package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ruanko.model.Customer;

public class CustomerDao {
	
	/**
	 * ��ӿͻ�
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
		    
		  //��־����
			  SQL="insert into log(content) values('"+"ϵͳ����Ա����¿ͻ�"+customer.getName()+"')";
			    stmt.execute(SQL);
	}
	/**
	 * �жϿͻ��Ƿ����
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
	 * �޸Ŀͻ���Ϣ
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */	
public void modifyCustomer(Connection con,Customer customer)throws Exception{
		Statement stmt=null;
		 stmt = con.createStatement();
		 //ɾ��ԭ����
		 String SQL="delete from customer where id='"+customer.getId()+"'";
		 stmt.execute(SQL);
		 
		 
		 
		 SQL="INSERT INTO customer(mailbox,name,address,tel,fax,code,bank,account) VALUES('"+customer.getMailbox()+"','"
		    		+customer.getName()+"','"+customer.getAddress()+"','"+customer.getTel()+"','"+customer.getFax()+"','"+
		    		customer.getCode()+"','"+customer.getBank()+"','"+customer.getAccount()+"')";
		 
		    stmt.execute(SQL);
		    
		  //��־����
	
			  SQL="insert into log(content) values('"+"ϵͳ����Ա�޸��˿ͻ�"+customer.getName()+"����Ϣ"+"')";
			    stmt.execute(SQL);
	}
	
/**
 * ɾ���ͻ�
 * @param con
 * @param user
 * @return
 * @throws Exception
 */
public void deleteCustomer(Connection con,String customername) throws Exception{

	
	Statement stmt=null; //��������
    stmt = con.createStatement();

	String SQL="delete from customer where name='"+customername+"'";
       stmt.execute(SQL);
       
     //��־����
	
		  SQL="insert into log(content) values('"+"ϵͳ����Աɾ���ͻ�"+customername+"�ļ�¼��Ϣ"+"')";
		    stmt.execute(SQL);
		
	}
}
