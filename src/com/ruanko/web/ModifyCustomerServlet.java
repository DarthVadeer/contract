package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.CustomerDao;
import com.ruanko.model.Customer;
import com.ruanko.utils.DbUtil;

public class ModifyCustomerServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	CustomerDao customerDao=new CustomerDao();
	
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
		  //获取该客户的id
		String id=(String)request.getSession().getAttribute("customer_id");
		int customer_id=Integer.parseInt(id);
		
		//获取修改后的所有的信息
		String customer_name=request.getParameter("name");
		String customer_tel=request.getParameter("phone");
		String customer_address=request.getParameter("address");
		String customer_fax=request.getParameter("fax");
		String customer_mail=request.getParameter("mailbox");
		String customer_bank=request.getParameter("bankname");
		String customer_account=request.getParameter("bankaccount");
		String customer_code=request.getParameter("content");
		
		request.setAttribute("name", customer_name);
		request.setAttribute("phone", customer_tel);
		request.setAttribute("address", customer_address);
		request.setAttribute("fax", customer_fax);
		request.setAttribute("mail", customer_mail);
		request.setAttribute("bank", customer_bank);
		request.setAttribute("account", customer_account);
		request.setAttribute("content", customer_code);
		
		
		Customer customer=new Customer(customer_id,customer_mail,customer_name,customer_address,customer_tel,customer_fax,customer_code,customer_bank,customer_account);
		Connection con=null;
		
		try{
			con=dbUtil.getCon();
			
			customerDao.modifyCustomer(con,customer);
		
		}catch(Exception e){
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
		request.setAttribute("error", "成功修改该客户！");
		request.getRequestDispatcher("customerList.jsp").forward(request, response);

	}
	
}

