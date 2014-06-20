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
						<p><strong style="font-weight: bold; color: #333; font-size:15px;">
						&nbsp;&nbsp;<%= rs.getString("username") %></strong> &nbsp;发布状态  
						&nbsp;&nbsp; 时间:  <i><%= rs.getString("ts") %></i></p>
						<p class="content"><%= rs.getString("content") %></p>
					</div>

					
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
							<div class="replies">
							<div class="replyText" id='<%= rs2.getString("post_id") %>'>
								<strong><%= rs2.getString("username") %> 回复：</strong>
								&nbsp;&nbsp;&nbsp;时间(<i><%= rs2.getString("ts") %></i>)
								<p><%= rs2.getString("content") %></p>
								
							</div>
							</div>
					<%
						} //for rs2

						rs2.close();
						stmt2.close();
						conn2.close();
					%>
					
					
				</div>

				<div class="toReply">
					<!--  <button onClick="toggleReplyInput(<%//= post_id %>)">显示/隐藏回复面板</button>-->
					<div class="inputReply" id='<%= "IR_" + post_id %>' style="display:block">
						<textarea id='<%= "textRe" + post_id %>' class="to_ReplayText" rows="1" 
						onfocus="onfocusFunc(<%= post_id %>)" onblur="onblurFunc(<%= post_id %>)"
						style="color:#C8C8C8;" >来句评论吧
						</textarea>
						<script type="text/javascript">
						document.getElementById(<%= "textRe" +  post_id %>).value= "来句评论吧";
						document.getElementById(<%= "textRe" +  post_id %>).style.color= "#C8C8C8";
						alert(<%= "textRe" +  post_id %>);
						</script>
						<button id='<%= "button" + post_id %>' onClick="submitReply(<%= post_id %>)" class="commet" style="display:none;">发表评论</button>
					</div>
				</div>
				
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
