<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("GBK");
  response.setContentType("text/html;charset=GBK");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=gb2312"%> 
<% java.sql.Connection sqlCon; //数据库连接对象  
java.sql.ResultSet sqlRst; //结果集对象  
java.lang.String sql; //SQL语句  
 String contractname="";
//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Approve contract</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
			<script type="text/javascript">  
 			// Make the page as the parent window display
 			if(top!=self){
 				top.location.href=self.location.href;
 			}  
			function Trim(str)
{
 var tmpStr = new String(str);
 return tmpStr.replace(/(^\s*)|(\s*$)/g, "");
}
	
      function check(){

               var content=document.getElementById("content").value ;
               
  var Content=Trim(content);
  if(Content==""){
alert("Opinoin内容不能为空！"); 
myform.content.focus();
return false;
  }
    		}</script>
	</head>

	<body>
	<%
	String c_id=request.getParameter("contractid");
	//将合同id传到后台
	session.setAttribute("CONTRACTid",c_id);
	sql="select con_name from contract where id='"+c_id+"'";
   PreparedStatement  pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
if(sqlRst.next())
{
 contractname=sqlRst.getString(1);
 }
String username=request.getParameter("user_name_2");
//将用户名字传到后台
session.setAttribute("USERname",username);
	 %>
		<div class="mtitle">
			Approve contract
		</div>
		<br />
		<form action="approvecontract" method="post" onSubmit="return check(this)" name="myform">
			<table class="update" style="width:600px;">	
				<tr height="28">
					<td width="140px">Contract name:</td>
					<td><%=contractname%></td>
				</tr>
				<tr>
					<td>
						&nbsp;<input name="approve" type="radio" value="pass"/>
						Pass
						<br /><br />
						&nbsp;<input name="approve" type="radio" value="refuse" />
						Refuse
					</td>
					<td>
						<textarea rows="10" cols="40" name="content" style="width:400px;height:100px;" id="content"></textarea>
					</td>
				</tr>
				<tr height="28">
					<td align="center" colspan="2">
						<input type="submit" value="Submit" class="button">
						 &nbsp; &nbsp; &nbsp;
						<input type="reset" value="Reset" class="button">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
