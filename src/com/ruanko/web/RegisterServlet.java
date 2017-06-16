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


public class RegisterServlet extends HttpServlet{
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

		String userName=request.getParameter("userName");
		String password_1=request.getParameter("password_1");
		String password_2=request.getParameter("password_2");
		request.setAttribute("userName", userName);
		request.setAttribute("password_1", password_1);
		request.setAttribute("password_2", password_2);
		if(StringUtil.isEmpty(userName)||StringUtil.isEmpty(password_1)||StringUtil.isEmpty(password_2)){
			request.setAttribute("error", "用户名或密码为空！");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}
		else if(!password_1.equals(password_2))
		{
			request.setAttribute("error", "二次输入密码出错！");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}
		else if(password_1.length()<6)
		{
			request.setAttribute("error", "密码长度不得少于6个字符！");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}
		User user=new User(userName,password_1);
		Connection con=null;
		try {
			con=dbUtil.getCon();
			User currentUser=userDao.register(con, user);
			if(currentUser==null){
				//睡眠时间
				// 客户端跳转
				response.sendRedirect("index.jsp");
			}else{
				request.setAttribute("error", "该用户名已注册！");
				// 服务器跳转
				request.getRequestDispatcher("register.jsp").forward(request, response);
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
