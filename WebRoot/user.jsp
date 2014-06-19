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
		updatePostBoard();

		setInterval("updatePostBoard()", 30000);

		function updatePostBoard() {
			var xmlhttp;
			if (window.XMLHttpRequest) {
				xmlhttp = new XMLHttpRequest();
			}
			else {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					document.getElementById("dynamics").innerHTML=xmlhttp.responseText;
				}
			}
			xmlhttp.open("GET", "view.jsp?t=" + Math.random(), true);
			xmlhttp.send();
		}

		function submitPost() {
			var myPost = document.getElementById("myPost");
			var strInput = myPost.value;
			if (strInput != "") {
				var xmlhttp;
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
							updatePostBoard();
						}
					}
					strInput = "submitPost.jsp?words="+strInput;
					// fixme why encodeURI twice
					strInput = encodeURI(strInput);
					strInput = encodeURI(strInput);
					xmlhttp.open("POST", strInput, true);
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
				var xmlhttp;
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
							updatePostBoard();
						}
					}
					strInput = "submitReply.jsp?words="+strInput+"&postID="+postID;
					// fixme why encodeURI twice
					strInput = encodeURI(strInput);
					strInput = encodeURI(strInput);
					xmlhttp.open("POST", strInput, true);
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
	<div class="postBoard" id="dynamics"></div>

</body>
</html>
