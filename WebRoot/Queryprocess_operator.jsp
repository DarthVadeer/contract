<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%
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
java.lang.String username; 
int i;  
DbUtil dbUtil=new DbUtil();
//����һҳ��ʾ�ļ�¼��  
intPageSize = 2;  
//ȡ�ô���ʾҳ��  
strPage = request.getParameter("page");  
//ȡ���û�����
username=request.getParameter("username");
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

boolean flag;//��־�Ƿ�Ϊ��ѯ״̬���ұ�֤��ѯ���Ľ������ʾδһҳ
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
//����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��  
sqlRst.absolute((intPage-1) * intPageSize + 1);  
//��ʾ����  
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
				
				<%if(sqlRst.getInt(4)==0) {%><td>������ͨ��</td><%}else if(sqlRst.getInt(4)==1){ %><td>������</td><%}else if(sqlRst.getInt(4)==2){ %><td>����ǩ</td><%}else if(sqlRst.getInt(4)==3){ %><td>������</td><%}else if(sqlRst.getInt(4)==4){ %><td>������</td>
				<%}else if(sqlRst.getInt(4)==5){ %><td>��ǩ��</td><%}else if(sqlRst.getInt(4)==6){ %><td>ǩ�����</td><%} %>
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