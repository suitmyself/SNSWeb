<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
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
		String sql;
		String username1=new String(request.getParameter("fromUsername"));
		String username2=new String(request.getParameter("toUsername"));
		/*
		if(username1.compareTo(username2)>0)
		{
			String temp=username1;
			username1=username2;
			username2=temp;
		}
		*/
		sql = "SELECT * FROM friend_pair where username1='"+username1+"' AND username2='"+username2+"'";
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.println("fail");
		}
		else
		{
			sql = "INSERT INTO add_friend_request(from_username,to_username,message) Values('"
				+request.getParameter("fromUsername")+"','"
				+request.getParameter("toUsername")+"','"
				+request.getParameter("message")+"')";
			stmt.executeUpdate(sql);
			out.print("success");
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
  
