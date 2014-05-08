<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*;"%>
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
<% 
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost:3306/t_sns";
	//  Database credentials
	String USER = "sns_admin";
	String PASS = "CalRybMid3" ;
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
		sql = "SELECT * FROM account where username='"+request.getParameter("userID")+"' OR email='"+request.getParameter("email")+"'";
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
			String username=request.getParameter("userID");
			String password=request.getParameter("password");
			String email=request.getParameter("email");
			sql="insert into account values ('"+username+"','"+password+"','"+"Un Know"+"','"+email+"')";
			System.out.println(sql);
			Statement stmt2 = conn.createStatement();
			stmt2.executeUpdate(sql);

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
	<tr> <td>name</td>     <td><%= request.getParameter("userID")%>   </td></tr>
	<tr> <td>email</td>    <td><%= request.getParameter("email")%>	  </td></tr>
</table>
</center>
</body>
</html>