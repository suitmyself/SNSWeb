<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
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
		if(request.getParameter("status").equals("1"))
		{
			sql = "update add_friend_request set status = 1 where request_id = "+request.getParameter("request_id");
			stmt.executeUpdate(sql);
			sql = "select * from add_friend_request where request_id = "+request.getParameter("request_id");
			ResultSet rs=stmt.executeQuery(sql);
			rs.next();
			String username1=rs.getString("from_username");
			String username2=rs.getString("to_username");
			sql ="insert into friend_pair(username1,username2)values('"+username1+"','"+username2+"')";
			stmt.executeUpdate(sql);
			if(request.getParameter("addFriend").equals("1"))
			{
				sql ="insert into friend_pair(username1,username2)values('"+username2+"','"+username1+"')";
				stmt.executeUpdate(sql);
			}
			sql ="insert into system_message(status,content,to_username)values(0,'"+
				 username2+" now is your friend!!! Remerber to contact with him/her!','"+username1+"')";
			stmt.executeUpdate(sql);
			
			sql ="insert into system_message(status,content,to_username)values(0,'"+
				 username1+" now is your friend!!! Remerber to contact with him/her!','"+username2+"')";
			stmt.executeUpdate(sql);
			out.print("accept");
		}
		else if(request.getParameter("status").equals("-1"))
		{
			sql = "update add_friend_request set status = -1 where request_id = "+request.getParameter("request_id");
			stmt.executeUpdate(sql);
			sql = "select * from add_friend_request where request_id = "+request.getParameter("request_id");
			ResultSet rs=stmt.executeQuery(sql);
			rs.next();
			String username1=rs.getString("from_username");
			String username2=rs.getString("to_username");
			sql ="insert into system_message(status,content,to_username)values(0,'"+
				 username2+" reject your friend-adding request','"+username1+"')";
			stmt.executeUpdate(sql);
			out.print("reject");
		}
		else
		{
			out.println("参数未匹配成功");
		}

		//STEP 6: Clean-up environment
		//rs.close();
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