<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%
request.setCharacterEncoding("GBK");
		  response.setContentType("text/html;charset=GBK");
		  String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=gb2312"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Contract details</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
	</head>

	<body>

<%
java.sql.Connection sqlCon; //数据库连接对象  
java.sql.ResultSet sqlRst; //结果集对象  
java.lang.String sql; //SQL语句  
//获取客户id
String ID=request.getParameter("customerID");

int id=Integer.parseInt(ID);
String customername="";
String phone="";
String address="";
String fax="";
String mailbox="";
String bankname="";
String bankaccount="";
String code="";

//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");

sql="select name,address,tel,fax,mailbox,bank,account,code from customer where id='"+id+"'";
  PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
if(sqlRst.next())
{
 customername=sqlRst.getString(1);
 phone=sqlRst.getString(2);
 address=sqlRst.getString(3);
 fax=sqlRst.getString(4);
 mailbox=sqlRst.getString(5);
 bankname=sqlRst.getString(6);
 bankaccount=sqlRst.getString(7);
 code=sqlRst.getString(8);
}
 %>
		<div class="mtitle">
			Customer Detail
		</div>	
		<br />
		<table class="update" style="width:500px;">
				<tr height="28">
					<td width="140px">Customer name:</td>
					<td><%=customername%></td>
				</tr>
				<tr height="28">
					<td>Phone number:</td>
					<td><%=phone%></td>
				</tr>
				<tr height="28">
					<td>Address:</td>
					<td><%=address%></td>
				</tr>
				<tr height="28">
					<td>Fax:</td>
					<td><%=fax%></td>
				</tr>
				<tr height="28">
					<td>Mailbox:</td>
					<td><%=mailbox%></td>
				</tr>
				<tr height="28">
					<td>Bank name:</td>
					<td><%=bankname%></td>
				</tr>
				<tr height="28">
					<td>Bank account:</td>
					<td><%=bankaccount%> </td>
				</tr>
				<tr>
					<td>Remark:</td>
					<td>
						<%=code%>
					</td>
				</tr>
				
			</table>
	</body>
</html>
