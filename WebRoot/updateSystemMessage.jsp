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

		String sql = "SELECT * FROM system_message where to_username='"+session.getAttribute("userID")+"' AND status=0";
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.print("new");
		}
		else
		{
			sql = "SELECT * FROM add_friend_request where to_username='"+session.getAttribute("userID")+"' AND (status is null or status = 0) ";
			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				out.print("new");
			}
			else
			{
				out.print("old");
			}

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