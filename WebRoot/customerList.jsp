<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%
    request.setCharacterEncoding("GBK");
		  response.setContentType("text/html;charset=GBK");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=gb2312"%> 
<% java.sql.Connection sqlCon; //���ݿ����Ӷ���  
java.sql.ResultSet sqlRst; //���������  
java.lang.String sql; //SQL���  
int intPageSize; //һҳ��ʾ�ļ�¼��  
int intRowCount; //��¼����  
int intPageCount; //��ҳ��  
int intPage; //����ʾҳ��  
int pagenumber;
java.lang.String strPage;  
int i;  
DbUtil dbUtil=new DbUtil();
//����һҳ��ʾ�ļ�¼��  
intPageSize = 2;  
//ȡ�ô���ʾҳ��  
strPage = request.getParameter("page");  
if(strPage==null){  
//������QueryString��û��page��һ����������ʱ��ʾ��һҳ����  
intPage = 1;  
} else{  
//���ַ���ת��������  
intPage = java.lang.Integer.parseInt(strPage);  
if(intPage< 1) intPage = 1;  
}  
//װ��JDBC��������  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//�������ݿ�  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Customter list</title>
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
			Customter list
		</div>
	<%
	String customername="";
		if(request.getParameter("customername")!=null){
				request.setCharacterEncoding("gbk"); 
      customername=new String(request.getParameter("customername").getBytes("ISO-8859-1"),"gbk"); 
}
if(customername==null)
customername="";
		 %>

		<div class="search">
		  <div style="float:left;width:600px;">
			<form>
				Search Customer:
				<input type="text" name="customername"  value="<%=customername%>" id="customername" />
						
<% 
boolean flag;//��־�Ƿ�Ϊ��ѯ״̬���ұ�֤��ѯ���Ľ������ʾδһҳ
flag=true;

if(request.getParameter("customername")==null||customername==""){
sql="select name,address,tel,fax,mailbox,id from customer group by id";
 
intPageSize = 4;  
flag=false;
}
else{
sql="select name,address,tel,fax,mailbox,id from customer where name like '"+"%"+customername+"%"+"' group by id";
 
  PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//ִ��SQL��䲢��ȡ�����  
sqlRst = pstmt.executeQuery();  
int t=0;
while(sqlRst.next()){
t++;
intPageSize = t;  
}
}
 PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//ִ��SQL��䲢��ȡ�����  
sqlRst = pstmt.executeQuery();  

//��ȡ��¼����  
sqlRst.last();  
intRowCount = sqlRst.getRow();  
//������ҳ��  
intPageCount = (intRowCount+intPageSize-1) / intPageSize;  
//��������ʾ��ҳ��  
if(intPage>intPageCount) intPage = intPageCount;
 %>

				&nbsp;&nbsp;
				<input type="submit" value="Search" class="search-submit"/><font color="red">${error }</font> <br />
				
			</form>		
		  </div>

		  <div style="float:left;width:150px;">
			<a href="addCustomer.jsp">
				<img src="images/add.png"  alt="Add Customer" />
				Add Customer
			</a>
          </div>
		</div>
		<br />
		<div class="list">
		  <table>
			<tr>
				<th>
					Customer name
				</th>
				<th>
					Address
				</th>
				<th>
					Phone Number
				</th>
				<th>
					Fax
				</th>
				<th>
					Mailbox
				</th>
				<th style="width:150px;text-align:center;">
					Operation
				</th>
			</tr>
				<%if(intPageCount>0)  
{  
//����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��  
sqlRst.absolute((intPage-1) * intPageSize + 1);  
//��ʾ����  
i = 0;  
while(i< intPageSize && !sqlRst.isAfterLast()){ %> 
			<tr>
				<td class="tdname">
						<%String s_1=Integer.toString(i);%>
<%session.setAttribute("customerID_"+s_1,sqlRst.getInt(6)); %>
			
	<a href="customerDetail.jsp?customerID=<%=session.getAttribute("customerID_"+s_1)%>"><%=sqlRst.getString(1)%></a>
				</td>
				<td>
					<%=sqlRst.getString(2)%>
				</td>
				<td>
					<%=sqlRst.getString(3)%>
				</td>
				<td>
					<%=sqlRst.getString(4)%>
				</td>
				<td>
					<%=sqlRst.getString(5)%>
				</td>
				<td>
						<%String s_2=Integer.toString(i);%>
<%session.setAttribute("customerID_"+s_2,sqlRst.getInt(6)); %>
	<a href="editCustomer.jsp?customerID=<%=session.getAttribute("customerID_"+s_2)%>" target="main">
		
						<img src="images/icon-edit.png"  alt="Edit" />
						Edit
					</a>
					| 
				<%String s_3=Integer.toString(i);%>
<%session.setAttribute("customer_name"+s_3,sqlRst.getString(1)); %>
					<a href="deleteCustomer?delete_customername=<%=session.getAttribute("customer_name"+s_3)%>">
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
			<%if(!flag){%><a href="customerList.jsp?page=<%=1%>"><img src="images/page/first.png"  alt="" /></a>&nbsp;<%} %>
				
			<%if(intPage>1&&!flag){%><a href="customerList.jsp?page=<%=intPage-1%>"><img src="images/page/pre.png"  alt="" /></a> &nbsp;<%}%>
			<%if(intPage< intPageCount&&!flag){%><a href="customerList.jsp?page=<%=intPage+1%>"><img src="images/page/next.png"  alt="" /></a> &nbsp;<%}%>

			<%if(!flag){%><a href="customerList.jsp?page=<%=intPageCount%>"><img src="images/page/last.png"  alt="" /></a>&nbsp;<%} %>
					
			<span class="pageinfo">
				Total&nbsp;<strong><%=intPageCount%></strong>&nbsp;pages&nbsp; page:<strong><%=intPage%></strong>&nbsp;
			</span>	

		</div>
	</body>
</html>
