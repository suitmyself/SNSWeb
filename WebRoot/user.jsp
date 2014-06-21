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

	.PostButton, .commet {
		height: 30px;
		margin-left: 10px;
		adding: 0px 30px;
		display: inline-block;
        font-size: 14px;
        line-height: 28px;
        color: #666;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		background: linear-gradient(to bottom, #FEFEFE 0px, #F8F8F8 100%) repeat scroll 0% 0% #FBFBFB;
		border: 1px solid #A7ACB5;
		border-radius: 3px;
		box-shadow: 0px 1px 0px rgba(0, 0, 0, 0.15);
		/*position: relative;*/
		/*bottom: 10px;*/
		float: right;
		margin-right: 29px;
		
	}
	.commet
	{
		margin-right: 48px;
	}
	
	.postPaid
	{
		width:50%;
		height:180px;
		margin-left: auto;
		margin-right: auto;
		
		display: block;
		margin-bottom: 20px;
		margin-top: 25px;
		/*width: 500px;*/
		background-color: #FFF;
		border: 1px solid  	#E1DFDF ;
		border-radius: 2px;
		box-shadow: 2px 4px 4px #CCC;
		word-break: break-all;
		font: 12px/18px arial,STHeiti,"Microsoft YaHei",宋体;
		color: #333;
	}

	#myPost {
		width: 90%;
		height:100px;
		margin-left: 30px;
		margin-top: 20px;
		padding-top: 10px;
		padding-bottom: 10px;
		margin-bottom:15px;
		border: 1px solid #E1E1E1;
	}

	.postBoard {
		width: 80%;
		height: 100%;
		float: left;
		background-color: #D9D9D9;
		border-radius: 8px;
		margin-left: 15px;
		padding-top: 20px;
		padding-bottom: 20px;
	}

	.postItem 
	{
		margin-left: auto;
		margin-right: auto;
		
		display: block;
		margin-bottom: 20px;
		/*width: 500px;*/
		background-color: #FFF;
		border: 1px solid #E1DFDF;
		border-radius: 2px;
		box-shadow: 0px 2px 2px #CCC;
		word-break: break-all;
		font: 12px/18px arial,STHeiti,"Microsoft YaHei",宋体;
		color: #333;
	
	
		width: 90%;
		float: left;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 10px;
		padding-bottom: 20px;
	}

	.originalText {
		width: 90%;
		float: left;
		background-color: #FFF;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 10px;
		padding-bottom: 0px;
	}
	.content
	{
		background-color:FFCCCC;
		font-size:14px;
		width:100%;
		min-height:80px;
		padding-left:10px;
		padding-top:10px;
		border-radius: 2px;
		margin-bottom: 5px;
	}

	.replies {
		width: 89%;
		float: left;
		background-color: silver;
		border-radius: 5px;
		margin-left: 40px;
		margin-top: 2px;
		padding-top: 5px;
		padding-bottom: 5px;
	}

	.replyText
	{
		padding-top: 5px;
		padding-bottom: 5px;
		padding-left: 10px;
	}
	
	.to_ReplayText
	{
		width: 90%;
		height: 30px;
		margin-left: 30px;
		margin-top: 0px;
		padding-top: 5px;
		padding-bottom: 5px;
		margin-bottom:5px;
		border: 1px solid green;
		
	}
	
	.inputReply
	{
		margin-top:10px;
	}

	.toReply {
		width: 91.5%;
		float: left;
		background-color: #E6E6FA;
		border-radius: 5px;
		margin-left: 20px;
		padding-top: 5px;
		padding-bottom: 5px;
		margin-top:5px;
	}

	</style>

	<script type="text/javascript">
		updatePostBoard();

		setInterval("updatePostBoard();updateSystemMessage();", 30000);

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
					document.getElementById("myPost").value="";
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
		
		function onfocusFunc(postID)
		{
			document.getElementById("button" + postID).style.display="inline";
			document.getElementById("textRe" + postID).style.height= "60px";
			if(document.getElementById("textRe" + postID).value.substring(0,5)=="来句评论吧")
			{
				document.getElementById("textRe" + postID).value= "";
			}
			document.getElementById("textRe" + postID).style.color="black";
			//document.getElementById("textRe" + postID).value="";
			//document.getElementById("textRe" + postID).blur();
			//document.getElementById("textRe" + postID).focus();
			//document.getElementById("textRe" + postID).style.textIndent="0px";
			//var obj = event.srcElement;    
			//var txt =obj.createTextRange();    
			//txt.moveStart('character',obj.value.length);    
			//txt.collapse(true);    
			//txt.select();  
			
		}
		
		function onblurFunc(postID)
		{
			if(document.getElementById("textRe" + postID).value=="")
			{
				document.getElementById("textRe" + postID).style.height= "30px";
				document.getElementById("button" + postID).style.display="none";
				//alert("|"+document.getElementById("textRe" + postID).value+"|");

	
				document.getElementById("textRe" + postID).value= "来句评论吧";
		
				document.getElementById("textRe" + postID).style.color= "#C8C8C8";
			}
		}
		
		function postOnblur(text_)
		{
			var message = text_.value;
			if(text_.value=="")
			{
				text_.value= "闲来无事闷得慌，来一发状态吧";
			
				text_.style.color= "#C8C8C8";
				text_.style.borderColor="#E1E1E1";
			}
		}
		
		function postOnfocus(text_)
		{
			//alert("|"+text_.innerHTML.substring(0,13)+"|");
			var message=text_.value.substring(0,14);
			//alert(message);
			if(text_.value.substring(0,14)=="闲来无事闷得慌，来一发状态吧")
			{
				text_.value= "";
			}
			text_.style.color="black";
			text_.style.borderColor="green";
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
					document.getElementById("textRe" + postID).value="";
				}
			} else {
				alert("请输入内容！");
			}
		}
	</script>
</head>
<body style="background-color:#D9D9D9">
    <%@ include file="navigator.jsp" %>
  	<%@ include file="module.jsp" %>
	<div class="postPaid">
		<textarea type="text" id="myPost" onfocus="postOnfocus(this)" onblur="postOnblur(this)" style="color:#C8C8C8">闲来无事闷得慌，来一发状态吧</textarea>
		<br/>
		<button onclick="submitPost()" class="postButton">发布</button>
	</div>
	<div class="postBoard" id="dynamics"></div>

</body>
</html>
