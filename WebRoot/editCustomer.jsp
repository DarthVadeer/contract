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
//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Edit Customer</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
			<script type="text/javascript">  
 			// Make the page as the parent window display
 			
	function resetValue(){
		document.getElementById("contractName").value="";
		document.getElementById("customerName").value="";
	    document.getElementById("beginTime").value="";
		document.getElementById("endTime").value="";
	    document.getElementById("content").value="";

	}
	function Trim(str)
{
 var tmpStr = new String(str);
 return tmpStr.replace(/(^\s*)|(\s*$)/g, "");
}
	
      function check(){
        var Customername=document.getElementById("customername").value ;
               
        var CustomerName=Trim(Customername);
        if(CustomerName==""){
        alert("客户名字不能为空！"); 
        myform.name.focus();
        return false;
  }
 }
  		</script>
	</head>

	<body>
	<% 
	String customername="";
    String address="";
    String tel="";
    String fax="";
    String mailbox="";
    String bankname="";
    String bankaccount="";
    String code="";
	String Customer_ID=request.getParameter("customerID");
	session.setAttribute("customer_id",Customer_ID);
sql="select name,address,tel,fax,mailbox,bank,account,code,id from customer where id='"+Customer_ID+"'";
	
	 PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();
if(sqlRst.next())
{
 customername=sqlRst.getString(1);
 address=sqlRst.getString(2);
 tel=sqlRst.getString(3);
 fax=sqlRst.getString(4);
 mailbox=sqlRst.getString(5);
 bankname=sqlRst.getString(6);
 bankaccount=sqlRst.getString(7);
 code=sqlRst.getString(8);
}
 %>
		<div class="mtitle">
			Edit Customer
		</div>	
		<br />
		<br />
		<form action="modifycustomer" method="post" onSubmit="return check(this)" name="myform">
			<table class="update" style="width:700px;">
				<tr height="28">
					<td width="140px">Customer name:</td>
					<td><input type="text" name="name" value="<%=customername%>" id="customername"/></td>
				</tr>
				<tr height="28">
					<td>Phone number:</td>
					<td><input type="text" name="phone" value="<%=tel%>"/></td>
				</tr>
				<tr height="28">
					<td>Address:</td>
					<td><input type="text" name="address" value="<%=address%>"/></td>
				</tr>
				<tr height="28">
					<td>Fax:</td>
					<td><input type="text" name="fax" value="<%=fax%>"/></td>
				</tr>
				<tr height="28">
					<td>Mailbox:</td>
					<td><input type="text" name="mailbox" value="<%=mailbox%>"/></td>
				</tr>
				<tr height="28">
					<td>Bank name:</td>
					<td><input type="text" name="bankname" value="<%=bankname%>"/></td>
				</tr>
				<tr height="28">
					<td>Bank account:</td>
					<td><input type="text" name="bankaccount" value="<%=bankaccount%>"/></td>
				</tr>
				<tr>
					<td>Remark:</td>
					<td>
						<textarea rows="4" cols="40" name="content" style="width:400px;height:100px;"><%=code%></textarea>
					</td>
				</tr>
				<tr height="28">
					<td align="center" colspan="2">
						<input type="submit" value="Submit" class="button"> &nbsp; &nbsp; &nbsp;
						<input type="reset" value="Reset" class="button">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
