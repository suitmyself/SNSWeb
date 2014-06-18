
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<% 
	if(request.getParameter("userID").equals("")||request.getParameter("userID")==null||request.getParameter("userID").length()==0)
	{
   		out.println("空值");
		return;
	}
%>

<%@ include file="accessDB.jsp" %>
<%
	try {
		String sql;
		sql = "SELECT * FROM account where username='"+request.getParameter("userID")+"' OR email='"+request.getParameter("email")+"'";
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.println("error:此用户名或邮箱已经被注册");
		}
		else
		{
			out.println("帐户和用户名未被注册");
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
  
  
 


