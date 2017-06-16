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

public class AssignContractServlet extends HttpServlet{
	
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
		  ResultSet sqlRst=null;
		  Statement stmt=null; //创建声明
		  String SQL=null;
		  String sql=null;
		  PreparedStatement pstmt =null;
           //获得合同id
			String Contract_id=(String)request.getSession().getAttribute("CONTRACTID_1");
		
	     System.out.println(Contract_id);
			try {
				sqlCon=dbUtil.getCon();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			//获取多选列表里已分配用户的名字： hqht: 会签人员   spht:审批人员   qdht: 签订人员 	
			
			/*得到会签人员名字*/
		String[] selected_1 = request.getParameterValues("hqht");
		//int size_1=selected_1.length;
		if(selected_1 != null){
		    for(int m=0; m<selected_1.length; m++){
		       	
					System.out.println(selected_1[m]);
		    }
			}
		/*得到审批人员名字*/
		String[] selected_2 = request.getParameterValues("spht");
		int size_2=selected_2.length;
		if(selected_2 != null){
		    for(int m=0; m<selected_2.length; m++){
		       	
					System.out.println(selected_2[m]);
		    }
			}
		
		/*得到签订人员名字*/
		
		String[] selected_3 = request.getParameterValues("qdht");
		int size_3=selected_3.length;
		if(selected_3 != null){
		    for(int m=0; m<selected_3.length; m++){
		       	
					System.out.println(selected_3[m]);
		    }
			}
		
				
	  //查询参与会签用户user_id,并完成插入工作
		for(int i=0;i<selected_1.length;i++){
			  sql="select id from user where userName='"+selected_1[i]+"'"; 

			 try {
				pstmt = sqlCon.prepareStatement(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				sqlRst = pstmt.executeQuery();
				  if(sqlRst.next()){
						System.out.println(sqlRst.getString(1));
						
						
					     int id=sqlRst.getInt(1);
					     SQL="insert into contract_process(user_id,con_id,type,state) values('"+id+"','"+Contract_id+"',1,0)";
						
					     stmt = sqlCon.createStatement();
						 stmt.execute(SQL);

			}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
	
		}
	
	  //查询参与审批用户user_id,并完成插入工作
		for(int i=0;i<selected_2.length;i++){
			  sql="select id from user where userName='"+selected_2[i]+"'"; 

			 try {
				pstmt = sqlCon.prepareStatement(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				sqlRst = pstmt.executeQuery();
				  if(sqlRst.next()){
						
					     int id=sqlRst.getInt(1);
					     SQL="insert into contract_process(user_id,con_id,type,state) values('"+id+"','"+Contract_id+"',2,0)";
						
					     stmt = sqlCon.createStatement();
						 stmt.execute(SQL);

			}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
	
		}	
		
		
		//查询参与签订用户user_id,并完成插入工作
		for(int i=0;i<selected_3.length;i++){
			  sql="select id from user where userName='"+selected_3[i]+"'"; 

			 try {
				pstmt = sqlCon.prepareStatement(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				sqlRst = pstmt.executeQuery();
				  if(sqlRst.next()){
						
					     int id=sqlRst.getInt(1);
					     SQL="insert into contract_process(user_id,con_id,type,state) values('"+id+"','"+Contract_id+"',3,0)";
						
					     stmt = sqlCon.createStatement();
						 stmt.execute(SQL);

			}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
			
	
		}	
		SQL="update contract_state set type=2 where con_id='"+Contract_id+"'";
	     try {
			stmt = sqlCon.createStatement();
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
		
		 //日志管理
		
		 sql="insert into log(content) values('"+"合同ID为"+Contract_id+"已完成分配工作"+"')";
		    try {
				stmt.execute(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
		response.sendRedirect("welcome.jsp");
		
}
	
}
