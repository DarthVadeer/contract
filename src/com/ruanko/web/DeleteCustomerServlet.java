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

import com.ruanko.dao.CustomerDao;
import com.ruanko.dao.UserDao;
import com.ruanko.model.User;
import com.ruanko.utils.DbUtil;

public class DeleteCustomerServlet extends HttpServlet{
	
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
		  Connection con_1=null;
			try {
				con_1=dbUtil.getCon();
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		String name=new String(request.getParameter("delete_customername").getBytes("ISO-8859-1"),"gbk"); 
		
		//判断是否有合同，若有合同，则不能删除
		if(name!=null){
			PreparedStatement pstmt=null;
			String sql="select con_id,cus_name from contract,contract_state where contract.id=con_id and type=6 and cus_name='"+name+"'";
			 try {
				pstmt=con_1.prepareStatement(sql);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			ResultSet rs_3=null;
			try {
				rs_3 = pstmt.executeQuery();
				if(rs_3.next()){
				
					if(rs_3.getString(2).equals(name)){
					request.setAttribute("error", "不可删除该客户，该客户合同未完成！");
					
					request.getRequestDispatcher("customerList.jsp").forward(request, response);
					return;
					}
					else{
request.setAttribute("error", "成功删除客户"+name+"！");
					
					request.getRequestDispatcher("customerList.jsp").forward(request, response);
					}
						
			
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
			try {
				customerDao.deleteCustomer(con_1,name);
				request.setAttribute("error", "成功删除该客户！");
				request.getRequestDispatcher("customerList.jsp").forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		} 
	}
	
}
