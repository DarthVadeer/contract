<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Contract Management System - Administrator menu bar</title>
	<link href="css/frame.css" rel="stylesheet" type="text/css" />
  </head>
  
  <body>
	<div class="menu">
		
		<dl>
			<dt>
				System Management
			</dt>
			<dd>
				<a href="userlist.jsp" target="main">User Management</a>
			</dd>
			<dd>
				<a href="roleList.jsp" target="main">Role Management</a>
			</dd>		
			<dd>
				<a href="yhqxList.jsp" target="main">Configure Permission</a>
			</dd>
			<dd>
				<a href="log.jsp" target="main">Log Management</a>
			</dd>	
		</dl>
		<dl>
			<dt>
				Contract Management
			</dt>
			<dd>
				<a href="dfphtList.jsp" target="main">Process Configuration</a>
			</dd>
			<dd>
				<a href="yfphtList.jsp" target="main">Assigned Contract</a>
			</dd>
			<dd>
				<a href="Queryprocess_admin.jsp" target="main">Query Process</a>
			</dd>
			
			<dd>
				<a href="customerList.jsp" target="main">Customer Info</a>
			</dd>
		</dl>
	</div>
  </body>
</html>
