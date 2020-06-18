<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="dto.*"%>
<%@page import="dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="Background.css">

</head>
<body>
	<%
		/* 
	Customer customer = (Customer) session.getAttribute("pCustomer");
	if(customer == null){
	response.sendRedirect("Login.jsp");
	} 
	*/
	%>
	<br>
	<br>
	<div id="name">월 드 마 켓</div>

	<div class="box">
		<div class="container-4">
			<input type="search" id="search" placeholder="Search..." />
			<button class="icon">
				<i class="fa fa-search"></i>
			</button>
		</div>
	</div>

	<nav id="primary_nav_wrap">
		<ul>
			<li><a href="#">Category</a>
				<ul>
					<li><a href="#">Clothing</a></li>
					<li><a href="#">Cosmetics</a></li>
					<li><a href="#">Home Appliances</a></li>
					<li><a href="#">Foods</a></li>
				</ul></li>
		</ul>
	</nav>
</body>
</html>