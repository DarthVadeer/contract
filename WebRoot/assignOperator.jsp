<%@ page language="java" import="java.util.*" import="com.ruanko.utils.DbUtil" import="java.sql.PreparedStatement" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ page contentType="text/html;charset=gb2312"%> 
<% java.sql.Connection sqlCon; //数据库连接对象  
java.sql.ResultSet sqlRst; //结果集对象  
java.sql.ResultSet sqlRst_1; //结果集对象  
java.sql.ResultSet sqlRst_2; //结果集对象
java.lang.String sql; //SQL语句  
int i;   

//装载JDBC驱动程序  
Class.forName("com.mysql.jdbc.Driver").newInstance();  
//连接数据库  
sqlCon= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/Contract","root","huzi");  
  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Assign operator</title>
		<link href="css/style.css" rel="stylesheet" media="screen"
			type="text/css" />
		<script type="text/javascript">
			function moveOption(s1,s2){
				// Cteate cache array to store value and text
				var arrSelValue = new Array();  
				var arrSelText = new Array();  
				// This array stores the selected options, corresponding to value
				var arrValueTextRelation = new Array();  
				var index = 0;// Assist to establish the cache array
				  
				// Store all data in the source list to the cache, and establish the corresponding relationship of value and selected option 
			   for ( var i = 0; i < s1.options.length; i++) {  
					if (s1.options[i].selected) {  
						arrSelValue[index] = s1.options[i].value;  
						arrSelText[index] = s1.options[i].text;  
						// Build the corresponding relationship of value and selected option
						arrValueTextRelation[arrSelValue[index]] = s1.options[i];  
						index++;  
					}  
				}  
		  
				// Increase cache data to purpose list, and delete the corresponding item in source list  
				for ( var i = 0; i < arrSelText.length; i++) {  
					var oOption = document.createElement("option");  
					oOption.text = arrSelText[i];  
					oOption.value = arrSelValue[i];  
					s2.add(oOption);
					s2.options[i].selected=true;  
					// Delete the corresponding item in source list
					s1.removeChild(arrValueTextRelation[arrSelValue[i]]);  
				} 
			}
			
			//Judgment whether user has assigned operator, if does not assign, giving prompt message; Or submit form to assign operator
			function check(){
				// Build cache array to store assigned operator
      		   	var assignedOperator = new Array(3); 
				assignedOperator[0] = document.assignOperForm.hqht;
				assignedOperator[1] = document.assignOperForm.spht;
				assignedOperator[2] = document.assignOperForm.qdht;

				// If there is no assigned operator, giving a prompt message
				if((assignedOperator[0].length) < 1){
					alert("Please assign countersign people!");
					return false;
				} 
				
				if((assignedOperator[1].length) < 1){
					alert("Please assign approver!");
					return false;
				} 
				
				if((assignedOperator[2].length) < 1){
					alert("Please assign signer!");
					return false;
				} 
			}
		</script>
	</head>
	<body>
<%
	//获得该合同的合同ID,并将ID传到后台servlet  AssignContract
		  String ID_1=request.getParameter("c_ID");
		  request.setCharacterEncoding("gbk"); 
		
		 session.setAttribute("CONTRACTID_1",ID_1);
		 %>
	<%
	sql="select userName from user where id not in(select user_id from u_right where rol_id=1 group by user_id) and id<>(select user_id from contract where id='"+ID_1+"') and id in(select user_id from u_right group by user_id) group by username";
   PreparedStatement pstmt=sqlCon.prepareStatement(sql);
//执行SQL语句并获取结果集  
sqlRst = pstmt.executeQuery();  
%>
		<div class="mtitle">
Assign operator: 
		</div>
		
		<br />
		
	 <form name="assignOperForm" action="assigncontract" method="post">
			<h3>
				<img src="images/cog_edit.png"  alt="Assign countersign people" />
				Assign countersign operator
			</h3>
			<table border="0" width="400" class="update"> 
				<tr>
					<td width="45%"> 
						operator to be assigned: 
						
						<select style="WIDTH:100%" Multiple = "multiple" name="dfphqht" size="12"> 
						<%  sqlRst.first();  while(!sqlRst.isAfterLast()){%><option value="<%=sqlRst.getString(1)%>"><%=sqlRst.getString(1)%></option> 
						<% sqlRst.next();  
}  

