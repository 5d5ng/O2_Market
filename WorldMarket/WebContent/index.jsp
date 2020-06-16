<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import = "java.util.*" %>
    <%@page import = "java.sql.*" %>
    <%@page import = "dto.Customer" %>
    <%@page import = "dao.CustomerDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
CustomerDao customer = new CustomerDao();
List l = customer.getCustomers();

%>
ss
</body>
</html>