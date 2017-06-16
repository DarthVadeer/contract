<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<title>Draft contract</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
				<script type="text/javascript">   			
	function resetValue(){
		document.getElementById("contractName").value="";
		document.getElementById("customerName").value="";
	    document.getElementById("beginTime").value="";
		document.getElementById("endTime").value="";
	    document.getElementById("content").value="";

	}
	function Trim(str)
{
 var tmpStr = new String(str);
 return tmpStr.replace(/(^\s*)|(\s*$)/g, "");
}
	
      function check(){
        var contractName=document.getElementById("contractName").value ;
          var customerName=document.getElementById("customerName").value ;
            var beginTime=document.getElementById("beginTime").value ;
              var endTime=document.getElementById("endTime").value ;
               var content=document.getElementById("content").value ;
               
  var ContractName=Trim(contractName);
  if(ContractName==""){
alert("ContractName内容不能为空！"); 
myform.contractName.focus();
return false;
  }
   var CustomerName=Trim(customerName);
  if(CustomerName==""){
alert("CustomerName内容不能为空！"); 
myform.customerName.focus();
return false;
  } 
  var BeginTime=Trim(beginTime);
  if(BeginTime==""){
alert("beginTime内容不能为空！"); 
myform.beginTime.focus();
return false;
  }

   var EndTime=Trim(endTime);
  if(EndTime==""){
alert("endTime内容不能为空！"); 
myform.endTime.focus();
return false;
  }

  var Content=Trim(content);
  if(Content==""){
alert("content内容不能为空！"); 
myform.content.focus();
return false;
  }

 }  
       
  		</script>
	</head>

	<body>
		<div class="mtitle"> 
			Draft Contract 
		</div>
		<br />

		<form action="draftcontract" method="post" onSubmit="return check(this)" name="myform">
		
		<%
			request.setCharacterEncoding("gbk"); 
			String user="";
			//从后台获取该用户名字
			String username=(String)request.getAttribute("userNAME");
			//判断后台若为空，则用前台页面传的用户的值，并判断正常编码格式取值是否为空，才能按GBK编码格式获取
			if(request.getAttribute("userNAME")==null){
			
			if(request.getParameter("username")!=null)
			
	 user=new String(request.getParameter("username").getBytes("ISO-8859-1"),"gbk"); 
	 }
	 
	 if(user==null)
	 session.setAttribute("username_1",username);
	 else
		session.setAttribute("username_1",user); 
		
		
		%>
			<table class="update" style="width:700px;">
				<tr height="28">
					<td width="140px">Contract name:</td>
					<td><input type="text" value="${contractName }" name="contractName" id="contractName"/><font color="red">&nbsp;&nbsp;*</font>
					</td>
				</tr>

				<tr height="28">
					<td>Customer:</td>
					<td><input type="text" name="customerName" value="${customerName}" id="customerName" /><font color="red">${error}</font>
					</td>
				</tr>
				<tr>
					<td>Begin time:</td>	
					<td><input type="text" id="beginTime" name="beginTime" value="${beginTime}" /><font color="red">${error2}</font>
					</td>
				</tr>
				<tr>
					<td>End time:</td>	
					<td><input type="text" id="endTime" name="endTime" value="${endTime}"/><font color="red">${error3}</font>
					</td>
				</tr>
				<tr>
					<td>Content:</td>	
					<td><font color="red">&nbsp;&nbsp;*</font>
					</td>
				</tr>

				<tr>
					<td colspan="2">
					
			<!-- 用el获取content内容不会出现错位 -->		
	<textarea rows="40" cols="100" name="content"  id="content" style="width:680px;height:400px;">${content}</textarea>			
	
					</td>
					
				</tr>
				<tr height="28">
					<td>Attachment:</td>
					<td><input type="file" /></td>
				</tr>
				<tr height="28">
					<td align="center" colspan="2">
						<input type="submit" value="Submit" class="button" >
						 &nbsp; &nbsp; &nbsp;
						<input type="reset" value="Reset" onclick="resetValue()" class="button">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
