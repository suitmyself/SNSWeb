﻿<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
response.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

if (request.getParameter("words") != null) {
	String content = java.net.URLDecoder.decode(request.getParameter("words"), "UTF-8");
	String postID = request.getParameter("postID");
	String userID = (String) session.getAttribute("userID");
%>

<%@ include file="accessDB.jsp" %>

<%
	try {
		String sql = "INSERT INTO  `t_sns`.`post` (re_id, username, content) VALUES"
			+ "(" + postID +",'" + userID + "','" + content + "')";
		System.out.println(sql);
		stmt.execute(sql);

	conn.close();
	stmt.close();
	} finally {
	}

}
%>
