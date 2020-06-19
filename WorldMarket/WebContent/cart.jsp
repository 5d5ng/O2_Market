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
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
		Customer customer = (Customer) session.getAttribute("pCustomer");
		if(customer == null){
			%>
				
				<script>alert("로그인이 필요합니다.")</script>
			<%
			
		response.sendRedirect("Login.jsp");
		}
		
		OrderProductDao dao = new OrderProductDao();

		List<OrderProduct>  cartList = dao.getOrders();
		//String s = (String)request.getParameter("newOrder");
		//System.out.print(s);
		
	%>

</body>
</html>