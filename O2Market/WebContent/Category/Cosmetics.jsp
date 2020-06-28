<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="dto.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="category.css">

</head>
<body>
	<div class="wrapper">
		<h1>Clothing</h1>
		<span><i class="shopping-cart"></i></span>
		<div class="clear"></div>
		<div class="items">
			<%
				ProductDao PDao = new ProductDao();
			List<Product> list = PDao.getProduct();
			for (int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i).getCategory());
				if(list.get(i).getCategory().equals("화장품")){
			%>
			<div class="item">
				<img src="./images/<%=list.get(i).getProductNumber()%>.jpg"
					alt="item" />
				<h2><%=list.get(i).getProductName()%></h2>
				<p>
					Price: <em><%=list.get(i).getProductPrice()%></em>
				</p>
				<button class="add-to-cart" type="button">Add to cart</button>
			</div>
			<%
			}
				}
			%>
		</div>
	</div>
</body>
</html>