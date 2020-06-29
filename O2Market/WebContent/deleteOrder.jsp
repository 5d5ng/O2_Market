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
String param = request.getParameter("Dorder");
int cancelNum = Integer.parseInt(param)-1;
OrderProductDao orderDao = new OrderProductDao();
List<OrderProduct> list = orderDao.getOrders();

for(OrderProduct OP:list){
	if(OP.getOrderNumber() == cancelNum){
		orderDao.deleteProduct(cancelNum);
		response.sendRedirect("cart.jsp");
	}
}




%>

</body>
</html>