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
    </style>
    
	<script type="text/javascript">
	function addFriendFunc(thisButton) 
	{
		//alert("add_ajax");
		alert("called");
        send_request("GET","addFriend_ajax.jsp?fromUsername="+"<%= session.getAttribute("userID")%>"
        			+"&toUsername="+thisButton.id,
        			null,
        			"text",
        			showFeedbackInfo2);
	}

	function showFeedbackInfo2() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{    // 信息已经成功返回，开始处理信息
       			 //alert(http_request.responseText.replace(/(^\s*)(\s*$)/g,""));        //需注意，利用这种方式可以查看返回的内容，alert()是一个用来调试的很好的函数，
        		 var message=http_request.responseText;
        		 var i=message.indexOf("success");
        		 if(message.indexOf("success")!=-1)//获得返回的内容
        		 {
        		 	alert("请求已经发送");
        		 }
        		 else if(message.indexOf("fail")>=0)//获得返回的内容
        		 {
        		 	alert("失败");
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
<% 
	//System.out.println("querytype:"+request.getParameter("queryType"));
	if((!request.getParameter("queryType").equals("all"))&&(request.getParameter("queryText").equals("")||request.getParameter("queryText")==null||request.getParameter("queryText").length()==0))
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
			sql = "SELECT * FROM user_info where username='"+request.getParameter("queryText")+"'";
		}
		if(request.getParameter("queryType").equals("university"))
		{
			sql = "SELECT * FROM user_info where university='"+request.getParameter("queryText")+"'";
		}
		if(request.getParameter("queryType").equals("school"))
		{
			sql = "SELECT * FROM user_info where school='"+request.getParameter("queryText")+"'";
		}
		if(request.getParameter("queryType").equals("major"))
		{
			sql = "SELECT * FROM user_info where major='"+request.getParameter("queryText")+"'";
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
	        if(!rs2.next())
	        {
	        %>
	        	<input type="button" value="加为好友" id="<%= rs.getString("username")%> " onclick="addFriendFunc(this)">
	        <% 
	        }
	        else
	        {
	        %>
	        	<input type="button" value="已是好友" id="<%= rs.getString("username")%> " disabled onclick="addFriendFunc(this)">
	        <% 
	        }
	        out.println("</td>");
	        out.println("</tr>");	
		}
		out.println("</table");
		if(count ==0 )
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
