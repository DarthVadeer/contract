package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.ruanko.model.Contract;
import com.ruanko.model.User;

public class ContractDao {
	
	/**
	 * ����Ҫ���ʱ��ֱ�Ӱ����ݴ������ݿ�
	 */
	public static void drftContract(Connection con,Contract contract)throws Exception{
		
		Statement stmt=null; //��������
		Statement stmt_1=null; //��������
		String sql="select * from user where userName='"+contract.getUsername()+"'";
		PreparedStatement pstmt=con.prepareStatement(sql);
		int id=0;
		 int user_id=0;
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
        user_id=rs.getInt(1);
		}
		String u_id=Integer.toString(user_id);
		//��ͬ�������id
		sql=" select id from contract group by id order by id desc limit 1";
        pstmt=con.prepareStatement(sql);
	    rs=pstmt.executeQuery();
	    if(rs.next()){
			 id=rs.getInt("id");
		}
 	   
	    String c_id=Integer.toString(id);
		//������ͬ���(��ͬ��ͷ+�û�id+��ͬδ��id)
		String contract_num="Contract_"+u_id+"_"+c_id;
		
	    stmt = con.createStatement();
	    String SQL="INSERT INTO contract(user_id,num,con_name,cus_name,content,beginTime,endTime) VALUES('"+user_id+"','"+contract_num+"','"+contract.getName()+"','"
	    	+contract.getCustomer()+"','"+contract.getContent()+"','"+contract.getBeginTime()+"','"+contract.getEndTime()+"')";
	    
	    stmt.execute(SQL);
	    
	    //���º�ͬ״̬
	    sql=" select id from contract where num='"+contract_num+"'";
        pstmt=con.prepareStatement(sql);
	    rs=pstmt.executeQuery();
	      if(rs.next()){
 	    id=rs.getInt("id");
	      }
	    	  
 	   stmt_1 =con.createStatement();

	    SQL="Insert into contract_state(con_id,type,time) values('"+id+"',1,'"+contract.getBeginTime()+"')";
	    
	    stmt_1.execute(SQL);
	    
	    
	  //��־����
		
		 SQL="insert into log(content) values('"+"����Ա "+contract.getUsername()+"����º�ͬ"+contract.getName()+"')";
		    stmt.execute(SQL);
	    
	    
	}
	
	public static boolean finalizeContract(Connection con,Contract contract) throws Exception{
		//��ȡ��ͬid
		String ID=contract.getID();
		//��ȡ��ͬ����
		String content=contract.getContent();
		Statement stmt=null; //��������
        //���º�ͬ
		String sql="update contract set content='"+content+"' where id='"+ID+"'";
	    stmt = con.createStatement();

	    stmt.execute(sql);
	    //���ĺ�ͬ״̬
	    sql="update contract_state set type=4 where con_id='"+ID+"'";
	    stmt = con.createStatement();

	    stmt.execute(sql);
	    
	  //��־����
	
		 String SQL="insert into log(content) values('"+"��ͬIDΪ"+contract.getID()+"�Ѷ���"+"')";
		    stmt.execute(SQL);
	    
	    
	    
	    return true;
		
	}
}