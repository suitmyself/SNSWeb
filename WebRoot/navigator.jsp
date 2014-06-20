<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 此文件不单独存在，作为导航栏存在各个栏中 -->
<%
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

if (session.isNew()||session.getAttribute("userID")==null)
{
	response.sendRedirect("login.jsp");
	System.out.println("转向到登录页面");
	return;
}
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style type="text/css">
	.navigator
	{
		overflow:hidden;
		text-align: center;
		background-color:#98FB98;
		/*position: fixed;*/
		width: 100%;
		height:40px;
		font-size: 1.3em;
		line-height:40px;
		margin:0;
		margin-bottom:5px;
		padding:0;
		border:0;
		border-radius:8px;
	}
	.navigator ul
	{
		display:inline;
		margin-top:0;
		width:100%;  
		list-style-type:none;
		padding:0
	}
	.navigator li
	{
		display:inline;
		/*position:;*/
		float:right;
	}
	.navigator a:link,.navigator a:visited
	{
		display:block;
		padding:0px;
		margin:0px;
		width:150px;
		height:100%;
		font-weight:bold;
		color:blue;
		/*text-decoration:none;*/
	}

	.navigator a:hover,.navigator a:active
	{
		background-color:#F00;
	}
	</style>
</head>

<div id="navigator"  class="navigator" > 
<ul>
	<li><a class="logout" href="logout.jsp" style="margin-right:20px;" >注销</a></li>
	<li><a class="user" href="user.jsp"> 
	<% 
		if(session.getAttribute("userID")==null)
   		{
   			out.print("登录");
   		}
   		else
   		{
   			out.print(session.getAttribute("userID"));
   		}	
	%> 
	</a> </li>
</ul>
</div>
