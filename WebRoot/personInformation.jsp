<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	if (session.isNew() || session.getAttribute("userID") == null)
	{
		response.sendRedirect("login.jsp");
		System.out.println("转向到登录页面");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人信息</title>
<style type="text/css">
.userID,.country,.email,.phone,.name,.university,.school,.major
{
	padding: 7px 10px;
	width: 233px;
	height: 35px;
	line-height: 25px;
	border-radius: 1px;
	margin-right: 7px;
	border: 1px solid #BDC7D8;
}
.submit
{
	width: 100px;
	height: 43px;
	margin: 10px 10px 10px 10px;
	display: block;
	cursor: pointer;
	color: blue;
	font-size: 18px;
	font-weight: 700;
	font-family: "微软雅黑";
	border: 1px solid #3B6E22;
	border-radius: 3px;
	background-color:#00FF00;
	position: relative;
	right: 200 px;
}
td
{
	padding-bottom: 10px;
	padding-top:10px;
}

</style>
</head>
<body onload="load()">  <!-- 这样子就可以载入了 -->
<% 
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://localhost/t_sns";
	//  Database credentials
	String USER = "sns_admin";
	String PASS = "CalRybMid3";
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
		sql = "SELECT * FROM user_info where username='"+session.getAttribute("userID")+"'";
		ResultSet rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{
		    String username = rs.getString("username");
			String name     = rs.getString("realname");
			int    sex      = rs.getShort("sex");
 			Date   birthday = rs.getDate("birthday");
 			
 			Calendar cal=Calendar.getInstance();
            cal.setTime(birthday);
            int day = cal.get(Calendar.DAY_OF_MONTH); //日
			int mouth = cal.get(Calendar.MONTH) + 1; //月(从0开始, 一般加1，实际是否 Calendar 里面常量的值决定的)
			int year = cal.get(Calendar.YEAR); //年
			
 			String university = rs.getString("university");
  			String school = rs.getString("school");
  			String major = rs.getString("major");
			String signature = rs.getString("signature");
			
			System.out.println("university: "+university);
 			System.out.println("school: "+school);
 			System.out.println("major:"+major);
			
			sql = "SELECT * FROM account where username='"+session.getAttribute("userID")+"'";
			ResultSet rs1 = stmt.executeQuery(sql);
			rs1.next();
			String email = rs1.getString("email");
			%>
				<script type="text/javascript">
				function load()
				{
					document.getElementById("userID_").value= "<%= session.getAttribute("userID")%>";
					document.getElementById("name_").value= "<%= name %>";
					document.getElementById("university_").value= "<%= university %>";
					document.getElementById("school_").value= "<%= school %>";
					document.getElementById("major_").value= "<%= major %>";
					document.getElementById("email_").value= "<%= email %>";
					document.getElementById("signature_").value= "<%= signature %>";
					
					for(var i=0; i<document.getElementById("year_").length;i++)
					{
						//alert("已经被执行");
						if(document.getElementById("year_").options[i].text == <%= year %>)
						{
							//alert("year已经被执行");
							document.getElementById("year_").options[i].selected = true;
							break;
						}
					}
					
					for(var i=0; i<document.getElementById("mouth_").length;i++)
					{
						//alert("已经被执行");
						if(document.getElementById("mouth_").options[i].text == "<%= mouth %>")
						{
							document.getElementById("mouth_").options[i].selected = true;
							break;
						}
					}
					
					for(var i=0; i<document.getElementById("day_").length;i++)
					{
						if(document.getElementById("day_").options[i].text == "<%= day %>")
						{
							document.getElementById("day_").options[i].selected = true;
							break;
						}
					}
					
					//alert("运行");
				}
					
				</script>
			<% 
			
		}
		else
		{
			out.println("<h2>用户名不存在,可能登陆超时</h2>");
	   		out.println("<p>3秒后返回<a href='login.jsp' >登陆</a>页面！</p>");
	   	    String content=3+";URL="+"login.jsp";
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

  	<div>
	<h1 align="center">个人信息页面</h1>
	<hr>
	<br>
	<center>
		<form id="form" name="form" class="form" action="changePersonInformation.jsp" method="POST">
			<table>
				<tr>
					<td>用户名</td>
					<td><input id="userID_" name="userID" class="userID"
						style="vertical-align: middle" size="19" onblur="doCheck()" disabled>
					</td>
					<td align="center"><small>只读</small>
					</td>
				</tr>
				<tr>
					<td>真实姓名</td>
					<td><input type="text" id="name_" name="name" class="name">
					</td>

				</tr>
				<tr>
					<td>性别</td>
					<td> <span style="width: 100px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 
					<input type="radio" name="gender" value="1" checked="checked" />男
					<span style="width:100px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<input type="radio" name="gender" value="0" /> 女</td>
				</tr>
				<tr>

					<td>生日 </td>
					
					<td>
					&nbsp;
					年<select id="year_" name="year">
							<% for(int i=1900;i<=2014;i++)
                            {%>
							<option value="<%= i%>">
								<%=i %>
							</option>
							<%}%>
					</select>
                   &nbsp;&nbsp;
					月<select id="mouth_" name="mouth">
							<% for(int i=1;i<=12;i++)
                            {%>
							<option value="<%= i%>">
								<%=i %>
							</option>
							<%}%>
					</select>
					
                    &nbsp;&nbsp;
					日<select id="day_" name="day">
							<% for(int i=1;i<=31;i++)
                            {%>
							<option value="<%= i%>">
								<%= i %>
							</option>
							<%}%>
					</select>
					
				</tr>
				<tr>
					<td>学校</td>
					<td><input type="text" id="university_" name="university" class="university"></td>
				</tr>
				<tr>
					<td>学院</td>
					<td><input type="text" id="school_" name="school" class="school"></td>
				</tr>
				<tr>
					<td>专业</td>
					<td><input type="text" id="major_" name="major" class="major">
					</td>
					
				</tr>
				<tr>
					<td>email</td>
					<td><input type="text" id="email_" name="email" class="email" disabled>
					</td>
					<td align="center"><small>只读</small>
					</td>
					
				</tr>
			</table>
			签名<br/>
			<textarea rows="10" cols="50" id="signature_" name="signature" class="signature"></textarea>
			<input type="submit" name="submit" class="submit" value="修改">
		</form>
	</center>
	</div>
</body>
</html>
