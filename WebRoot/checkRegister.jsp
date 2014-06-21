<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv = "Content-Type" content = "text/html; charset=utf-8">
	<meta http-equiv = "Expires" content = "0">
	<meta http-equiv = "kiben" content = "no-cache">
	<title>检验注册</title>
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
<center>
<h1>检验注册页面</h1>

<%@ include file="accessDB.jsp" %>
<% 
   try{
		String sql;
		sql = "SELECT * FROM account where username='"+java.net.URLDecoder.decode(request.getParameter("userID"), "UTF-8")+"' OR email='"+java.net.URLDecoder.decode(request.getParameter("email"), "UTF-8")+"'";
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
			out.println("<h2>error:用户名已经被注册或邮箱已被注册。</h2>");
			out.println("<p><span id='timing'>5</span>秒后返回<a href='register.jsp'>注册</a>页面！！</p>");
	    	String content=5+";URL="+"register.jsp";
	    	response.setHeader("REFRESH",content);	   
		}
		else
		{
			String username=java.net.URLDecoder.decode(request.getParameter("userID"), "UTF-8");
			String password=java.net.URLDecoder.decode(request.getParameter("password"), "UTF-8");
			String email=java.net.URLDecoder.decode(request.getParameter("email"), "UTF-8");
			sql="insert into account values ('"+username+"','"+password+"','"+"Un Know"+"','"+email+"')";
			System.out.println(sql);
			Statement stmt2 = conn.createStatement();
			stmt2.executeUpdate(sql);
			sql="insert into user_info values('"+username+"',"+"null"+",'1',"+
											 "null,"+"null,"+"null,"+"null,"+"null,"+
											 "null,"+"null,"+"null"+")";
			Statement stmt3 = conn.createStatement();
			stmt3.executeUpdate(sql);
			
			sql="insert into system_message(status,content,to_username) values(0,'"+username
				+",welcome to our SNS webSite, the webSite is designed by WeiChen and HanDong, enjoy it and good luck!','"
				+username+"')";
			stmt3.executeUpdate(sql);

			out.println("<h2>检测到用户名未被注册</h2>");
			out.println("<h2>注册成功</h2>");
	   		out.println("<p><span id='timing'>5</span>秒后返回<a href='login.jsp' >登陆</a>页面！</p>");
	    	String content=5+";URL="+"login.jsp";
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
		}
		try
		{
		 	if(conn!=null)
				conn.close();
		}
		catch(SQLException se)
		{
			out.println("<p>sorry,数据库错误</P>");
			se.printStackTrace();
		}//end finally try
	}//end try
%>

<hr/>
<h2>用户注册信息</h2>
<table>
	<tr> <td>name</td>     <td><%= java.net.URLDecoder.decode(request.getParameter("userID"), "UTF-8")%>   </td></tr>
	<tr> <td>email</td>    <td><%= java.net.URLDecoder.decode(request.getParameter("email"), "UTF-8")%>	  </td></tr>
</table>
</center>
</body>
</html>
