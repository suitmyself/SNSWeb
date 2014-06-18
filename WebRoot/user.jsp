<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
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
	.postBoard
	{
		width: 80%;
		height: 100%;
		float: left;
		background-color: white;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	.postItem
	{
		width: 90%;
		float: left;
		background-color: silver;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
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

		function submitReply(postID) {
			var postDoc = document.getElementById(postID);
			var strInput = postDoc.value;
			if (strInput!="") {
				var xmlhttp = null;
				if (window.XMLHttpRequest) {
					// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp = new XMLHttpRequest();
				}
				else {
					// code for IE6, IE5
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (xmlhttp!=null) {
					xmlhttp.onreadystatechange = function() {
						if (xmlhttp.readyState==4 && xmlhttp.status==200) {
						
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
		<textarea type="text" id="myPost"  rows=4 cols=15></textarea>
		<input style="height: 20; width:50" type="button" value="发布" onclick="submitPost()"/>
	</div>
	<div class="postBoard">
		<div class="postItem" id="1">
			Hi, my firt post!
		</div>
		<div class="postItem" id="2">
			Hi, my second post!
		</div>
	</div>
</body>
</html>
