<%@ page language="java" import="java.util.*" import="java.sql.PreparedStatement" import="java.sql.Statement" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
java.sql.Connection sqlCon; //���ݿ����Ӷ���  
java.sql.ResultSet sqlRst; //���������  
java.lang.String sql; //SQL���  
//װ��JDBC��������  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//�������ݿ�  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Configure Permission</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
		type="text/css" />
		<script>      
     //chooseOne()��ʽ    
    function chooseOne(cb){      
        //��ȡ��ͬname��chekcBox�ļ������      
        var obj = document.getElementsByName("checkbox");      
        for (i=0; i<obj.length; i++){      
            //�Д�obj�����е�iԪ���Ƿ��cb������t��ʾδ���c�x      
            if (obj[i]!=cb) obj[i].checked = false;      
            //���� ��ԭ��δ�����x �t׃�ɹ��x����֮ �t׃��δ���x      
            else  obj[i].checked = cb.checked;      
            //��Ҫ���ٹ��xһ����Ԓ���t����������else�õ����Q����������      
            //else obj[i].checked = true;      
        }      
    }      
</script>
	</head>

	<body>
		<div class="mtitle"> 
			Configure permission 
		</div>
		<br />
		<form action="permission" method="post">
			<table class="update" style="width:500px;">
				<tr height="28">
					<td width="180px">
						User name:
					</td>
				<%
				String username="";
				request.setCharacterEncoding("gbk"); 
				//�ֱ���ͻ�����ת�ͷ���������ת��������������ת��  username�����ڣ�Ӧ����name   ����ͻ�����ת  nameΪ��   Ӧ����username
				if(request.getAttribute("name")==null){
username=new String(request.getParameter("user_name").getBytes("ISO-8859-1"),"gbk"); 
}
else{
String name=(String)request.getAttribute("name");
username=name;
}
%>

			<td><%=username%></td>		
					
				</tr>
					
				<tr>
					<td>Configure permission:</td> 
						 	<%  
						 		session.setAttribute("UserName",username);//���û����ƴ���servlet�������ݿ��̨����ʵ����Ȩ
	sql="select * from u_right where user_id=(select id from user where userName='"+username+"')"; 
						PreparedStatement pstmt=sqlCon.prepareStatement(sql);
                     //ִ��SQL��䲢��ȡ�����  
                   sqlRst = pstmt.executeQuery();  
              if(sqlRst.next()){
              if(sqlRst.getString(2).equals("1")){%><td>
						<input name="checkbox" type="checkbox" value="1" onClick="chooseOne(this);"checked/>admin
						<br /><input name="checkbox" type="checkbox" value="2" onClick="chooseOne(this);"/>operator
						<%}else{%><td><input name="checkbox" type="checkbox" value="1" onClick="chooseOne(this);" />admin
						<br /><input name="checkbox" type="checkbox" value="2" onClick="chooseOne(this);" checked/>operator
						<%} %>
						
             
              <%}else{%><td><input name="checkbox" type="checkbox" value="1" onClick="chooseOne(this);"/>admin
						<br /><input name="checkbox" type="checkbox" value="2" onClick="chooseOne(this);"/>operator<%} %>
              
      				<font color="red">${error}</font>
					</td>
				</tr>

				<tr height="28">
					<td align="center" colspan="2">
					
			
			
			
						<input type="submit" value="Submit" class="button" />
						&nbsp; &nbsp; &nbsp;
						<input type="reset" value="Reset" class="button" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>