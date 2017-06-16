<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Role list</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
	</head>

	<body>
		<div class="mtitle">
			Role list
		</div>
		<br />

		<div class="list">
		  <table>
			<tr>
				<th style="width:100px;">
					Role name
				</th>
				<th>
					Description
				</th>
				<th style="width:100px;">
					Create time
				</th>
				
			</tr>
			
			<tr>
				<td class="tdname">
					admin
				</td>
				<td class="tdname">
					To implement the system management and contract management
				</td>
				<td>
					2014-6-3
				</td>
				
			</tr>
			<tr>
				<td class="tdname">
					operator
				</td>
				<td class="tdname">
					operate contract
				</td>
				<td>
					2014-6-5
				</td>
			</tr>
			<tr>
				<td colspan="5"> </td>
			</tr>
		  </table>
		</div>
	</body>
</html>
