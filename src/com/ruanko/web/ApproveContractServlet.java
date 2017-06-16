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

public class ApproveContractServlet extends HttpServlet {
	DbUtil dbUtil=new DbUtil();
//	UserDao userDao=new UserDao();
	
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
		  String username=(String)request.getSession().getAttribute("USERname");
		  //合同ID
		  String contractid=(String)request.getSession().getAttribute("CONTRACTid");
		  //合同会签意见
	       String content=request.getParameter("content");
	       //合同审批通过与否
	       String[] values=request.getParameterValues("approve");
	       
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
		
		
		sql="update contract_process set content='"+content+"' where user_id='"+user_id+"' and con_id='"+contractid+"' and type=2";
		

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
	    
	 sql="update contract_process set state=1 where user_id='"+user_id+"' and con_id='"+contractid+"' and type=2";

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

		 //日志管理
		
		 sql="insert into log(content) values('"+"用户ID为"+user_id+"完成审批工作"+"')";
		    try {
				stmt.execute(sql);
			} catch (SQLException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		
	 //若审批人员本身为否定则将合同状态改为 type：0   若审批人员通过的话，则不动合同状态
	if(values!=null){
		 int size=values.length; 
			for(int i=0;i<size;i++){

		if("refuse".equals(values[i])){
		sql="update contract_state set type=0 where con_id='"+contractid+"'";
		
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
		
		}
			}
	}
	//判断合同状态type是否为0,若为0，则表示该合同已经被否定掉，立即返回，若不为0，则应当继续下去
	sql="select type from contract_state where con_id='"+contractid+"'";
	try {
		pstmt = sqlCon.prepareStatement(sql);
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	try {
		sqlRst= pstmt.executeQuery();
		if(sqlRst.next()){
			
			int number=sqlRst.getInt(1);
			if(number==0){
				//对该合同的流程进行清空
				
		         sql="delete from contract_process where con_id='"+contractid+"'";
			     stmt.execute(sql);
			//客户端跳转     
		response.sendRedirect("welcome.jsp");
				return;
			}
		}
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	
	//若之前没有人审批不通过且自身通过，则需判定是否所有人都审批完毕，并对合同状态改为待签订状态
	
		   sql="select count(id) as num from contract_process where type=2 and state=0 and con_id='"+contractid+"'";
		
			try {
				pstmt = sqlCon.prepareStatement(sql);
				sqlRst= pstmt.executeQuery();
				
				if(sqlRst.next()){
					
					int number=sqlRst.getInt(1);
					if(number==0){
						
						sql="update contract_state set type=5 where con_id='"+contractid+"'";
						
						stmt = sqlCon.createStatement();
						stmt.execute(sql);
						
					    
						  //日志管理
							
							 sql="insert into log(content) values('"+"合同ID为"+contractid+"完成审批"+"')";
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