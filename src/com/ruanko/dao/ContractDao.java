package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.ruanko.model.Contract;
import com.ruanko.model.User;

public class ContractDao {
	
	/**
	 * 符合要求的时候，直接把数据存入数据库
	 */
	public static void drftContract(Connection con,Contract contract)throws Exception{
		
		Statement stmt=null; //创建声明
		Statement stmt_1=null; //创建声明
		String sql="select * from user where userName='"+contract.getUsername()+"'";
		PreparedStatement pstmt=con.prepareStatement(sql);
		int id=0;
		 int user_id=0;
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
        user_id=rs.getInt(1);
		}
		String u_id=Integer.toString(user_id);
		//合同表里最大id
		sql=" select id from contract group by id order by id desc limit 1";
        pstmt=con.prepareStatement(sql);
	    rs=pstmt.executeQuery();
	    if(rs.next()){
			 id=rs.getInt("id");
		}
 	   
	    String c_id=Integer.toString(id);
		//创建合同编号(合同开头+用户id+合同未用id)
		String contract_num="Contract_"+u_id+"_"+c_id;
		
	    stmt = con.createStatement();
	    String SQL="INSERT INTO contract(user_id,num,con_name,cus_name,content,beginTime,endTime) VALUES('"+user_id+"','"+contract_num+"','"+contract.getName()+"','"
	    	+contract.getCustomer()+"','"+contract.getContent()+"','"+contract.getBeginTime()+"','"+contract.getEndTime()+"')";
	    
	    stmt.execute(SQL);
	    
	    //更新合同状态
	    sql=" select id from contract where num='"+contract_num+"'";
        pstmt=con.prepareStatement(sql);
	    rs=pstmt.executeQuery();
	      if(rs.next()){
 	    id=rs.getInt("id");
	      }
	    	  
 	   stmt_1 =con.createStatement();

	    SQL="Insert into contract_state(con_id,type,time) values('"+id+"',1,'"+contract.getBeginTime()+"')";
	    
	    stmt_1.execute(SQL);
	    
	    
	  //日志管理
		
		 SQL="insert into log(content) values('"+"操作员 "+contract.getUsername()+"起草新合同"+contract.getName()+"')";
		    stmt.execute(SQL);
	    
	    
	}
	
	public static boolean finalizeContract(Connection con,Contract contract) throws Exception{
		//获取合同id
		String ID=contract.getID();
		//获取合同内容
		String content=contract.getContent();
		Statement stmt=null; //创建声明
        //更新合同
		String sql="update contract set content='"+content+"' where id='"+ID+"'";
	    stmt = con.createStatement();

	    stmt.execute(sql);
	    //更改合同状态
	    sql="update contract_state set type=4 where con_id='"+ID+"'";
	    stmt = con.createStatement();

	    stmt.execute(sql);
	    
	  //日志管理
	
		 String SQL="insert into log(content) values('"+"合同ID为"+contract.getID()+"已定稿"+"')";
		    stmt.execute(SQL);
	    
	    
	    
	    return true;
		
	}
}