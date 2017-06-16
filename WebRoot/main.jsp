<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Contract Management - Administrator page</title>
		<!-- 权限验证 -->
		<%if(session.getAttribute("currentUser")==null) 
		{
		response.sendRedirect("index.jsp");
		return;
		}%>
		<link href="css/frame.css" rel="stylesheet" 
			type="text/css" />
	</head>

	<!-- Frame structure:upper, middle (left, right), under-->
	<frameset rows="100,*,70" frameborder="no" border="0">
		<frame src="header2.jsp"  scrolling="no"/>
		<frameset cols="200,*">
			<frame src="left1.jsp"  scrolling="no"/>
			<frame src="welcome.jsp"  name="main"  scrolling="auto"/>
		</frameset>
		<frame src="footer2.jsp" scrolling="no"/>
	</frameset>
	<!-- Set prompt message for browser that does not support Frame structure-->
	<noframes>
		<body>
			Your browser does not support frame structure!
		</body>
	</noframes>
</html>
