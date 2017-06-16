package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.UserDao;
import com.ruanko.model.User;
import com.ruanko.utils.DbUtil;

public class DeleteUserServlet extends HttpServlet{
	
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
		  Connection con_1=null;
			try {
				con_1=dbUtil.getCon();
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		String name=new String(request.getParameter("delete_username").getBytes("ISO-8859-1"),"gbk"); 

//删除链接传过来的用户名字
		if(name!=null){
			
			PreparedStatement pstmt=null;
			String sql="select rol_id from u_right where user_id =(select id from user where userName='"+name+"')";
			 try {
				pstmt=con_1.prepareStatement(sql);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			ResultSet rs_3;
			try {
				rs_3 = pstmt.executeQuery();
				if(rs_3.next()){
				
					if(rs_3.getInt(1)==1){
					request.setAttribute("error", "不可删除管理员用户！");
					
					request.getRequestDispatcher("userlist.jsp").forward(request, response);
					return;
					}
			
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			//判断该成员id是否在分配任务当中
			 sql="select * from contract_process where user_id =(select id from user where userName='"+name+"')";
			
			//PreparedStatement pstmt_1=null;
			try {
				pstmt = con_1.prepareStatement(sql);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			ResultSet rs;
			try {
				rs = pstmt.executeQuery();
				if(rs.next()){
					request.setAttribute("error", "不可删除该用户！");
					
					request.getRequestDispatcher("userlist.jsp").forward(request, response);
					return;
			
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			sql="select * from contract where user_id =(select id from user where userName='"+name+"')";
			 try {
				pstmt=con_1.prepareStatement(sql);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			ResultSet rs_1;
			try {
				rs_1 = pstmt.executeQuery();
				if(rs_1.next()){
					request.setAttribute("error", "不可删除该用户！");
					
					request.getRequestDispatcher("userlist.jsp").forward(request, response);
					return;
			
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
			
			
			 User new_user=new User(name);
		try {
			userDao.deleteuser(con_1,new_user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("userlist.jsp").forward(request, response);
			
	return;
		}

}
}