%> 
						</select> 
					</td> 
					<td width="10%" align="center"> 
						<input type="button" value="&gt&gt" 
					onclick="moveOption(document.assignOperForm.dfphqht, document.assignOperForm.hqht)">
						<br/> <br/> 
						<input type="button" value="&lt&lt" 
					onclick="moveOption(document.assignOperForm.hqht, document.assignOperForm.dfphqht)"> 
					</td> 
					<td width="45%"> 
						assigned operator:
				<select style="WIDTH:100%" Multiple = "multiple" name="hqht" size="12"> 						</select> 
					</td> 
				</tr> 				
			</table> 
			<br />
			<h3>
				<img src="images/cog_edit.png"  alt="Assign approver" />
				Assign approver
			</h3>
			<table border="0" width="400"  class="update"> 
				<tr>
					<td width="45%"> 
						operator to be assigned: 
						<select style="WIDTH:100%" Multiple = "multiple" name="dfpspht" size="12"> 
								<%  sqlRst.first();  while(!sqlRst.isAfterLast()){%><option  value="<%=sqlRst.getString(1)%>"><%=sqlRst.getString(1)%></option> 
						<% sqlRst.next();  
}  

%> 
						</select> 
					</td> 
					<td width="10%" align="center"> 
						<input type="button" value="&gt&gt" 
					onclick="moveOption(document.assignOperForm.dfpspht, document.assignOperForm.spht)">
						<br/> <br/> 
						<input type="button" value="&lt&lt" 
					onclick="moveOption(document.assignOperForm.spht, document.assignOperForm.dfpspht)"> 
					</td> 
					<td width="45%"> 
						assigned operator:
						<select style="WIDTH:100%" Multiple = "multiple" name="spht" size="12"> 						</select> 
					</td> 
				</tr> 				
			</table>
			<br />
			
				<%
	String sql_1="select userName from user where id not in(select user_id from u_right where rol_id=1 group by user_id) and id in(select user_id from u_right group by user_id) group by username";
   PreparedStatement pstmt_2=sqlCon.prepareStatement(sql_1);
//执行SQL语句并获取结果集  
 sqlRst_2 = pstmt_2.executeQuery();  
			%>
			<h3>
				<img src="images/cog_edit.png"  alt="Assign signer" />
				Assign signer
			</h3>
			<table border="2" width="400"  class="update"> 
				<tr>
					<td width="45%"> 
						operator to be assigned: 
						<select style="WIDTH:100%" Multiple = "multiple" name="dfpqdht" size="12"> 
								<%  sqlRst_2.first();  while(!sqlRst_2.isAfterLast()){%><option value="<%=sqlRst_2.getString(1)%>"><%=sqlRst_2.getString(1)%></option> 
						<% sqlRst_2.next();  
}  

%> 						</select> 
					</td> 
					<td width="10%" align="center"> 
						<input type="button" value="&gt&gt" 
					onclick="moveOption(document.assignOperForm.dfpqdht, document.assignOperForm.qdht)">
						<br/> <br/> 
						<input type="button" value="&lt&lt" 
					onclick="moveOption(document.assignOperForm.qdht, document.assignOperForm.dfpqdht)"> 
					</td> 
					<td width="45%"> 
						assigned operator:
						<select style="WIDTH:100%" Multiple = "multiple" name="qdht" size="12"> 
						</select> 
					</td> 
				</tr> 				
			</table>
			<table width="400" class="update"> 
				<tr>
					<td colspan="2" style="text-align:center;">
				<input type="submit" value="Submit" class="button" onclick="return check()"> &nbsp; &nbsp; &nbsp; 
				<input type="reset" value="Reset" class="button">
				</td>
				</tr>
			</table>
			<br/>
		</form> 
	</body>
</html>

