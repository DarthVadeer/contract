package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.UserDao;
import com.ruanko.utils.DbUtil;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CPermissionServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	UserDao userDao=new UserDao();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  request.setCharacterEncoding("GBK");
		  response.setContentType("text/html;charset=GBK");

		Connection sqlCon=null;
		Connection con=null;
		ResultSet sqlRst=null;
		boolean flag;
		flag=true;
		boolean sign;
		sign=true;
		try {
			sqlCon=dbUtil.getCon();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String username=(String)request.getSession().getAttribute("UserName");
		 String sql="select * from u_right where user_id=(select id from user where userName='"+username+"')"; 
		try {
			PreparedStatement pstmt = sqlCon.prepareStatement(sql);
			sqlRst = pstmt.executeQuery();

			
			  if(sqlRst.next()){
			  	
			  if(sqlRst.getString(2).equals("1"))
			  {
			  flag=true;sign=false;
			  	}
			  else{
			  	flag=false;sign=true;
			  }
			  
			  }
			  else{
			  	flag=false;sign=false;
			  }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	     //ִ��SQL��䲢��ȡ�����  
	
		Statement stmt=null; //��������
		try {
			stmt = sqlCon.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	String value[] = request.getParameterValues("checkbox");
		
	//�ж�checkbox�����ύ�Ƿ�Ϊ��
	 if(value!=null){
	 int size=value.length; 
	for(int i=0;i<size;i++){

	if("1".equals(value[i])){
	if(sign) {
		
		try {
			con=dbUtil.getCon();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(userDao.iswill(con,username)==false){   
		      request.setAttribute("error", "���û��������ڼ䣬��ʱ���ɸ������ɫ��");
			   
	           request.setAttribute("name",username);
			   request.getRequestDispatcher("/assignPermission.jsp").forward(request, response);
				return;
		}
		
	String SQL="Update u_right set rol_id='1' where user_id=(select id from user where userName='"+username+"')";

	   
			try {
				stmt.execute(SQL);
				 //��־����
				
				 sql="insert into log(content) values('"+"ϵͳ���Ĺ���ԱΪ����Ա"+username+"���Ľ�ɫΪ����Ա"+"')";
				    
						stmt.execute(sql);
				
				 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	    }
	
	    else if(!flag&&!sign)
	    {
	     String SQL="select id from user where userName='"+username+"'";
	    
		try {
			 PreparedStatement pstmt_1= sqlCon.prepareStatement(SQL);
				sqlRst = pstmt_1.executeQuery();
				if(sqlRst.next()){
				      int id = sqlRst.getInt("id");
				     SQL="insert into u_right(rol_id,user_id) values(1,'"+id+"')";
				    stmt.execute(SQL);
				    
				    //��־����
					
					 sql="insert into log(content) values('"+"ϵͳ���Ĺ���ԱΪ�û�"+username+"�����ɫΪ����Ա"+"')";
					    
							stmt.execute(sql);
					
				    
			} 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	    }
	}

	if("2".equals(value[i]))
	{
		 
	if(flag) {
		
		if(username.equals("admin")){
			
			 request.setAttribute("name",username);
			 request.setAttribute("error", "��Ϊϵͳ����Ա���ܾ��˴β�����");
			   request.getRequestDispatcher("/yhqxList.jsp").forward(request, response);
			   return;
		}
	
	String SQL="Update u_right set rol_id=2 where user_id=(select id from user where userName='"+username+"')";
			
			try {
				stmt.execute(SQL);
				
				 //��־����
				
				 sql="insert into log(content) values('"+"ϵͳ���Ĺ���Ա������Ա"+username+"���Ľ�ɫΪ����Ա"+"')";
				    
						stmt.execute(sql);
				
				 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	    }
	    else if(!flag&&!sign)
	    {
	     String SQL="select id from user where userName='"+username+"'";
	  PreparedStatement pstmt_2;
	try {
		pstmt_2 = sqlCon.prepareStatement(SQL);
		sqlRst = pstmt_2.executeQuery(); 
		 
	    if(sqlRst.next()){
	   int id = sqlRst.getInt("id");
	  SQL="insert into u_right(rol_id,user_id) values(2,'"+id+"')";
	  stmt.execute(SQL);
	 
	  
		 //��־����
		
		 sql="insert into log(content) values('"+"ϵͳ����ԱΪ�û�"+username+"�����ɫΪ����Ա"+"')";
		    try {
				stmt.execute(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
	    }
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	  
	    }

	}
			}
	   }
	 else{
		   try {
			con=dbUtil.getCon();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(flag&&username.equals("admin")){
			
			 request.setAttribute("name",username);
			 request.setAttribute("error", "��Ȩ�޳���ϵͳ����Ա��");
			   request.getRequestDispatcher("/yhqxList.jsp").forward(request, response);
			   return;
		}
		else if(flag||sign){
			  
			   if(userDao.iswill(con,username)==false){   
			   request.setAttribute("error", "���û�δ������񣬴�ʱ���ɸ������û�Ȩ��");
			   
	           request.setAttribute("name",username);
			   request.getRequestDispatcher("/assignPermission.jsp").forward(request, response);
				return;
			   }
		   
				String SQL="delete from u_right where user_id=(select id from user where userName='"+username+"')";
				 //��־����
				
				 sql="insert into log(content) values('"+"ϵͳ����Ա���û�"+username+"��Ϊ���û�"+"')";
				    try {
						stmt.execute(sql);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				 
				try {
					stmt.execute(SQL);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
					
				
		   }
	   }

		response.sendRedirect("yhqxList.jsp");
	}
	
	
		}

