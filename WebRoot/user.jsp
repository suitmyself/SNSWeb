<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
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
    <title>用户界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="user.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.flightBooked 
	{
		width: 80%;
		height: 100%;
		float: left;
		background-color: blue;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	</style>
</head>
<body>
  	<%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
  	<div class=flightBooked></div>
</body>
</html>
