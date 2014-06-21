<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="accessDB.jsp" %>
<% 
	try
	{
		String username1 = java.net.URLDecoder.decode(request.getParameter("fromUsername"), "UTF-8");
		String username2 = java.net.URLDecoder.decode(request.getParameter("toUsername"), "UTF-8");
		String message = java.net.URLDecoder.decode(request.getParameter("message"), "UTF-8");

		String sql = "SELECT * FROM friend_pair WHERE username1='"+username1+"' AND username2='"+username2+"'";
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.println("fail");
		}
		else
		{
		sql = "INSERT INTO add_friend_request(from_username, to_username, message) VALUES('"
				+ username1 + "','" + username2 + "','" + message + "')";
			stmt.executeUpdate(sql);
			out.print("success");
			out.print(message);
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
