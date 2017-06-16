<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
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
int i;  
DbUtil dbUtil=new DbUtil();

//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Finalize contract</title>
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
	String contract="";
    String customer="";
    String begintime="";
    String endtime="";
    String C_content="";
	String Contract_ID=request.getParameter("c_ID");
	session.setAttribute("contract_id",Contract_ID);
sql="select con_name,cus_name,beginTime,endTime,content from contract where id='"+Contract_ID+"'";
	
	 PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();
if(sqlRst.next())
{
 contract=sqlRst.getString(1);
 customer=sqlRst.getString(2);
 begintime=sqlRst.getString(3);
 endtime=sqlRst.getString(4);
 C_content=sqlRst.getString(5);
}
 %>
		<div class="mtitle">
			Finalize contract
		</div>
		<br />
		<form action="finalize" method="post" onSubmit="return check(this)" name="myform">
			<table class="update" style="width:700px;">
				<tr height="28">
					<td width="140">Contract name:</td>
					<td><%=contract%></td>
				</tr>

				<tr height="28">
					<td>Customer:</td>
					<td>
						<%=customer%>
					</td>
				</tr>
				<tr>
					<td>Begin time:</td>	
					<td><%=begintime%></td>
				</tr>
				<tr>
					<td>End time:</td>	
					<td><%=endtime%></td>
				</tr>
				<tr>
					<td>Content:</td>	
					<td>
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<textarea rows="40" cols="100" name="content" style="width:680px;height:400px;resize:none;" id="content"><%=C_content%>
						</textarea>
					</td>
				</tr>
				<tr height="28">
					<td>Attachment:</td>
					<td><input type="file" /></td>
				</tr>
				
				<tr height="28">
					<td align="center" colspan="2">
						<input type="submit" value="Submit" class="button"> &nbsp; &nbsp; &nbsp;
						<input type="submit" value="Reset" class="button">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
