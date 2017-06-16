package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ruanko.model.User;


public class UserDao {

	/**
	 * 登录验证
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User login(Connection con,User user) throws Exception{
		User resultUser=null;
		String sql="select * from user where userName=? and password=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, user.getUserName());
		pstmt.setString(2, user.getPassword());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			resultUser=new User();
			resultUser.setUserName(rs.getString("userName"));
			resultUser.setPassword(rs.getString("password"));
		}
		return resultUser;
	}
	public int check(Connection con,User user) throws Exception{
		int sign=0;
		Statement stmt=null; //创建声明
	    stmt = con.createStatement();
		String sql="select * from u_right where user_id=(select id from user where userName=? and password=?)";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, user.getUserName());
		pstmt.setString(2, user.getPassword());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			
			if(rs.getString(2).equals("1"))
				sign=1;
			else
				sign=2;
		}
		//日志管理
		
		String SQL="insert into log(content) values('"+"用户"+user.getUserName()+"登录"+"')";
	    stmt.execute(SQL);

		return sign;
	}
	/**
	 * 修改用户之判断用户是否重名，若非重名则完成修改动作
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User duplicate(Connection con,User user) throws Exception{
		
		User resultUser=null;
		
		String sql="select id from user where userName=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		
	
		
		pstmt.setString(1, user.getUserName());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			resultUser=new User();
			resultUser.setId(rs.getInt("id"));
		}
		else{
			Statement stmt=null; 
		    stmt = con.createStatement();
		 sql="select id from user where userName=?";
		 pstmt=con.prepareStatement(sql);
		 //之前是将旧名放在password里面了（待修改）
			
			pstmt.setString(1, user.getPassword());
			 rs=pstmt.executeQuery();
			if(rs.next()){
				int id=rs.getInt("id");
				  String SQL="update user set userName='"+user.getUserName()+"' where id='"+id+"'";
				    stmt.execute(SQL);
				    
				    //日志管理
					
					 sql="insert into log(content) values('"+"系统管理员更改用户"+user.getPassword()+"名称为："+user.getUserName()+"')";
					    
							stmt.execute(sql);	
					 
			}
		  

			}
			
	
		return resultUser;
	}
	/**
	 * 删除用户
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
public void deleteuser(Connection con,User user) throws Exception{
		
		Statement stmt=null; //创建声明
	    stmt = con.createStatement();
		String sql="select id from user where userName=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, user.getUserName());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			
			sql="select * from u_right where user_id='"+rs.getInt("id")+"'";
			pstmt=con.prepareStatement(sql);
			ResultSet rs_1=pstmt.executeQuery();
			if(rs_1.next()){

			    String SQL="delete from u_right where user_id='"+rs_1.getInt("user_id")+"'";
			    stmt.execute(SQL);
		
			    
			}
			   String SQL_1="delete from user where userName='"+user.getUserName()+"'";
			    stmt.execute(SQL_1);
			    
			//日志管理
				
				String SQL="insert into log(content) values('"+"管理员删除用户"+user.getUserName()+"')";
			    stmt.execute(SQL);
			    
			    
		}
	}
	
	
	/**
	 * 注册验证
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public User register(Connection con,User user) throws Exception{
        
		User resultUser=null;
		String sql="select * from user where userName=?";
		PreparedStatement pstmt=con.prepareStatement(sql);
		pstmt.setString(1, user.getUserName());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			
			resultUser=new User();
			resultUser.setUserName(rs.getString("userName"));
			resultUser.setPassword(rs.getString("password"));
			
			//日志管理
			Statement stmt=null; //创建声明
		    stmt = con.createStatement();
			 String SQL="insert into log(content) values('"+"新用户"+user.getUserName()+"注册失败"+"')";
			    stmt.execute(SQL);
		}
		else
			//新增一条数据
		{
		Statement stmt=null; //创建声明
	    stmt = con.createStatement();
	   
	    String SQL="INSERT INTO user(userName,password) VALUES('"+user.getUserName()+"','"+user.getPassword()+"')";
	    stmt.execute(SQL);
	    
		//日志管理
	
	 SQL="insert into log(content) values('"+"新用户"+user.getUserName()+"注册"+"')";
	    stmt.execute(SQL);
	    
	    resultUser=null;
		}
	
		
		
		return resultUser;
	}
//是否可以更改角色
	public boolean iswill(Connection con,String username){
		
    //判断是否已分配任务
	String sql="select * from contract_process where user_id =(select id from user where userName='"+username+"')";

		PreparedStatement pstmt=null;
		
			try {
				pstmt = con.prepareStatement(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
		ResultSet rs=null;
		
			try {
				rs = pstmt.executeQuery();
				if(rs.next()){
					
					return false;
				}
		
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	//判断是否已起草合同(即在角色为操作员前提下)	
		sql="select * from contract where user_id =(select id from user where userName='"+username+"')";
		 
			try {
				pstmt=con.prepareStatement(sql);
				ResultSet rs_1=null;
				
				rs_1 = pstmt.executeQuery();
				if(rs_1.next()){
				return false;
		
		}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	
			return true;
	}
}
	

