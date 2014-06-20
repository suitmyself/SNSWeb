<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	if (session.isNew() || session.getAttribute("userID") == null)
	{
		response.sendRedirect("login.jsp");
		System.out.println("转向到登录页面");
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>修改密码</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="user.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style type="text/css">
    .changePass
	{
		width: 80%;
		height: 100%;
		float: left;
		background-color: #D9D9D9;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
    .oldPassword,.newPassword,.passwordRepeat
	{
		padding: 7px 10px;
		width: 300px;
		height: 40px;
		line-height: 25px;
		border-radius: 3px;
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
	
    </style>
    
    <script type="text/javascript">
    function check()
    {
    	if(document.getElementById("newPassword").value != document.getElementById("passwordRepeat").value)
    	{
    		alert("两次密码不一致");
    		return false;
    	}
    }
    </script>
  </head>
  
  <body>
  	<%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
      	<div class="changePass">
	<center class="login">
		<h1 align="center">修改密码</h1>
		<form action="checkPasswordChange.jsp" method="post" onsubmit="return check()">
		<div>
			原密码 <input type="password" id="oldPassword" name="oldPassword" class="oldPassword">
		</div>
		<br>
		<div>
			新密码 <input type="password" id="newPassword" name="newPassword" class="newPassword">
		</div>
		<br>
		<div>
			 第二遍 <input type="password" id="passwordRepeat" name="passwordRepeat" class="passwordRepeat"> 
		</div>
		<div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="修改" name="submit" class="submit" > 
	   </div>
	   </form>
	</center>
  	</div> 
  </body>
</html>
