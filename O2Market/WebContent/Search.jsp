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
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/Background.css">
<title>상품검색</title>
</head>
<body>
 <div id="Home" onclick = "location.href = './index.jsp'">Home<span> &rarr;</span></div>

<div id="name">O2 Market</a></div>
<%
String name = request.getParameter("search"); 

ProductDao PDao = new ProductDao();
List<Product> list = PDao.getProduct();
int ProductNum=-1;
for(int i=1; i<list.size(); i++){
	if(list.get(i).getProductName().equals(name)){
		ProductNum = i;
	}
}

%>
<% 
if(ProductNum == -1){%>
<h1>찾으시는 제품이 없습니다!!</h1>
<% } else{%>
<div class="wrapper">
		<span><i class="shopping-cart"></i></span>
		<div class="clear"></div>
		<div class="items">
			<div class="item">
				<img src="./Category/images/<%=list.get(ProductNum).getProductNumber()%>.jpg"
					alt="item" />
				<h2><%=list.get(ProductNum).getProductName()%></h2>
				<p>
					Price: <em><%=list.get(ProductNum).getProductPrice()%></em>
				</p>
				<button class="add-to-cart" type="button" id="add" name="newOrder" onclick = "location.href = './cart.jsp?order=<%=list.get(ProductNum).getProductNumber()%>'">Add to cart</button>
			</div>

		</div>
	</div>
	<% } %>
</body>
</html>