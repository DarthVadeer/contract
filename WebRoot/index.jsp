<%@ page language="java"  pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
<title>Contract Management System - Login page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
		<script type="text/javascript">  
 			// Make the page as the parent window display
 			if(top!=self){
 				top.location.href=self.location.href;
 			}  
	function resetValue(){
		document.getElementById("userName").value="";
		document.getElementById("password").value="";
	}
  		</script>
	</head>

	<body>
		<!-- header start -->
		<div class="header">
			<div class="toplinks">
				<span> [<a href="index.jsp" target="_top">Login</a>]
					&nbsp;|&nbsp; [<a href="register.jsp">Register</a>] </span>
			</div>

			<h1>
				<img src="images/logo_title.png" alt="Contract Management System" />
			</h1>
		</div>
		<!-- header end -->

		<!-- main start -->
		<div class="main">
                 <form action="login" method="post">
	
				<div class="register_main">
					<table>
						<tr>
							<td class="title" colspan="3">
								User Login
							</td>
						</tr>
						<tr>
							<td>
								User name:
							</td>
							<td width="200">
								<input type="text" value="${userName }" name="userName" id="userName"/>
							</td>
							<td width="200"></td>
						</tr>

						<tr>
							<td>
								Password:
							</td>
							<td>
						<input type="password" value="${password }" name="password" id="password"/>
							</td>
							<td><font color="red">${error}</font></td>
						</tr>
						
                                 <tr>
			
			        </tr>
			<tr>
						<!--  	<td colspan="1">
					<input type="submit" value="Login"  style="width:80px;height:30px;"  /></td>
                    <td colspan="2"> <input type="button" value="Reset" style="width:80px;height:30px;" onclick="resetValue()"/>
							</td>-->
                            <td>
					<input type="submit" value="Login"  style="width:80px;height:30px;"  /> </td><td><input type="button" value="Reset" style="width:80px;height:30px;" onclick="resetValue()"/></td>                       

						</tr>
                                    

					</table>
				</div>

			</form>
		</div>
		<!-- main end -->

		<div class="footer">
			<ul>
				<li>
					<a target="_blank" href="#">Contract Management System</a>
				</li>
				<li>
					£ü
				</li>
				<li>
					<a target="_blank" href="#">Help</a>
				</li>
			</ul>

			<p>
				Copyright&nbsp;&copy;&nbsp;Ruanko COE&nbsp;
				<a href="http://www.ruanko.com" title="wwww.ruanko.com"
					target="_blank"><strong>www.ruanko.com</strong> </a>&nbsp;Copyright
				Reserved
			</p>
		</div>
	</body>
</html>