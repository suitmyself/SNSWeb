<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String userID = (String) session.getAttribute("userID");
if (session.isNew() || userID == null)
{
	response.sendRedirect("login.jsp");
	//System.out.println("转向到登录页面");
	return;
}
%>
<%@ include file="accessDB.jsp" %>
<%
try {
	//Query posts
	String sql = "SELECT * FROM `t_sns`.`post`"
				+ " WHERE re_id = -1"
				+ " AND ("
					+ "username = '" + userID + "'"
					+ " OR "
						+ "username IN ("
									+ "SELECT username2 FROM friend_pair"
									+ " WHERE username1 = '" + userID + "'"
									+ ")"
					+ " ) ORDER BY ts DESC";

	//System.out.println(sql);
	ResultSet rs = stmt.executeQuery(sql);
%>

		<% for ( ; rs.next(); ) { %>
			<% String post_id = rs.getString("post_id"); %>
			<div class="postItem">
				<div class="postContent" id='<%= "PC_" + post_id %>' >
					<div class="originalText">
						<p><strong><%= rs.getString("username") %> 说：</strong></p>
						<p><%= rs.getString("content") %></p>
						<p><i><%= rs.getString("ts") %></i></p>
					</div>

					<div class="replies">
					<%
						Connection conn2 = DriverManager.getConnection(DB_URL,USER,PASS);
						Statement stmt2 = conn2.createStatement();
						stmt2.executeQuery("SET NAMES UTF8");
						String sql2 = "SELECT * FROM `t_sns`.`post`"
								+ " WHERE re_id = " + post_id
								+ " ORDER BY ts DESC";

						System.out.println(sql2);
						ResultSet rs2 = stmt2.executeQuery(sql2);

						for ( ; rs2.next(); ) {
					%>
							<div class="replyText" id='<%= rs2.getString("post_id") %>'>
								<p><strong><%= rs2.getString("username") %> 回复：</strong></p>
								<p><%= rs2.getString("content") %></p>
								<p><i><%= rs2.getString("ts") %></i></p>
							</div>
					<%
						} //for rs2

						rs2.close();
						stmt2.close();
						conn2.close();
					%>
					</div>
					
				</div>

				<dir class="toReply">
					<button onClick="toggleReplyInput(<%= post_id %>)">显示/隐藏回复面板</button>
					<div class="inputReply" id='<%= "IR_" + post_id %>' style="display:none">
						<textarea id='<%= "textRe" + post_id %>' ></textarea>
						<button onClick="submitReply(<%= post_id %>)">提交</button>
					</div>
				</dir>
				
			</div>
		<%
		} //for rs
		%>

<%
	rs.close();
	stmt.close();
	conn.close();
} //try
catch(SQLException se) {
	//Handle errors for JDBC
	out.println("<p>sorry,数据库错误</P>");
	se.printStackTrace();
}
catch(Exception e) {
	//Handle errors for Class.forName
	out.println("<p>sorry,数据库错误</P>");
	e.printStackTrace();
}
finally {
	//finally block used to close resources
	try {
		if(stmt!=null) stmt.close();
	}
	catch(SQLException se2)
	{
		out.println("<p>sorry,数据库错误</P>");
	}// nothing we can do
	try {
		 if(conn!=null) conn.close();
	}
	catch(SQLException se) {
		out.println("<p>sorry,数据库错误</P>");
		se.printStackTrace();
	}
}
%>
