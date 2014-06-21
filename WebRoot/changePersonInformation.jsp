<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改个人信息</title>
<script type="text/javascript"> //倒计时
var t;
function timeCount()
{
	document.getElementById("timing").innerHTML=document.getElementById("timing").innerHTML-1;
	t=setTimeout("timeCount()",1000);
}
</script>
</head>
<body>
<%@ include file="accessDB.jsp" %>
<% 
	try
	{
		String sql = "SELECT * FROM account WHERE username='"+session.getAttribute("userID")+"'";
		ResultSet rs = stmt.executeQuery(sql);
		//STEP 5: Extract data from result set
		if(rs.next()) 
		{

			out.println("<h2>验证正确</h2>");
			
			
			String realname = request.getParameter("name");
			String      sex = request.getParameter("gender");
			String     year = request.getParameter("year");
			String    mouth = request.getParameter("mouth");
			String      day = request.getParameter("day");

			System.out.println("year3:" +year);
			System.out.println("mouth3:" +mouth);
			System.out.println("day3:" +day);
			System.out.println("执行一遍");

			String university = request.getParameter("university");
			String school = request.getParameter("school");
			String major = request.getParameter("major");
			String signature = request.getParameter("signature");
			

 			sql = "UPDATE user_info SET realname='"+realname+"',"+
 			                                "sex= "+Short.parseShort(sex)+","+
 			                           "birthday='"+year+"-"+mouth+"-"+day+"',"+
 			                          "signature='"+signature+"',"+
 			                          "university='"+university+"',"+
 			                          "school='"+school+"',"+
 			                          "major='"+major+"'"+
 			      "Where username='"+session.getAttribute("userID")+"'";
			stmt.executeUpdate(sql);
			
			out.println("<h2>信息正常更改</h2>");
			out.println("<p><span id='timing'>3</span>秒后返回<a href='user.jsp' >用户</a>页面！</p>");
		    String content=3+";URL="+"user.jsp";
		    response.setHeader("REFRESH",content);
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

</body>
</html>
