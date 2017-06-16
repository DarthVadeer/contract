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
		  //��ͬ�û�����
		  String username=(String)request.getSession().getAttribute("USERname");
		  //��ͬID
		  String contractid=(String)request.getSession().getAttribute("CONTRACTid");
		  //��ͬ��ǩ���
	       String content=request.getParameter("content");
	       //��ͬ����ͨ�����
	       String[] values=request.getParameterValues("approve");
	       
	       Statement stmt=null; //��������
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
	     //ִ��SQL��䲢��ȡ�����  
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

		 //��־����
		
		 sql="insert into log(content) values('"+"�û�IDΪ"+user_id+"�����������"+"')";
		    try {
				stmt.execute(sql);
			} catch (SQLException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		
	 //��������Ա����Ϊ���򽫺�ͬ״̬��Ϊ type��0   ��������Աͨ���Ļ����򲻶���ͬ״̬
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
	//�жϺ�ͬ״̬type�Ƿ�Ϊ0,��Ϊ0�����ʾ�ú�ͬ�Ѿ����񶨵����������أ�����Ϊ0����Ӧ��������ȥ
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
				//�Ըú�ͬ�����̽������
				
		         sql="delete from contract_process where con_id='"+contractid+"'";
			     stmt.execute(sql);
			//�ͻ�����ת     
		response.sendRedirect("welcome.jsp");
				return;
			}
		}
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	
	//��֮ǰû����������ͨ��������ͨ���������ж��Ƿ������˶�������ϣ����Ժ�ͬ״̬��Ϊ��ǩ��״̬
	
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
						
					    
						  //��־����
							
							 sql="insert into log(content) values('"+"��ͬIDΪ"+contractid+"�������"+"')";
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