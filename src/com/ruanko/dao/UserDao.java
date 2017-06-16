package com.ruanko.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ruanko.model.User;


public class UserDao {

	/**
	 * ��¼��֤
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
		Statement stmt=null; //��������
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
		//��־����
		
		String SQL="insert into log(content) values('"+"�û�"+user.getUserName()+"��¼"+"')";
	    stmt.execute(SQL);

		return sign;
	}
	/**
	 * �޸��û�֮�ж��û��Ƿ���������������������޸Ķ���
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
		 //֮ǰ�ǽ���������password�����ˣ����޸ģ�
			
			pstmt.setString(1, user.getPassword());
			 rs=pstmt.executeQuery();
			if(rs.next()){
				int id=rs.getInt("id");
				  String SQL="update user set userName='"+user.getUserName()+"' where id='"+id+"'";
				    stmt.execute(SQL);
				    
				    //��־����
					
					 sql="insert into log(content) values('"+"ϵͳ����Ա�����û�"+user.getPassword()+"����Ϊ��"+user.getUserName()+"')";
					    
							stmt.execute(sql);	
					 
			}
		  

			}
			
	
		return resultUser;
	}
	/**
	 * ɾ���û�
	 * @param con
	 * @param user
	 * @return
	 * @throws Exception
	 */
public void deleteuser(Connection con,User user) throws Exception{
		
		Statement stmt=null; //��������
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
			    
			//��־����
				
				String SQL="insert into log(content) values('"+"����Աɾ���û�"+user.getUserName()+"')";
			    stmt.execute(SQL);
			    
			    
		}
	}
	
	
	/**
	 * ע����֤
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
			
			//��־����
			Statement stmt=null; //��������
		    stmt = con.createStatement();
			 String SQL="insert into log(content) values('"+"���û�"+user.getUserName()+"ע��ʧ��"+"')";
			    stmt.execute(SQL);
		}
		else
			//����һ������
		{
		Statement stmt=null; //��������
	    stmt = con.createStatement();
	   
	    String SQL="INSERT INTO user(userName,password) VALUES('"+user.getUserName()+"','"+user.getPassword()+"')";
	    stmt.execute(SQL);
	    
		//��־����
	
	 SQL="insert into log(content) values('"+"���û�"+user.getUserName()+"ע��"+"')";
	    stmt.execute(SQL);
	    
	    resultUser=null;
		}
	
		
		
		return resultUser;
	}
//�Ƿ���Ը��Ľ�ɫ
	public boolean iswill(Connection con,String username){
		
    //�ж��Ƿ��ѷ�������
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
			
	//�ж��Ƿ�����ݺ�ͬ(���ڽ�ɫΪ����Աǰ����)	
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
	

