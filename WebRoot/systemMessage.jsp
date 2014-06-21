<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	if (session.isNew() || session.getAttribute("userID") == null)
	{
		response.sendRedirect("login.jsp");
		System.out.println("转向到登录页面");
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
	.systemMessage 
	{
		width: 80%;
		/*height: 1000px;*/
		float: left;
		background-color: #D9D9D9;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	.friendRequest
	{
	    border-radius:8px;
		border: 1px solid #BDC7D8;
		background-color:#DA70D6;
		/*position:absolute;*/
		/*position:relative;*/
		float:left;
		width:90%;
		/*height:220px;*/
		/*text-align:center;*/
		margin:15px;
		left:5%;   
        /*top:30%; */
        box-shadow: 0px 2px 2px #CCC;
        padding:5px;
	}
	
	.system_message
	{
	    border-radius:8px;
		border: 1px solid #BDC7D8;
		background-color:#FFFF00;
		/*position:absolute;*/
		position:relative;
		float:left;
		width:90%;
		/*height:220px;*/
		/*text-align:center;*/
		margin:15px;
		left:0%;   
        /*top:30%; */
        box-shadow: 0px 2px 2px #CCC;
        padding:5px;
	}
	
	.acceptButton, .rejectButton,.readButton
	{
		width: 50px;
		height: 30px;
		margin: 0px 20px;
		display: inline;
		cursor: pointer;
		color: blue;
		font-size: 15px;
		font-weight: 700;
		font-family: "微软雅黑";
		border: 1px solid #3B6E22;
		border-radius: 5px;
		background-color:#00FF00;
		/*position: relative;*/
		float: right;
		right: 50 px;
	}
	
	.disabledButton
	{
		
		width: 100px;
		height: 30px;
		
		margin: 0px 0px;
		display: inline-block;
		
		cursor: pointer;
		color: black;
		
		font-size: 15px;
		font-weight: 700;
		font-family: "微软雅黑";
		
		border: 1px solid #3B6E22;
		border-radius: 5px;
		background-color:#505050;
		
		position: relative;
		margin-left: 10px;
		float: right;
		
		right: 50 px;
		bottom:30 px;
		
	}
	.readButton
	{
		width: 100px;
	}
	</style>
	<script>
	function acceptFunc(thisButton) 
	{
		var addFriend=confirm("是否同时加对方为好友？");
		if(addFriend==true)
		{
			send_request("GET",encodeURI(encodeURI("dealFriendRequest.jsp?status=1"
        				+"&request_id="+thisButton.id
        				+"&addFriend=1")),
        				null,
        				"text",
        				showFeedbackInfo);
        }
        else
        {
        	send_request("GET",encodeURI(encodeURI("dealFriendRequest.jsp?status=1"
        				+"&request_id="+thisButton.id
        				+"&addFriend=0")),
        				null,
        				"text",
        				showFeedbackInfo);
        }
	}
	
	function rejectFunc(thisButton) 
	{
		//alert("reject");
		send_request("GET",encodeURI(encodeURI("dealFriendRequest.jsp?status=-1"
        			+"&request_id="+thisButton.idi)),
        			null,
        			"text",
        			showFeedbackInfo);
	}
	
	function readFunc(thisButton) 
	{
		//alert("read");
		send_request("GET",encodeURI(encodeURI("readSystemMessage.jsp?status=1"
        			+"&notice_id="+thisButton.id)),
        			null,
        			"text",
        			showFeedbackInfo);
	}

	function showFeedbackInfo() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{    // 信息已经成功返回，开始处理信息
       			 //alert("已经返回");
        		 var message=http_request.responseText;
        		 var i=message.indexOf("accept");
        		 if(message.indexOf("accept")!=-1)//获得返回的内容
        		 {
        		 	alert("已经接受好友请求");
        		 }
        		 else if(message.indexOf("reject")!=-1)
        		 {
        		 	alert("已经拒绝好友请求");
        		 }
        		 else if(message.indexOf("readed")!=-1)
        		 {
        		 	alert("已经设置为已读");
        		 }
        		 else
        		 {
        		 	alert("未知原因失败，可能是数据库出误");
        		 	var mess=http_request.responseText;
        		 	alert(mess);	
        		 }
        		 location.reload();
        	}
    	}
	}
	</script>
	<script type="text/javascript" src="ajax.js"></script>
