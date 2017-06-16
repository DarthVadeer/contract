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
		//��ȡedituser.jsp���������û���
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
			request.setAttribute("error", "�����޸�ϵͳ����Ա���ƣ�");
			request.getRequestDispatcher("userlist.jsp").forward(request, response);
			return;
		}
       //�жϽ�Ҫ�޸ĵ��û����Ƿ�Ϊ��
		if(StringUtil.isEmpty(userName)){
			
			request.setAttribute("user_1", username);
			request.setAttribute("error", "�û���Ϊ�գ�");
			
			request.getRequestDispatcher("edituser.jsp").forward(request, response);
			return;
		}
		
		  //�жϽ�Ҫ�޸ĵ��û����Ƿ������е��û�����
		//�������û����;��û���
		User user=new User(userName,username);
		try {
		  
			User currentUser=userDao.duplicate(con, user);
			if(currentUser==null){
				// ��������ת
				response.sendRedirect("userlist.jsp");
			
			}else{
				// �ͻ�����ת
				request.setAttribute("user_1", username);
				
				        request.setAttribute("error", "�û���:"+userName+"����,���������룡");
				       
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
