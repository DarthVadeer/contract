<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
<title>Contract Management System - Registrater page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
			<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
	</head>

	<body>
		<!-- header start -->
		<div class="header">
			<div class="toplinks">
				<span>[<a href="register.jsp">Register</a>][<a
					href="index.jsp">Login</a>]</span>
			</div>

			<h1>
				<img src="images/logo_title.png" alt="Contract Management System" />
			</h1>
		</div>
		<!-- header end -->

		<!-- main start -->
		<div class="main">
			  <form action="register" method="post">
				<div class="register_main">
					<table>
						<tr>
							<td class="title" colspan="2">
								User register
							</td>
						</tr>
						<tr>
							<td width="120" align="center">
								User name:
							</td>
							<td>
								<input type="text" name="userName" id="userName" value="${userName }" />
							</td>
						</tr>
						<tr>
							<td class="info" colspan="2">
								User name must begin with a letter, at least four words(letters,
								Numbers, underscores).
							</td>
						</tr>

						<tr>
							<td align="center">
								Password:
							</td>
							<td>
								<input type="password" name="password_1" id="password_1" value="${password_1 }" />
							</td>
						</tr>
						<tr>
							<td class="info" colspan="2">
								Password can not be too simple, at least contain six words;
								Recommend to use numbers and letters mixed arrangement,
								case-insensitive.
							</td>
						</tr>

						<tr>
							<td align="center">
								Repeat Password:
							</td>
							<td>
								<input type="password" name="password_2" id="password_2" value="${password_2 }" />
							</td>
						</tr>
						<tr>
							<td class="info" colspan="2">
								Repeat password and password should keep consistent!
							</td>
						</tr>
   <tr>
				
				<td>
					<font color="red">${error }</font>
				</td>
			        </tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="Submit" style="width:120px;height:30px;"  />
							</td>
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