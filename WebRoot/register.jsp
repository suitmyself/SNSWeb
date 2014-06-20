<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="kiben" content="no-cache">
	<title>注册页面</title>
	<script type="text/javascript">
	function check()
	{
	 	var phone=document.getElementById("phone_").value;
	 	var email=document.getElementById("email_").value;
	 	var userID=document.getElementById("userID_").value;
     	var password=document.getElementById("password_").value;
   
	 	if(userID.length==0||password.length==0||email.length==0)
	 	{
				alert("存在未填项");
				return false;
		 }
	 	if(password!=document.getElementById("password2_").value)
		 {
		 	alert("密码不一致");
			 return false;
		 }
	}

	function doCheck() 
	{
    	if(document.getElementById("userID_")!="") 
    	{
    		document.getElementById("isRegisted").innerHTML = "系统正在处理您的请求，请稍后。";
        	send_request("GET",encodeURI(encodeURI("isRegisted.jsp?userID="+document.getElementById("userID_").value+"&email="+document.getElementById("email_").value)),null,"text",showFeedbackInfo);
    	}
    	else 
    	{
        	document.getElementById("isRegisted").innerHTML = "请输入用户名称。";
    	}
	}

	function showFeedbackInfo() 
	{
		if (http_request.readyState == 4) 
    	{       // 判断对象状态
    		if (http_request.status == 200) 
       		{   // 信息已经成功返回，开始处理信息
        		document.getElementById("isRegisted").innerHTML = http_request.responseText;//获得返回的内容
        	}
        	/*
        	else 
        	{ //页面不正常
          		alert("您所请求的页面有异常。");
        	}
        	*/
    	}
	}
</script>
<script type="text/javascript" src="ajax.js"></script>
<style type="text/css">
.userID,.password,.password2,.email
{
	padding: 7px 10px;
	width: 233px;
	height: 25px;
	line-height: 25px;
	border-radius: 3px;
	margin-right: 7px;
	border: 1px solid #BDC7D8;
}
.submit
{
	width: 100px;
	height: 43px;
	margin: 10px 10px 10px 10px;
	display: block;
	cursor: pointer;
	color: blue;
	font-size: 18px;
	font-weight: 700;
	font-family: "微软雅黑";
	border: 1px solid #3B6E22;
	border-radius: 3px;
	background-color:#00FF00;
	position: relative;
	right: 200 px;
}
td
{
	padding-bottom: 10px;
	padding-top:10px;
}

body
{
	background-image:url(background2.jpg);
}

</style>
</head>
<body>
	<h1 align="center">SNS社交网站注册页面</h1>
	<hr>
	<br>
	<center>
		<form id="form" name="form" class="form" action="checkRegister.jsp" method="POST" onsubmit="return check()">
			<table>
				<tr>
					<td>用户名</td>
					<td><input id="userID_" name="userID" class="userID"
						style="vertical-align: middle" size="19" onblur="doCheck()">
					</td>
					<td align="center"><small>不多于15个字符</small></td>
				</tr>
				<tr>
					<td></td> <td><small id=isRegisted style="color:red; width:100px">提示</small></td>
				</tr>
				<tr>
					<td>密码</td>
					<td><input type="password" id="password_" name="password"
						class="password" style="vertical-align: middle" size="20">
					</td>
					<td align="center"><small>不多于20个字符</small></td>
				</tr>
				<tr>
					<td>重复密码</td>
					<td><input type="password" id="password2_" name="password2"
						class="password2" style="vertical-align: middle" size="20">
					</td>
				</tr>
				<tr>
					<td>email</td>
					<td><input type="text" id="email_" name="email" class="email" onblur="doCheck()"></td>
					<td align="center"><small>不多于50个字符</small></td>
				</tr>
			</table>
			<input type="submit" name="submit" class="submit" value="注册">
		</form>
	</center>
</body>
</html>
