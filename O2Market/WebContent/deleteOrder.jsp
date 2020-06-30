<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="dto.*"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
String param1= request.getParameter("Dorder");
String param2 = request.getParameter("productnum");
if(param1==null||param2==null){
	response.sendRedirect("Login.jsp");
}

int cancelNum = Integer.parseInt(param1);
int productNum = Integer.parseInt(param2);
PurchasHistoryDao PHDao= new PurchasHistoryDao();
ProductDao ProductDao = new ProductDao();
OrderProductDao orderDao = new OrderProductDao();
List<Product> ProductList = ProductDao.getProduct();
List<OrderProduct> list = orderDao.getOrders();

Product nowProduct = null;
for(Product p:ProductList){

	if(productNum == p.getProductNumber()){
		nowProduct = p;
	}
	
}



for(OrderProduct OP:list){
	
	if(OP.getOrderNumber() == cancelNum){
		orderDao.deleteProduct(cancelNum);
		
		PHDao.updatePurchaseHisory(-nowProduct.getProductPrice() * OP.getQuantity() , OP.getHistoryNumber());
		ProductDao.updateBackProduct(productNum, OP.getQuantity());
		
		
	}
}


response.sendRedirect("cart.jsp");


%>

</body>
</html>