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
		
	     //执行SQL语句并获取结果集  
	
		Statement stmt=null; //创建声明
		try {
			stmt = sqlCon.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	String value[] = request.getParameterValues("checkbox");
		
	//判断checkbox内容提交是否为空
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
		      request.setAttribute("error", "该用户在任务期间，此时不可更改其角色！");
			   
	           request.setAttribute("name",username);
			   request.getRequestDispatcher("/assignPermission.jsp").forward(request, response);
				return;
		}
		
	String SQL="Update u_right set rol_id='1' where user_id=(select id from user where userName='"+username+"')";

	   
			try {
				stmt.execute(SQL);
				 //日志管理
				
				 sql="insert into log(content) values('"+"系统核心管理员为操作员"+username+"更改角色为管理员"+"')";
				    
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
				    
				    //日志管理
					
					 sql="insert into log(content) values('"+"系统核心管理员为用户"+username+"授予角色为管理员"+"')";
					    
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
			 request.setAttribute("error", "此为系统管理员，拒绝此次操作！");
			   request.getRequestDispatcher("/yhqxList.jsp").forward(request, response);
			   return;
		}
	
	String SQL="Update u_right set rol_id=2 where user_id=(select id from user where userName='"+username+"')";
			
			try {
				stmt.execute(SQL);
				
				 //日志管理
				
				 sql="insert into log(content) values('"+"系统核心管理员将管理员"+username+"更改角色为操作员"+"')";
				    
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
	 
	  
		 //日志管理
		
		 sql="insert into log(content) values('"+"系统管理员为用户"+username+"授予角色为操作员"+"')";
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
			 request.setAttribute("error", "无权限撤销系统管理员！");
			   request.getRequestDispatcher("/yhqxList.jsp").forward(request, response);
			   return;
		}
		else if(flag||sign){
			  
			   if(userDao.iswill(con,username)==false){   
			   request.setAttribute("error", "该用户未完成任务，此时不可更改其用户权限");
			   
	           request.setAttribute("name",username);
			   request.getRequestDispatcher("/assignPermission.jsp").forward(request, response);
				return;
			   }
		   
				String SQL="delete from u_right where user_id=(select id from user where userName='"+username+"')";
				 //日志管理
				
				 sql="insert into log(content) values('"+"系统管理员将用户"+username+"贬为新用户"+"')";
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

