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
	boolean isLogin = false;
	Customer customer = (Customer) session.getAttribute("pCustomer");
	if(customer != null){
		isLogin = true;
	} 
	
	
	ProductDao PDao = new ProductDao();
	List<Product> productList = PDao.getProduct();
	%>





	<br>
	<br>
	<div id="name">World Market</div>

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
					<li><a href="./Category/Clothing.jsp">Clothing</a></li>
					<li><a href="./Category/Cosmetics.jsp">Cosmetics</a></li>
					<li><a href="./Category/HomeAppliances.jsp">Home
							Appliances</a></li>
					<li><a href="./Category/Foods.jsp">Foods</a></li>
				</ul></li>
		</ul>
	</nav>

	<div class="items">
		<% 
	for(int i=0; i<productList.size();i++){
	%>
		<div class="item">
		<form name ="f" method="post" >
			<img src="./Category/images/<%=productList.get(i).getProductNumber() %>.jpg" alt="item" />
			<h2><%= productList.get(i).getProductName() %></h2>
			<p>
				Price: <em><%= productList.get(i).getProductPrice() %></em>
			</p>
			<%
				if(isLogin){			
					session.setAttribute("order", productList.get(i));
					
					%>
					<button class="add-to-cart" type="button" id="add" name="newOrder" onclick = "location.href = 'cart.jsp'">Add to cart</button>
					<%			
				}
			
				else{
					%>
					<button class="add-to-cart" type="button" id="add" name="newOrder" onclick = "location.href = 'Login.jsp'">Add to cart</button>
					<%
				}
			
			%>
			
			
			
		</form>
		</div>
		<%}%>
	</div>
	

</body>
</html>