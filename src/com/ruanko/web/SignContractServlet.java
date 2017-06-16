package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.UserDao;
import com.ruanko.utils.DbUtil;

public class SignContractServlet extends HttpServlet {
	DbUtil dbUtil=new DbUtil();
	//UserDao userDao=new UserDao();
	
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
		  //合同用户名字
		  String username=(String)request.getSession().getAttribute("USERNAME_1");
		  //合同ID
		  String contractid=(String)request.getSession().getAttribute("Contract_id");
		  //合同会签意见
	       String content=request.getParameter("content");
	       
	       Statement stmt=null; //创建声明
	       Connection sqlCon=null;
	       ResultSet sqlRst=null;
	       PreparedStatement pstmt=null;
	       int user_id=0;
	       try {
			sqlCon=dbUtil.getCon();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			String sql="select id from user where userName='"+username+"'";
	   
		try {
			pstmt = sqlCon.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	     //执行SQL语句并获取结果集  
	     try {
			sqlRst= pstmt.executeQuery();
			
			if(sqlRst.next()){
			
				user_id=sqlRst.getInt(1);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
		//签订人员完成签订信息录入
		sql="update contract_process set content='"+content+"' where user_id='"+user_id+"' and con_id='"+contractid+"' and type=3";
		

	    try {
			stmt = sqlCon.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    try {
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//签订人员完成签订工作
	 sql="update contract_process set state=1 where user_id='"+user_id+"' and con_id='"+contractid+"' and type=3";

	    try {
			stmt = sqlCon.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    try {
			stmt.execute(sql);
			
			 //日志管理
			
			 sql="insert into log(content) values('"+"操作员ID为"+user_id+"已完成合同ID为"+contractid+"的签订工作"+"')";
			    
					stmt.execute(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 //判断是否所有签订人员都已签订完毕
		   sql="select count(id) as num from contract_process where type=3 and state=0 and con_id='"+contractid+"'";
		
			try {
				pstmt = sqlCon.prepareStatement(sql);
				sqlRst= pstmt.executeQuery();
				
				if(sqlRst.next()){
					
					int number=sqlRst.getInt(1);
					//如果没有一个未完成签订
					if(number==0){
						sql="update contract_state set type=6 where con_id='"+contractid+"'";
						
						stmt = sqlCon.createStatement();
						stmt.execute(sql);
						
						 //日志管理
						
						 sql="insert into log(content) values('"+"合同ID为"+contractid+"已完成签订"+"')";
						    
								stmt.execute(sql);
								
						//对该合同的流程进行清空
								
	         sql="delete from contract_process where con_id='"+contractid+"'";
		     stmt.execute(sql);
						
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		
		
		response.sendRedirect("welcome.jsp");
		

	}
}
	       