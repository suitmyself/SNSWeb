<%@ page import="java.sql.*" %>
<% 
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	String DB_URL = "jdbc:mysql://localhost/t_sns?useUnicode=true&characterEncoding=utf8";

	String USER = "sns_admin";
	String PASS = "CalRybMid3";
	Connection conn = null;
	Statement stmt = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");	   
		conn = DriverManager.getConnection(DB_URL,USER,PASS);
		stmt = conn.createStatement();
		stmt.executeQuery("SET NAMES UTF8");
	}
	catch(SQLException se) {
		out.println("<p>sorry,数据库错误</P>");
		se.printStackTrace();
	}
	catch(Exception e) {
		out.println("<p>sorry,数据库错误</P>");
		e.printStackTrace();
	}
%>
