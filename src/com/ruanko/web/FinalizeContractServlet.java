package com.ruanko.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruanko.dao.ContractDao;
import com.ruanko.model.Contract;
import com.ruanko.utils.DbUtil;

public class FinalizeContractServlet extends HttpServlet{
	DbUtil dbUtil=new DbUtil();
	ContractDao contractdao=new ContractDao();
	
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
		  
		  //获取修改后非空的合同正文
		String content=request.getParameter("content");
		//获取该合同id
		String ContractID=(String)request.getSession().getAttribute("contract_id");
		Contract contract=new Contract(ContractID,content);
		
		Connection con=null;
		try {
			con=dbUtil.getCon();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if(ContractDao.finalizeContract(con,contract)==true){
				
				response.sendRedirect("welcome.jsp");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
	}
}
