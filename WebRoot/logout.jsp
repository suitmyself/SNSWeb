<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>注销页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="logout.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.container
	{
	    border-radius:8px;
		border: 1px solid #BDC7D8;
		background-color:red;
		position:absolute;
		width:30%;
		height:150px;
		text-align:center;
		left:40%;   
        top:30%; 
	}
	</style>
	
	<script type="text/javascript"> //倒计时
		var t;
		function timeCount()
		{
			document.getElementById("timing").innerHTML=document.getElementById("timing").innerHTML-1;
			t=setTimeout("timeCount()",1000);
		}
	</script>
  
</head>
  <body onload="timeCount()">
    <%@include file="navigator.jsp" %>
    <div class="container">
    <br>
      	 已注销，谢谢使用！
    <br>
    <% 
   		out.println("<p><span id='timing'>5</span>秒后返回<a href='login.jsp' >登录</a>页面！</p>");
		String content=5+";URL="+"login.jsp";
		session.invalidate();
		//response.setHeader("control","no-cache");
		response.setHeader("REFRESH",content);
	%>
    </div>
  </body>
</html>







