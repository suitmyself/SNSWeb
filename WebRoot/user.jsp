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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>用户界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="user.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">

	button {
		height: 30px;
	}

	#myPost {
		width: 60%;
		margin-left: 30px;
		padding-top: 20px;
		padding-bottom: 20px;
	}

	.postBoard {
		width: 80%;
		height: 100%;
		float: left;
		background-color: white;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}

	.postItem {
		width: 90%;
		float: left;
		background-color: silver;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 10px;
		padding-bottom: 20px;
	}

	.originalText {
		width: 90%;
		float: left;
		background-color: silver;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 10px;
		padding-bottom: 20px;
	}

	.replies {
		width: 90%;
		float: left;
		background-color: silver;
		border-radius: 5px;
		margin-left: 50px;
		padding-top: 10px;
		padding-bottom: 10px;
	}

	.replyText
	{
		padding-top: 10px;
		padding-bottom 10px;
	}

	.toReply {
		width: 90%;
		float: left;
		background-color: silver;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 10px;
		padding-bottom: 20px;
	}

	</style>

	<script type="text/javascript">
		function submitPost() {
			var myPost = document.getElementById("myPost");
			var strInput = myPost.value;
			if (strInput != "") {
				var xmlhttp = null;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				}
				else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				
				if (xmlhttp != null) {
					xmlhttp.onreadystatechange = function() {
						if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
							window.location.reload();
						}
					}
					strInput = "submitPost.jsp?words="+strInput;
					// fixme why encodeURI twice
					strInput = encodeURI(strInput);
					strInput = encodeURI(strInput);
					xmlhttp.open("GET", strInput, true);
					xmlhttp.send();
				}
			} else {
				alert("请输入内容！");
			}
		}
		
		function toggleReplyInput(postID) {
			if (document.getElementById("IR_" + postID).style.display == "none") {
				document.getElementById("IR_" + postID).style.display = "block";
			}
			else {
				document.getElementById("IR_" + postID).style.display = "none";
			}
		}

		function submitReply(postID) {
			var textRe = document.getElementById("textRe" + postID);
			var strInput = textRe.value;
			if (strInput != "") {
				var xmlhttp = null;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				}
				else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp != null) {
					xmlhttp.onreadystatechange = function() {
						if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
							window.location.reload();
						}
					}
					strInput = "submitReply.jsp?words="+strInput+"&postID="+postID;
					// fixme why encodeURI twice
					strInput = encodeURI(strInput);
					strInput = encodeURI(strInput);
					xmlhttp.open("GET",strInput,true);
					xmlhttp.send();
				}
			} else {
				alert("请输入内容！");
			}
		}
	</script>
</head>
<body>
    <%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
	<div>
		<textarea type="text" id="myPost"></textarea>
		<button onclick="submitPost()">发布</button>
	</div>
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
	
		<div class="postBoard">
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
						<button onClick="toggleReplyInput(<%= post_id %>)">显示/隐藏回复面板"</button>
						<div class="inputReply" id='<%= "IR_" + post_id %>' style="display:none">
							<textarea id='<%= "textRe" + post_id %>' ></textarea>
							<button onClick="submitReply(<%= post_id %>)">提交</button>
						</div>
					</dir>
					
				</div>
			<%
			} //for rs
			%>
		</div>

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
</body>
</html>
