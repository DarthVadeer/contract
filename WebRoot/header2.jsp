<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Contract Management System - Head</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		
		<link href="css/frame.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"> 
 function startTime(){ 
  var today=new Date() 
  var week=new Array("Sun","Mon","Tues","Wednes","Thurs","Fri","Satur"); 
  var Month=new Array("January","February","March","April","May","June","July","August","September","October","November","Dececmber");
var year=today.getFullYear()
  var month=today.getMonth() 
  var date=today.getDate() 
  var day=today.getDay() 
  var h=today.getHours() 
  var m=today.getMinutes() 
  var s=today.getSeconds() 
  // add a zero in front of numbers<10 
  h=checkTime(h) 
  m=checkTime(m) 
  s=checkTime(s) 
   document.getElementById('time').innerHTML=" "+week[day]+" "+Month[month]+" "+date+"  "+h+":"+m+":"+s+" "+"CST  "+year 

  t=setTimeout('startTime()',500) 
 } 
 
 function checkTime(i){ 
 if (i<10)  
   {i="0" + i} 
   return i 
 } 
</script> 
 </head>
<body onload="startTime()"> 
	
		<div class="header">
			<div class="toplinks">
					
				<span>Hello:</span><font color="red"><%=session.getAttribute("userName")%></font><span>Welcome to Contract Management System [<a href="index.jsp"
					target="_top">Logout</a>]</span>
					<br /><br /><br /><br /><br /><span id="Time">CurrentTime:</span><span id="time"></span>
			</div>
			<h1>
				<img src="images/logo_title.png" alt="Contract Management System" />
			</h1>
		</div>
	</body>
</html>
