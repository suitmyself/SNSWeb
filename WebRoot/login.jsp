<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Expires" content="0">
<meta http-equiv="kiben" content="no-cache">
<title>登录页面</title>
<style type="text/css">
.userID,.password
{
	padding: 7px 10px;
	width: 300px;
	height: 25px;
	line-height: 25px;
	/*border-radius: 3px;*/
	margin-right: 7px;
	border: 1px solid #BDC7D8;
}
.submit
{
	width: 100px;
	height: 43px;
	margin: 10px 0px;
	display: inline;
	cursor: pointer;
	color: blue;
	font-size: 18px;
	font-weight: 700;
	font-family: "微软雅黑";
	border: 1px solid #3B6E22;
	border-radius: 1px;
	background-color:#00FF00;
	position: relative;
	right: 50 px;
}
.register
{
	position: relative;
	bottom: -10px;
	color:red;
}
.login
{
	margin:7%;
}
body
{
	background-image:url(background.jpg);
}
</style>
<script type="text/javascript">
function check()
{
	
	var userID=document.getElementById("userID").value;
	var password=document.getElementById("password").value;
	if(userID==''||userID==null||password==null||password=='')
	{
		alert("项不能为空");
		return false;
	}
}
</script>
</head>
<body>

	<h1 align="center">SNS社交网站登录页面</h1>
	<center class="login">
		<form action="checkLogin.jsp" method="post" onsubmit="return check()">
		<div>
			用户 <input type="text" id="userID" name="userID" class="userID">
		</div>
		<br>
		<div>
			 密码 <input type="password" id="password" name="password" class="password"> 
		</div>
		<div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="登录" name="submit" class="submit" > &nbsp;&nbsp;&nbsp;&nbsp;<a class="register" href="register.jsp">注册</a> 
	   </div>
			
		</form>
	</center>

</body>
