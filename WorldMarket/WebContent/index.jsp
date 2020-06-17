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
CustomerDao customer = new CustomerDao();

Customer c1 = new Customer("test02","1234","Oh",12,"0102939","dd@gmail.com");

customer.addCustomer(c1);
List l = customer.getCustomers();

%>
ss
</body>
</html>