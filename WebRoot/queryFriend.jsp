<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
  	.addButton
  	{
  		/*height: 30px;*/
		margin-left: 10px;
		adding: 0px 30px;
		display: inline-block;
        font-size: 14px;
        line-height: 28px;
        color: #666;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		/*background: linear-gradient(to bottom, #FEFEFE 0px, #F8F8F8 100%) repeat scroll 0% 0% #FBFBFB;*/
		border: 1px solid #A7ACB5;
		border-radius: 3px;
		box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.15);
		/*position: relative;*/
		/*bottom: 10px;*/
		/*float: right;*/
		/*margin-right: 29px;*/
  	}
    </style>
	<script type="text/javascript" src="ajax.js"></script>
   
</head>
<% 
	//System.out.println("querytype:"+request.getParameter("queryType"));
	String queryText = java.net.URLDecoder.decode(request.getParameter("queryText"), "UTF-8");
	if((!request.getParameter("queryType").equals("all"))&&(queryText.equals("")||queryText==null||queryText.length()==0))
	{
   		out.println("输入为空值");
		return;
	}
%>
<%@ include file="accessDB.jsp" %>
<%
	try
	{
		String sql=" ";
		
		if(request.getParameter("queryType").equals("all"))
		{
			System.out.println("all 已被执行");
			sql = "SELECT * FROM user_info ";
		}
		if(request.getParameter("queryType").equals("username"))
		{
			sql = "SELECT * FROM user_info where username='"+queryText+"'";
		}
		if(request.getParameter("queryType").equals("university"))
		{
			sql = "SELECT * FROM user_info where university='"+queryText+"'";
		}
		if(request.getParameter("queryType").equals("school"))
		{
			sql = "SELECT * FROM user_info where school='"+queryText+"'";
		}
		if(request.getParameter("queryType").equals("major"))
		{
			sql = "SELECT * FROM user_info where major='"+queryText+"'";
		}
		
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		int count=0;
		out.println("<table>");
		out.println("<tr>");
	    out.println("<th>用户名</th> <th>姓名</th> <th>学校</th> <th>学院</th> <th>专业</th><th>加为好友</th>");
	    out.println("</tr>");
		while(rs.next()) 
		{
			++count;
	        out.println("<tr>");
	        out.println("<td>"+rs.getString("username")+"</td> ");
	        out.println("<td>"+rs.getString("realname")+"</td> ");
	        out.println("<td>"+rs.getString("university")+"</td> ");
	        out.println("<td>"+rs.getString("school")+"</td> ");
	        out.println("<td>"+rs.getString("major")+"</td> ");
	        out.println("<td>");
	        Statement stmt2 = conn.createStatement();
	        sql= "select * from friend_pair where username2 ='"+rs.getString("username")+"' and username1 ='"+session.getAttribute("userID")+"'";
	        ResultSet rs2 =stmt2.executeQuery(sql);
	        if(rs.getString("username").equals(session.getAttribute("userID")))
	        {
	        %>
	        	<input type="button" class="addButton" value="自己" id="<%= rs.getString("username")%>" disabled onclick="addFriendFunc(this)" style="background-color: #FF4500">
	        <%
	        }
	        else if(!rs2.next())
	        {
	        %>
	        	<input type="button" class="addButton" value="加为好友" id="<%= rs.getString("username")%>" onclick="addFriendFunc(this)">
	        <% 
	        }
	        else
	        {
	        %>
	        	<input type="button" class="addButton" value="已是好友" id="<%= rs.getString("username")%>" disabled onclick="addFriendFunc(this)" style="background-color: #FF4500">
	        <% 
	        }
	        out.println("</td>");
	        out.println("</tr>");	
		}
		out.println("</table>");
		if(count == 0 )
		{
			out.println("搜索结果为空");
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
