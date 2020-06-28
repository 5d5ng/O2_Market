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
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email")+"@"+request.getParameter("email_2");

	/*
	System.out.println(id);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(age);
	System.out.println(email);
*/
	
	CustomerDao dao = new CustomerDao();
	List<Customer> list = dao.getCustomers();
	for (Customer c : list){
			if(c.getCustomerID().equals(id)){
				%>
				<script>alert('동일한 아이디가 존재합니다.'); history.back();</script>
			<% 	
			}
	}
	
	
	Customer c = new Customer(id,pw,name,Integer.parseInt(age),phone,email);
	dao.addCustomer(c);

	response.sendRedirect("Login.jsp");

%>

</body>
</html>