</head>
<body>
    <%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>

  	<div class="systemMessage">
  	<% 
	try
	{
		int count=0;
		String sql="select * from add_friend_request where to_username='"
					+session.getAttribute("userID")+"'";
	    System.out.println(sql);
		ResultSet rs = stmt.executeQuery(sql);
	
		//STEP 5: Extract data from result set
		while(rs.next()) 
		{
			System.out.println("status: "+rs.getShort("status"));
			if(rs.getShort("status")==0)
			{
				out.print("<div class=\"friendRequest\" >");
				out.print("<h4 align=center>"+rs.getString("from_username")+"  请求加你好友</h4>");
				out.print("<hr>时间: "+rs.getString("ts"));
				out.print("<hr>验证信息: "+rs.getString("message")+"<hr>");
				%>
	       		<input type="button" value="接受" id="<%= rs.getInt("request_id")%>" onclick="acceptFunc(this)" class="acceptButton">
	       		<input type="button" value="拒绝" id="<%= rs.getInt("request_id")%>" onclick="rejectFunc(this)" class="rejectButton">
	       		</div>
	        	<% 
	        	count++;
			}	
		}
		
		sql="select * from system_message where to_username='"
					+session.getAttribute("userID")+"'";
	    System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) 
		{
			System.out.println("status: "+rs.getShort("status"));
			if(rs.getShort("status")==0)
			{
				out.print("<div class=\"system_message\" >");
				out.print("<h4 align=center>"+"  系统消息</h4>");
				out.print("<hr>时间: "+rs.getString("ts"));
				out.print("<hr>内容: "+rs.getString("content")+"<hr>");
				%>
	       		<input type="button" value="设定为已读" id="<%= rs.getInt("notice_id")%>" onclick="readFunc(this)" class="readButton">
	       		</div>
	        	<% 
	        	count++;
			}	
		}
		
		sql="select * from system_message where to_username='"
					+session.getAttribute("userID")+"'";
	    System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) 
		{
			System.out.println("status: "+rs.getShort("status"));
			if(rs.getShort("status")==1)
			{
				out.print("<div class=\"system_message\" >");
				out.print("<h4 align=center>"+"  系统消息</h4>");
				out.print("<hr>时间: "+rs.getString("ts"));
				out.print("<hr>内容: "+rs.getString("content")+"<hr>");
				%>
	       		<input type="button" value="已读" id="<%= rs.getInt("notice_id")%>" disabled onclick="readFunc(this)" class="disabledButton">
	       		</div>
	        	<% 
	        	count++;
			}	
		}
		
		sql="select * from add_friend_request where to_username='"
					+session.getAttribute("userID")+"'";
	    System.out.println(sql);
		rs = stmt.executeQuery(sql);
		//STEP 5: Extract data from result set
		while(rs.next()) 
		{
			System.out.println("status: "+rs.getShort("status"));
			if(rs.getShort("status")==1)
			{
				out.print("<div class=\"friendRequest\" >");
				out.print("<h4 align=center>"+rs.getString("from_username")+"  请求加你好友</h4>");
				out.print("<hr>时间: "+rs.getString("ts"));
				out.print("<hr>验证信息: "+rs.getString("message")+"<hr>");
				%>
	       		<input type="button" value="已经接受" id="<%= rs.getInt("request_id")%>" disabled onclick="acceptFunc(this)" class="disabledButton">
	       		</div>
	        	<% 
	        	count++;
			}	
		}
		
		sql="select * from add_friend_request where to_username='"
					+session.getAttribute("userID")+"'";
	    System.out.println(sql);
		rs = stmt.executeQuery(sql);
		//STEP 5: Extract data from result set
		while(rs.next()) 
		{
			System.out.println("status: "+rs.getShort("status"));
			if(rs.getShort("status")==-1)
			{
				out.print("<div class=\"friendRequest\" >");
				out.print("<h4 align=center>"+rs.getString("from_username")+"  请求加你好友</h4>");
				out.print("<hr>时间: "+rs.getString("ts"));
				out.print("<hr>验证信息: "+rs.getString("message")+"<hr>");
				%>
	       		<input type="button" value="被拒绝" id="<%= rs.getInt("request_id")%>" disabled onclick="acceptFunc(this)" class="disabledButton">
	       		</div>
	        	<% 
	        	count++;
			}	
		}
		
		if(count==0)
		{
			out.print("您暂时没有消息");
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
  	</div>
</body>
</html>
