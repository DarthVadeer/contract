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
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
		<title>List of contract to be assigned</title>
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
			Contracts to be assigned
		</div>
		<%
  //获取搜索框中合同的名称
		String contractname=request.getParameter("contractname");
		if(request.getParameter("contractname")!=null){
		request.setCharacterEncoding("GBK");
	  contractname=new String(request.getParameter("contractname").getBytes("ISO-8859-1"),"gbk"); 
	  }
	  if(contractname==null)
contractname=""; %>
		<div class="search">
			<form action="" method="post">
				Search contract to be assigned:
				<input type="text" name="contractname"  value="<%=contractname%>" id="contractname" />
								
<% 
boolean flag;//标志是否为查询状态，且保证查询到的结果仅显示未一页
flag=true;

if(request.getParameter("contractname")==null||contractname==""){
sql = "select con_name,beginTime,con_id from contract left join contract_state on(contract.id=con_id) where type=1 group by con_id";  
intPageSize = 4;  
flag=false;
}

else{
sql="select con_name,beginTime,con_id from contract left join contract_state on(contract.id=con_id) where type=1 and con_name like '"+"%"+contractname+"%"+"' group by con_id";
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
				<th class="th1">
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

<%String s_1=Integer.toString(i);%>
<%session.setAttribute("contractID_"+s_1,sqlRst.getInt(3)); %>
<a href="contractDetail.jsp?contractID=<%=session.getAttribute("contractID_"+s_1)%>");"><%=sqlRst.getString(1)%></a>
</td> 
<td>
<%=sqlRst.getString(2)%>
</td>

<td>
<%String s_2=Integer.toString(i);%>
<%session.setAttribute("contractID_"+s_2,sqlRst.getInt(3)); %>
<a href="assignOperator.jsp?c_ID=<%=session.getAttribute("contractID_"+s_2)%>">
						<img src="images/cog_edit.png"  alt="Assign" />
						Assign
					</a>
				</td>
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
			<%if(!flag){%><a href="dfphtList.jsp?page=<%=1%>"><img src="images/page/first.png"  alt="" /></a>&nbsp;<%} %>
				
			<%if(intPage>1&&!flag){%><a href="dfphtList.jsp?page=<%=intPage-1%>"><img src="images/page/pre.png"  alt="" /></a> &nbsp;<%}%>
			<%if(intPage< intPageCount&&!flag){%><a href="dfphtList.jsp?page=<%=intPage+1%>"><img src="images/page/next.png"  alt="" /></a> &nbsp;<%}%>

			<%if(!flag){%><a href="dfphtList.jsp?page=<%=intPageCount%>"><img src="images/page/last.png"  alt="" /></a>&nbsp;<%} %>
					
			<span class="pageinfo">
				Total&nbsp;<strong><%=intPageCount%></strong>&nbsp;pages&nbsp; page:<strong><%=intPage%></strong>&nbsp;
			</span>	
	
		</div>

	</body>
</html>
