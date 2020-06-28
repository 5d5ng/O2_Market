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
	String loginStatus = "로그인";
	String Mypage = null;

	Customer customer = (Customer) session.getAttribute("pCustomer");
	if(customer != null){
		loginStatus = "로그아웃";
		Mypage = "마이페이지";

		isLogin = true;
	} 
	
	
	ProductDao PDao = new ProductDao();
	List<Product> productList = PDao.getProduct();
	%>





	<br>
	<br>
	<div id="name">World Market</div>
	<button name = "logout" type = "button" onclick="location.href= 'Login.jsp' "><%= loginStatus%></button>
	<% if(Mypage != null) { %>
	<button name = "Mypage" type = "button" onclick="location.href= 'Mypage.jsp' "><%= Mypage%></button>
	<% } %>
	<form action="Search.jsp">
	<div class="box">
		<div class="container-4">
			<input type="search" id="search" name="search" placeholder="Search..." />
			<button class="icon" type="submit">
				<i class="fa fa-search"></i>
			</button>
		</div>
	</div>
	</form>


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
	for(int i=1; i<productList.size();i++){
	%>
		<div class="item">
		<form name =<%=Integer.toString(i) %> method="get" action = "cart.jsp">
			<img src="./Category/images/<%=productList.get(i).getProductNumber() %>.jpg" alt="item" />
			<h2><%= productList.get(i).getProductName() %></h2>
			<p>
				Price: <em><%= productList.get(i).getProductPrice() %></em>
			</p>
			<%
				if(isLogin){

					%>
					<button class="add-to-cart" type="button" id="add" name="newOrder" onclick = "location.href = 'cart.jsp?order=<%=productList.get(i).getProductNumber()%>'">Add to cart</button>

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