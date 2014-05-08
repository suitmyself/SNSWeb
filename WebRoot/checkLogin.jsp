<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>checkLogin</title>
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
<% 
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost/t_sns";
	//  Database credentials
	String USER = "root";
	String PASS = "wei13755030514";
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
		String sql;
		sql = "SELECT * FROM account where username='"+request.getParameter("userID")+"'";
		ResultSet rs = stmt.executeQuery(sql);
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			if(rs.getString("password").equals(request.getParameter("password")))
			{
				session.setAttribute("userID",request.getParameter("userID"));
				out.println("<h2>验证正确</h2>");
				out.println("<p><span id='timing'>3</span>秒后返回<a href='user.jsp' >用户</a>页面！</p>");
		    	String content=3+";URL="+"user.jsp";
		    	response.setHeader("REFRESH",content);
			}
			else
			{
				out.println("<h2>密码错误</h2>");
		    	out.println("<p><span id='timing'>3</span>秒后返回<a href='login.jsp' >登陆</a>页面！</p>");
		    	String content=3+";URL="+"login.jsp";
		    	response.setHeader("REFRESH",content);
			} 
		}
		else
		{
			out.println("<h2>用户名不存在</h2>");
	   		out.println("<p>3秒后返回<a href='login.jsp' >登陆</a>页面！</p>");
	   	    String content=3+";URL="+"login.jsp";
	    	response.setHeader("REFRESH",content);
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
</body>
</html>