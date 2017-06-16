<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%
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
java.lang.String username; 
int i;  
DbUtil dbUtil=new DbUtil();
//设置一页显示的记录数  
intPageSize = 2;  
//取得待显示页码  
strPage = request.getParameter("page");  
//取得用户名字
username=request.getParameter("username");
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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
		<title>List of signed contract</title>
		<!-- Use JavaScript script to open a new window display information when preview-->
		<script>
			function preview(url) {
				window.open(url,'Preview','toolbar=no,scrollbars=yes,width=720,height=560');
			}
		</script>
	</head>

	<body>
		<div class="mtitle">
			MY Contract 
		</div>
		<%
		if(username==null){
		request.setCharacterEncoding("gbk"); 
		if(request.getParameter("username_9")!=null){
	    username=new String(request.getParameter("username_9").getBytes("ISO-8859-1"),"gbk"); 

}
}
		String contractname=request.getParameter("contractname");
if(contractname==null)
contractname="";
		 %>
		
		<div class="search">
			<form action="" method="post">
				Search signed contract: 
				<input type="text" name="contractname"  value="<%=contractname%>" id="contractname" />
						
<% 

boolean flag;//标志是否为查询状态，且保证查询到的结果仅显示未一页
flag=true;

contractname=request.getParameter("contractname");

if(request.getParameter("contractname")==null||contractname==""){
  sql="select con_name,beginTime,contract.id,type from contract,contract_state where contract.id=con_id and user_id=(select id from user where userName='"+username+"') group by contract.id";
 
intPageSize = 4;  
flag=false;
}
else{
  sql="select con_name,beginTime,contract.id,type from contract,contract_state where contract.id=con_id and user_id=(select id from user where userName='"+username+"') and con_name like '"+"%"+contractname+"%"+"' group by contract.id";
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
				<input type="submit" value="Search" class="search-submit"/> <br />
			</form>
		</div>
		
		<div class="list">
		  <table>
			<tr>
				<th>
					Contract name
				</th>
				<th class="th1">
					Draft time
				</th>
				<th class="th2">
					State
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
					
				<%String s_1=Integer.toString(i);%>
<%session.setAttribute("contractID_"+s_1,sqlRst.getInt(3)); %>
			
	<a href="contractDetail.jsp?contractID=<%=session.getAttribute("contractID_"+s_1)%>"><%=sqlRst.getString(1)%></a>
				</td>
				<td>
					<%=sqlRst.getString(2)%>
				</td>
				
				<%if(sqlRst.getInt(4)==0) {%><td>审批不通过</td><%}else if(sqlRst.getInt(4)==1){ %><td>待分配</td><%}else if(sqlRst.getInt(4)==2){ %><td>待会签</td><%}else if(sqlRst.getInt(4)==3){ %><td>待定稿</td><%}else if(sqlRst.getInt(4)==4){ %><td>待审批</td>
				<%}else if(sqlRst.getInt(4)==5){ %><td>待签订</td><%}else if(sqlRst.getInt(4)==6){ %><td>签订完成</td><%} %>
			</tr>
			
			<% sqlRst.next();  
i++;  
}
}  
%> 
			
			<tr>
				<td colspan="3"> </td>
			</tr>
		  </table>
		</div>

		<div align="right" class="pagelist">					
			<%if(!flag){%><a href="Queryprocess_operator.jsp?page=<%=1%>&username=<%=username%>"><img src="images/page/first.png"  alt="" /></a>&nbsp;<%} %>
				
			<%if(intPage>1&&!flag){%><a href="Queryprocess_operator.jsp?page=<%=intPage-1%>&username=<%=username%>"><img src="images/page/pre.png"  alt="" /></a> &nbsp;<%}%>
			<%if(intPage< intPageCount&&!flag){%><a href="Queryprocess_operator.jsp?page=<%=intPage+1%>&username=<%=username%>"><img src="images/page/next.png"  alt="" /></a> &nbsp;<%}%>

			<%if(!flag){%><a href="Queryprocess_operator.jsp?page=<%=intPageCount%>&username=<%=username%>"><img src="images/page/last.png"  alt="" /></a>&nbsp;<%} %>
					
			<span class="pageinfo">
				Total&nbsp;<strong><%=intPageCount%></strong>&nbsp;pages&nbsp; page:<strong><%=intPage%></strong>&nbsp;
			</span>	
					</div>
	</body>
</html>