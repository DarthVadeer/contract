<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%

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
java.lang.String user;
int i;  
DbUtil dbUtil=new DbUtil();
//����һҳ��ʾ�ļ�¼��  
intPageSize = 2;  
//ȡ�ô���ʾҳ��  
strPage = request.getParameter("page");
//ȡ���û�����
user=request.getParameter("username");  
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
		<title>List of contract to be finalized</title>
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
			Contract to be finalized
		</div>
		<%String contractname=request.getParameter("contractname");
if(contractname==null)
contractname=""; %>
	<%
					if(user==null){
		request.setCharacterEncoding("gbk"); 
		if(request.getParameter("username_1")!=null){
	  user=new String(request.getParameter("username_1").getBytes("ISO-8859-1"),"gbk"); 
	  }
	  }
		
		%>
		<div class="search">
			<form action="" method="post">
		
			
			
			
				Search contract to be finalized:
	<input type="text" name="contractname"  value="<%=contractname%>" id="contractname" />
												
<% 
boolean flag;//��־�Ƿ�Ϊ��ѯ״̬���ұ�֤��ѯ���Ľ������ʾδһҳ
flag=true;

contractname=request.getParameter("contractname");

if(request.getParameter("contractname")==null||contractname==""){
sql="select con_name,beginTime,id from contract where user_id=(select id from user where userName='"+user+"') and id in(select con_id from contract_state where type=3 group by con_id) group by id";
intPageSize = 4;  
flag=false;
}

else{

String cname=request.getParameter("contractname");

sql="select con_name,beginTime,id from contract where user_id=(select id from user where userName='"+user+"') and id in(select con_id from contract_state where type=3 group by con_id) and con_name like '"+"%"+contractname+"%"+"' group by id";
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
				<th width="270px">
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
<%session.setAttribute("contractID_"+s_1,sqlRst.getInt(3)); %>
<a href="contractDetail.jsp?contractID=<%=session.getAttribute("contractID_"+s_1)%>");"><%=sqlRst.getString(1)%></a>
				</td>
				<td>
					<%=sqlRst.getString(2)%>
				</td>
				<td class="operate">
				<%String s_2=Integer.toString(i);%>
<%session.setAttribute("contractID_"+s_2,sqlRst.getInt(3)); %>
<a href="showHQOpinion.jsp?contractID=<%=session.getAttribute("contractID_"+s_2)%>");">
	
						<img src="images/information.png"  alt="Countersign  opinion" />
						Countersign  opinion
					</a> 
					&nbsp;|&nbsp;
					
					
					
<%String s_3=Integer.toString(i);%>
<%session.setAttribute("contractID_"+s_3,sqlRst.getInt(3)); %>
<a href="dgContract.jsp?c_ID=<%=session.getAttribute("contractID_"+s_3)%>">
				
						<img src="images/icon-edit.png"  alt="Finalize " />
						Finalize 
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
			<%if(!flag){%><a href="ddghtList.jsp?page=<%=1%>&user=<%=user%>"><img src="images/page/first.png"  alt="" /></a>&nbsp;<%} %>
				
			<%if(intPage>1&&!flag){%><a href="ddghtList.jsp?page=<%=intPage-1%>&user=<%=user%>"><img src="images/page/pre.png"  alt="" /></a> &nbsp;<%}%>
			<%if(intPage< intPageCount&&!flag){%><a href="ddghtList.jsp?page=<%=intPage+1%>&user=<%=user%>"><img src="images/page/next.png"  alt="" /></a> &nbsp;<%}%>

			<%if(!flag){%><a href="ddghtList.jsp?page=<%=intPageCount%>&user=<%=user%>"><img src="images/page/last.png"  alt="" /></a>&nbsp;<%} %>
					
			<span class="pageinfo">
				Total&nbsp;<strong><%=intPageCount%></strong>&nbsp;pages&nbsp; page:<strong><%=intPage%></strong>&nbsp;
			</span>	
	
		</div>
	</body>
</html>
