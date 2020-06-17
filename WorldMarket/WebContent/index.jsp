<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import = "java.util.*" %>
    <%@page import = "java.sql.*" %>
    <%@page import = "dto.*" %>
    <%@page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	Customer customer = (Customer) session.getAttribute("pCustomer");
	if(customer == null){
		response.sendRedirect("Login.jsp");
	}
%>
<h1>문어발 쇼핑몰</h1>



</body>
</html>