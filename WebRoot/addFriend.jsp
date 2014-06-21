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
    <title>添加好友</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="user.jsp">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.addFriend
	{
		width: 80%;
		/*height: 1000px;*/
		float: left;
		background-color:#D9D9D9;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	
	.queryText
	{
		padding: 7px 10px;
		width: 300px;
		height: 40px;
		line-height: 25px;
		/*border-radius: 3px;*/
		margin-right: 7px;
		border: 1px solid #BDC7D8;
	}
	.query
	{
		width: 100px;
		height: 38px;
		margin: 10px 0px;
		display: inline;
		cursor: pointer;
		color: blue;
		font-size: 18px;
		font-weight: 700;
		font-family: "微软雅黑";
		border: 1px solid #3B6E22;
		border-radius: 1px;
		background-color:#00FF00;
		position: relative;
		right: 50 px;
		bottom: -3px;
	}
	</style>
	
	<script type="text/javascript">
	function doCheck() 
	{
		var chkObjs = document.getElementsByName("queryRadio");
		var i;
        for(i=0;i<chkObjs.length;i++)
        {
       		 if(chkObjs[i].checked)
        	 {
        		chk = i;
           		break;
       		 }
		}

		var url = "queryFriend.jsp?queryType=" + chkObjs[i].value
					+ "&queryText=" + document.getElementById("queryText_").value
		url = encodeURI(url);
		url = encodeURI(url);
        send_request("GET", url, null, "text", showFeedbackInfo);
        //alert("docheck");
	}

	function showFeedbackInfo() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{   // 信息已经成功返回，开始处理信息
        		document.getElementById("queryResult_").innerHTML = http_request.responseText;//获得返回的内容
        		//alert(http_request.responseText);
        	}
        	/*
        	else 
        	{ //页面不正常
          		alert("您所请求的页面有异常。");
        	}
        	*/
    	}
	}
	
	function addFriendFunc(thisButton) 
	{
		alert("注意：当您请求对方加为好友时，对方有权限同时加您为好友");
		var message=prompt("请输入验证信息");
		if(message != null)
		{
			var url = "addFriend_ajax.jsp?"
						+"fromUsername="+"<%= session.getAttribute("userID")%>"
        				+"&toUsername="+thisButton.id
        				+"&message="+message;
			url = encodeURI(url);
			url = encodeURI(url);
			//alert("http://localhost:8080/sns/" + url);
       		send_request("GET", url, null, "text", showFeedbackInfo2);
        }
        
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
        		 	//alert(message);
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
<body>
    <%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
  	<div class=addFriend>
  	<h1 align="center">添加好友</h1>
  	<hr>
  	<center>
  	<form action="">
  	<input type="radio" name="queryRadio" checked="checked" value="all"/>所有 &nbsp;&nbsp;&nbsp;
  	<input type="radio" name="queryRadio" value="username"/>用户名&nbsp;&nbsp;&nbsp;
  	<input type="radio" name="queryRadio" value="university"/>学校&nbsp;&nbsp;&nbsp;
  	<input type="radio" name="queryRadio" value="school"/>学院&nbsp;&nbsp;&nbsp;
  	<input type="radio" name="queryRadio" value="major"/>专业
  	
  	<br/>
  	<input type="text"  name="queryText" id="queryText_" class="queryText" /> 
  	<input type="button" name="query" id="query_" class="query" value="查询" onclick="doCheck()">
  	</form>
  	<hr>
  	<div class="queryResult" id="queryResult_">
  	</div>
  	</center>
  	</div>
</body>
</html>
