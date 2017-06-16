package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ruanko.dao.CustomerDao;
import com.ruanko.dao.UserDao;
import com.ruanko.dao.ContractDao;
import com.ruanko.model.Contract;
import com.ruanko.utils.DbUtil;
import com.ruanko.utils.StringUtil;

public class DraftContractServlet extends HttpServlet {
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
		  String username=(String)request.getSession().getAttribute("username_1");
		String contractName=request.getParameter("contractName");
		String customerName=request.getParameter("customerName");
		String beginTime=request.getParameter("beginTime");
		String endTime=request.getParameter("endTime");
		String content=request.getParameter("content");
		
		Contract contract=new Contract(username,contractName,customerName,beginTime,endTime,content);
		
		request.setAttribute("contractName", contractName);
		request.setAttribute("customerName", customerName);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("content", content);
		
		Connection con=null;
	    CustomerDao customerdao=new CustomerDao();
			try {
				con=dbUtil.getCon();
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	
		//判断该客户名称是否存在
		if(customerdao.isExistcustomer(con, customerName)==false){
			request.setAttribute("userNAME",username);
			request.setAttribute("error", "不存在该客户，可向管理员咨询~");
			request.getRequestDispatcher("addContract.jsp").forward(request, response);
			return;
		}
			
		if(!StringUtil.isRightTime(beginTime)){
			request.setAttribute("error2", "时间格式不正确！eg:2014-04-21");
			request.getRequestDispatcher("addContract.jsp").forward(request, response);
			return;
		} 
		if(!StringUtil.isRightTime(endTime)){
			request.setAttribute("error3", "时间格式不正确！eg:2014-04-21");
			request.getRequestDispatcher("addContract.jsp").forward(request, response);
			return;
		}

			try{
				con=dbUtil.getCon();
				ContractDao.drftContract(con,contract);
				response.sendRedirect("welcome.jsp");

			}catch(Exception e){
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