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
int intPageSize; //一页显示的记录数  
int intRowCount; //记录总数  
int intPageCount; //总页数  
int intPage; //待显示页码  
int pagenumber;
java.lang.String strPage;  
int i;  
DbUtil dbUtil=new DbUtil();
//设置一页显示的记录数  
intPageSize = 2;  
//取得待显示页码  
strPage = request.getParameter("page");  
if(strPage==null){  
//表明在QueryString中没有page这一个参数，此时显示第一页数据  
intPage = 1;  
} else{  
//将字符串转换成整型  
intPage = java.lang.Integer.parseInt(strPage);  
if(intPage< 1) intPage = 1;  
}  
//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
   <title>User list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
		<!-- Use JavaScript script to open a new window display information when preview-->
		<script>
			function preview(url) {
				window.open(url,'Preview','toolbar=no,scrollbars=yes,width=720,height=560,top=50,left=100');
			}
	
		</script>
	</head>

	<body>
		<div class="mtitle">
			User list
		</div>
<%String username=request.getParameter("username");
if(username==null)
username=""; %>
		<div class="search">
		  <div style="float:left;width:600px;">
					<form action="" method="post">
				Search user:
				<input type="text" name="username"  value="<%=username%>" id="username" />
				
<% 
boolean flag;//标志是否为查询状态，且保证查询到的结果仅显示未一页
flag=true;
username=request.getParameter("username");

if(request.getParameter("username")==null||username==""){
sql = "select userName,password from user group by userName";  
intPageSize = 4;  
flag=false;
}
else{

sql = "select userName,password from user where userName like '"+"%"+request.getParameter("username")+"%"+"'group by userName";  

 PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
int t=0;

while(sqlRst.next()){
t++;
intPageSize = t;  
}

}
 PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  

//获取记录总数  
sqlRst.last();  
intRowCount = sqlRst.getRow();  
//记算总页数  
intPageCount = (intRowCount+intPageSize-1) / intPageSize;  
//调整待显示的页码  
if(intPage>intPageCount) intPage = intPageCount;
 %>
				&nbsp;&nbsp;
				<input type="submit" value="Search" class="search-submit" /> <font color="red">${error}</font><br />
			</form>		
		  </div>	
		</div>
		<br />
		<div class="list">
		  <table>
			<tr>
				<th>
					User name
				</th>
				<th style="width:150px;text-align:center;">
					Operation
				</th>
			</tr>
				
<%if(intPageCount>0)  
{  
//将记录指针定位到待显示页的第一条记录上  
sqlRst.absolute((intPage-1) * intPageSize + 1);  
//显示数据  
i = 0;  
while(i< intPageSize && !sqlRst.isAfterLast()){ %> 
<tr> 
<td class="tdname">
<%=sqlRst.getString(1)%>
</td> 

<td>
<%String s=Integer.toString(i);%>
<%session.setAttribute("user_name_"+s,sqlRst.getString(1)); %>
					<a href="edituser.jsp?username=<%=session.getAttribute("user_name_"+s)%>">
						<img src="images/icon-edit.png"  alt="Edit" />
						Edit
					</a>
					| 
					<%String s_1=Integer.toString(i);%>
<%session.setAttribute("user_name_1"+s_1,sqlRst.getString(1)); %>
					<a href="deleteUser?delete_username=<%=session.getAttribute("user_name_1"+s_1)%>">
						<img src="images/delete.png"  alt="Delete" />
						Delete
					</a>
				
</td>
</tr> 
<% sqlRst.next();  
i++;  
}  
}  
%> 
				
			<tr>
				<td colspan="7"> </td>
			</tr>
		  </table>
		</div>
	<div align="right" class="pagelist">					
			<%if(!flag){%><a href="userlist.jsp?page=<%=1%>"><img src="images/page/first.png"  alt="" /></a>&nbsp;<%} %>
				
			<%if(intPage>1&&!flag){%><a href="userlist.jsp?page=<%=intPage-1%>"><img src="images/page/pre.png"  alt="" /></a> &nbsp;<%}%>
			<%if(intPage< intPageCount&&!flag){%><a href="userlist.jsp?page=<%=intPage+1%>"><img src="images/page/next.png"  alt="" /></a> &nbsp;<%}%>

			<%if(!flag){%><a href="userlist.jsp?page=<%=intPageCount%>"><img src="images/page/last.png"  alt="" /></a>&nbsp;<%} %>
					
			<span class="pageinfo">
				Total&nbsp;<strong><%=intPageCount%></strong>&nbsp;pages&nbsp; page:<strong><%=intPage%></strong>&nbsp;
			</span>	
	
		</div>
	</body>
</html>
