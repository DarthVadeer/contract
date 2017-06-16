<%@ page language="java" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<title>Contract Management System - Operator menu bar</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		
		<link href="css/frame.css" rel="stylesheet" type="text/css" />
	</head>

	<body>
	<%  
	 %>
		<div class="menu">
			<dl>
				<dt>
					Draft
				</dt>
				<dd>
					<a href="addContract.jsp?username=<%=session.getAttribute("currentUsername")%>" target="main">Draft Contract</a>
				</dd>
				<dd>
					<a href="ddghtList.jsp?username_1=<%=session.getAttribute("currentUsername")%>" target="main">Contract to be finalized</a>
				</dd>
				<dd>
					<a href="ydghtList.jsp?username_4=<%=session.getAttribute("currentUsername") %>" target="main">Finalized Contract</a>
				</dd>
				<dd>
					<a href="Queryprocess_operator.jsp?username_9=<%=session.getAttribute("currentUsername") %>" target="main">Query Process</a>
				</dd>
			</dl>
			<dl>
				<dt>
					Countersign
				</dt>
				<dd>
					<a href="dhqhtList.jsp?username_2=<%=session.getAttribute("currentUsername")%>" target="main">Contract to be countersigned</a>
				</dd>
				<dd>
					<a href="yhqhtList.jsp?username_3=<%=session.getAttribute("currentUsername")%>" target="main">Countersigned Contract</a>
				</dd>
			</dl>
			<dl>
				<dt>
					Approve
				</dt>
				<dd>
					<a href="dshphtList.jsp?username_5=<%=session.getAttribute("currentUsername")%>" target="main">Contract to be approved</a>
				</dd>
				<dd>
					<a href="yshphtList.jsp?username_6=<%=session.getAttribute("currentUsername") %>" target="main">Approved Contract</a>
				</dd>
			</dl>
			<dl>
				<dt>
					Sign
				</dt>
				<dd>
					<a href="dqdhtList.jsp?username_7=<%=session.getAttribute("currentUsername")%>" target="main">Contract to be signed</a>
				</dd>
				<dd>
					<a href="yqdhtList.jsp?username_8=<%=session.getAttribute("currentUsername")%>" target="main">Signed Contract</a>
				</dd>
			</dl>
		</div>
	</body>
</html>
