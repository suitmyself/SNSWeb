<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  	<style type="text/css">
 	 .functionBlock
  	{
  		text-align:center;
  		border-radius:8px;
  		background-color:#505050;
  		width:15%;
  		/*height:700px;*/
  		float:left;
  		padding:20px;
  		line-height:50px;
  		margin:0;
 	 }
  
  	.functionBlock ul
  	{
  		display:block;
		margin-top:0;
		width:100%;  
		list-style-type:none;
		padding:0
  	}
  	.functionBlock li
  	{
    	display:block;
  	}
  
  	.functionBlock a:link,.functionBlock a:visited
 	{
  		display:block;
		padding:0px;
		margin:0;
		width:100%;
		height:50px;
		font-weight:bold;
		color:#FFF;
  	}
  
  .functionBlock a:hover,.functionBlock a:active
  {
		background-color:#F00;
  }
  .signature_
  {
  	/*color:red;*/
  	background-color:#AFEEEE;
  	padding:5px;
  	border-radius:5px;
  }

  </style>
  <script type="text/javascript">
  updateSystemMessage();

  setInterval("updateSystemMessage()", 30000);
  function updateSystemMessage() 
  {
    //alert("system message");
    send_request("GET","updateSystemMessage.jsp",
        		null,
        		"text",
        		showFeedbackInfo_sys_mes);
        //alert("docheck");
 }

	function showFeedbackInfo_sys_mes() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{   // 信息已经成功返回，开始处理信息
       			 //alert(http_request.responseText);
        		 if(http_request.responseText.indexOf("new")!=-1)//获得返回的内容
        		 {
        		 	document.getElementById("system_message_link").innerHTML=http_request.responseText;
        		 	alert("您有新消息，请进入系统消息查看!");
        		 }
        		//alert(http_request.responseText);
        	}
        	/*
        	else 
        	{ //页面不正常
          		alert("您所请求的页面有异常。");
        	}
        	*/
    	}
	}
  </script>
  <script type="text/javascript" src="ajax.js"></script>
  </head>

  <div class="functionBlock">
  	<span style="color:white">功能模块</span>
 	 <ul>
 	 	<li> <a href="user.jsp">个人中心</a> 
 	 	<li> <a href="changePassword.jsp">修改密码</a>
  	 	<li> <a href="personInformation.jsp">个人信息</a>
  	 	<li> <a href="addFriend.jsp">添加好友</a>
  	 	<li> <a href="friendManager.jsp">好友管理</a>
  	 	<li> <a href="systemMessage.jsp" >系统消息<span style="color:red;" id="system_message_link"></span></a>
  	 	
  	 </ul>
  	 <hr>
  	 <div class="signature_">
  	 	<h3>签名档</h3>
  	 	<div class="sig_content">
  	 	
  	<%@ include file="accessDB.jsp" %>
  	<% 
	try
	{
		String sql = "SELECT * FROM user_info where username='"+session.getAttribute("userID")+"'";
		ResultSet rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.print(rs.getString("signature"));
		}
		else
		{
			out.println("<h2>用户名不存在,可能登陆超时</h2>");
	   		out.println("<p>3秒后返回<a href='login.jsp' >登陆</a>页面！</p>");
	   	    String content=3+";URL="+"login.jsp";
	    	response.setHeader("REFRESH",content);
		}
		//STEP 6: Clean-up environment
		//rs.close();
		//stmt.close();
		//conn.close();
	}
	catch(SQLException se)
	{
		//Handle errors for JDBC
		out.println("<p>sorry,数据库错误</P>");
		se.printStackTrace();
	}
	catch(Exception e)
	{
		//Handle errors for Class.forName
		out.println("<p>sorry,数据库错误</P>");
		e.printStackTrace();
	}
	/*
	finally
	{
		//finally block used to close resources
		try
		{
			
			if(stmt!=null)
			{
				stmt.close();
			}
			
		}
		catch(SQLException se2)
		{
			out.println("<p>sorry,数据库错误</P>");
		}// nothing we can do
		try
		{
			 if(conn!=null)
			 {
				conn.close();
			 }
		}
		catch(SQLException se)
		{
			out.println("<p>sorry,数据库错误</P>");
			se.printStackTrace();
		}
	}
	*/
%>
  	 	</div>
  	 </div>
  </div>
