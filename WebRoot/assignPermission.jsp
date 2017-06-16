<%@ page language="java" import="java.util.*" import="java.sql.PreparedStatement" import="java.sql.Statement" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
java.sql.Connection sqlCon; //数据库连接对象  
java.sql.ResultSet sqlRst; //结果集对象  
java.lang.String sql; //SQL语句  
//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
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
     //chooseOne()函式    
    function chooseOne(cb){      
        //先取得同name的chekcBox的集合物件      
        var obj = document.getElementsByName("checkbox");      
        for (i=0; i<obj.length; i++){      
            //判斷obj集合中的i元素是否為cb，若否則表示未被點選      
            if (obj[i]!=cb) obj[i].checked = false;      
            //若是 但原先未被勾選 則變成勾選；反之 則變為未勾選      
            else  obj[i].checked = cb.checked;      
            //若要至少勾選一個的話，則把上面那行else拿掉，換用下面那行      
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
				//分别处理客户端跳转和服务器端跳转，若服务器端跳转则  username不存在，应该用name   如果客户端跳转  name为空   应该用username
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
						 		session.setAttribute("UserName",username);//将用户名称传给servlet进行数据库后台处理，实际授权
	sql="select * from u_right where user_id=(select id from user where userName='"+username+"')"; 
						PreparedStatement pstmt=sqlCon.prepareStatement(sql);
                     //执行SQL语句并获取结果集  
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