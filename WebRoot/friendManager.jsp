<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
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
    <title>好友管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="user.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.friendManager
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
	<style type="text/css">
    table
    {
  		font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
  		width:80%;
  		border-collapse:collapse;
  	}

	td,  th 
  	{
  		font-size:1em;
  		border:1px solid #98bf21;
 		padding:3px 7px 2px 7px;
 		width: 40px;
  	}

	th 
  	{
 		font-size:1.1em;
  		text-align:left;
  		padding-top:5px;
  		padding-bottom:4px;
  		background-color:#A7C942;
  		color:#ffffff;
  	}

    </style>
	<script type="text/javascript">
	function deleteFriend(thisButton) 
	{
		alert("delete");
		send_request("GET","deleteFriend.jsp?username1="+"<%= session.getAttribute("userID")%>"
        			+"&username2="+thisButton.id,
        			null,
        			"text",
        			showFeedbackInfo);
	}

	function showFeedbackInfo() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{    // 信息已经成功返回，开始处理信息
       			 alert("已经返回");
        		 var message=http_request.responseText;
        		 var i=message.indexOf("success");
        		 if(message.indexOf("success")!=-1)//获得返回的内容
        		 {
        		 	alert("好友已经删除");
        		 	location.reload();
        		 }
        		 else
        		 {
        		 	alert("未知原因失败，可能是数据库出误");
        		 	var mess=http_request.responseText;
        		 	alert(mess.length);	
        		 }
        	}
    	}
	}
	</script>
	<script type="text/javascript" src="ajax.js"></script>
	
</head>
<body>
    <%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
  	<div class=friendManager>
  	<center>
  	<% 
	//System.out.println("querytype:"+request.getParameter("queryType"));
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost/t_sns";
	//  Database credentials
	String USER = "sns_admin";
	String PASS = "CalRybMid3";   //此部分请注意修改密码
	Connection conn = null;
	Statement stmt = null;
	try
	{
	
		//STEP 2: Register JDBC driver
		Class.forName("com.mysql.jdbc.Driver");	   
		//STEP 3: Open a connection
		System.out.println("Connecting to database...");
		conn = DriverManager.getConnection(DB_URL,USER,PASS);

		//STEP 4: Execute a query
		System.out.println("Creating statement...");
		stmt = conn.createStatement();
		
		String sql="select * from friend_pair,user_info where "
					+"friend_pair.username1='"+session.getAttribute("userID")+"'"
					+"and friend_pair.username2 = user_info.username";
	    System.out.println(sql);
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.println("<table>");
	        out.println("<tr>");
	        out.println("<th>用户名</th> <th>姓名</th> <th>学校</th> <th>学院</th> <th>专业</th><th>删除好友</th>");
	        out.println("</tr>");
	        out.println("<tr>");
	        out.println("<td>"+rs.getString("username")+"</td> ");
	        out.println("<td>"+rs.getString("realname")+"</td> ");
	        out.println("<td>"+rs.getString("university")+"</td> ");
	        out.println("<td>"+rs.getString("school")+"</td> ");
	        out.println("<td>"+rs.getString("major")+"</td> ");
	        out.println("<td>");
	        %>
	        <input type="button" value="删除好友" id="<%= rs.getString("username")%>" onclick="deleteFriend(this)">
	        <% 
	        out.println("</td>");
	        out.println("</tr>");
	        while(rs.next())
	        {
	        	out.println("<tr>");
	        	out.println("<td>"+rs.getString("username")+"</td> ");
	        	out.println("<td>"+rs.getString("realname")+"</td> ");
	        	out.println("<td>"+rs.getString("university")+"</td> ");
	        	out.println("<td>"+rs.getString("school")+"</td> ");
	        	out.println("<td>"+rs.getString("major")+"</td> ");
	        	out.println("<td>");
	       	    %>
	        	<input type="button" value="删除好友" id="<%= rs.getString("username")%> " onclick="deleteFriend(this)">
	        	<% 
	        	out.println("</td>");
	        	out.println("</tr>");
	        }
	        
			out.println("</table");
		}
		else
		{
			out.println("你还没有好友哦");
		}

		//STEP 6: Clean-up environment
		rs.close();
		stmt.close();
		conn.close();
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
		finally
		{
			//finally block used to close resources
			try
			{
				if(stmt!=null)
					stmt.close();
			}
			catch(SQLException se2)
			{
				out.println("<p>sorry,数据库错误</P>");
			}// nothing we can do
			try
			{
		 		if(conn!=null)
					conn.close();
			}
			catch(SQLException se)
			{
				out.println("<p>sorry,数据库错误</P>");
				se.printStackTrace();
			}
		}
	%>
	</center>
  	</div>
</body>
</html>