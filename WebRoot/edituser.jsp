<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%



String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
   <title>Edit Customer</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
			<script language="JavaScript" type="text/JavaScript">  

function change(targetid){  
     if (document.getElementById){  
         target=document.getElementById(targetid);  
             if (target.style.display=="block"){  
                 target.style.display="none";  
             } else {  
                 target.style.display="block";  
             }  
     }  
}  

</script>  
	</head>

	<body>
	<button onclick="change('div1')">本地上传</button>   
		<div class="mtitle">
			Edit User
		</div>	
		<br />
		<div id="div1" style="font-size:18px;color:green;width:700px;text-align:center;display: none">
			Edit successfully!			
		</div>

		<br />
		<form action="editUser" method="post">
			<%  request.setCharacterEncoding("gbk"); 
			String user="";
				String user_2 = (String)request.getAttribute("user_1"); 
				//分别处理客户端跳转和服务器端跳转，若服务器端跳转则  user不存在，应该用user_2   如果客户端跳转  user_2为空   应该用user
			if(request.getAttribute("user_1")==null){
user=new String(request.getParameter("username").getBytes("ISO-8859-1"),"gbk"); 
}
		
			if(user==null){
			//user=user_2;
			session.setAttribute("user_Name",user_2);
			}
			else
				session.setAttribute("user_Name",user);
			 %>
			<table class="update" style="width:700px;">
				<tr height="28">
					<td width="140px">User name:</td>
					<%if(user==null){ %>
					<td><input type="text" name="user_Name" value="<%=user_2%>" />&nbsp;<span><font color="red">${error }</font></span></td><%}else{ %>
					<td><input type="text" name="user_Name" value="<%=user%>" />&nbsp;<span><font color="red">${error }</font></span></td><%} %>
					
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
