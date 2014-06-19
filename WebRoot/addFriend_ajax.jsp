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
		String sql = "SELECT * FROM friend_pair where username1='"+username1+"' AND username2='"+username2+"'";
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
			String message = request.getParameter("message");
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
