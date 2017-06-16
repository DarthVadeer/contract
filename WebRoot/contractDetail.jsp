<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Contract details</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
	</head>

	<body>
<%@ page contentType="text/html;charset=gb2312"%> 
<%
java.sql.Connection sqlCon; //数据库连接对象  
java.sql.ResultSet sqlRst; //结果集对象  
java.lang.String sql; //SQL语句  
String ID=request.getParameter("contractID");

int id=Integer.parseInt(ID);
String customername="";
String content="";
String beginTime="";
String endTime="";
String username="";
String contractname="";
//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");
//获取起草人名字
sql="select userName from user where id=(select user_id from contract where id='"+id+"')";
  PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
if(sqlRst.next())
{
 username=sqlRst.getString(1);
}

//获取客户名字，合同内容，合同起止时间
sql="select cus_name,content,beginTime,endTime,con_name from contract where id='"+id+"'";
pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
if(sqlRst.next())
{
 customername=sqlRst.getString(1);
 content=sqlRst.getString(2);
 beginTime=sqlRst.getString(3);
 endTime=sqlRst.getString(4);
 contractname=sqlRst.getString(5);
}
 %>
		<div class="preview">
		   <div class="viewbox">
			<div class="title">
			<%=contractname %>
			</div>
			<div class="info">
				<small>Customer:</small><%=customername%>
				<small>Drafter:</small><%=username%>
				<small>Begin time:</small><%=beginTime%>
				<small>End time:</small><%=endTime%>
			</div>
			<div class="content">	
				<%=content%>		
			</div>
		</div>

				</div>
	</body>
</html>
