package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.UserDao;
import com.ruanko.model.User;
import com.ruanko.utils.DbUtil;
import com.ruanko.utils.StringUtil;

public class EditUserServlet extends HttpServlet{
	
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

		String username=(String)request.getSession().getAttribute("user_Name");
		//获取edituser.jsp传过来的用户名
		String userName=request.getParameter("user_Name");
		Connection con=null;
	     
	      try {
			con=dbUtil.getCon();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		if(username.equals("admin")){
			
			request.setAttribute("user_1", username);
			request.setAttribute("error", "不可修改系统管理员名称！");
			request.getRequestDispatcher("userlist.jsp").forward(request, response);
			return;
		}
       //判断将要修改的用户名是否为空
		if(StringUtil.isEmpty(userName)){
			
			request.setAttribute("user_1", username);
			request.setAttribute("error", "用户名为空！");
			
			request.getRequestDispatcher("edituser.jsp").forward(request, response);
			return;
		}
		
		  //判断将要修改的用户名是否与现有的用户重名
		//传入新用户名和旧用户名
		User user=new User(userName,username);
		try {
		  
			User currentUser=userDao.duplicate(con, user);
			if(currentUser==null){
				// 服务器跳转
				response.sendRedirect("userlist.jsp");
			
			}else{
				// 客户端跳转
				request.setAttribute("user_1", username);
				
				        request.setAttribute("error", "用户名:"+userName+"重名,请重新输入！");
				       
						request.getRequestDispatcher("edituser.jsp").forward(request, response);
				        
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}
