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
		String InputID = request.getParameter("id");
		String InputPW = request.getParameter("pwd");
		
		CustomerDao dao = new CustomerDao();
		List<Customer> list = dao.getCustomers();
		Customer customer = dao.chkCustomer(InputID, InputPW, list);
		
		if(customer!=null){ //Login Success
			session.setAttribute("pCustomer", customer);
			//System.out.print(customer.getName());
			response.sendRedirect("index.jsp");
			
		}
		
		
		else{ //로그인 실패
			/*
			int trial = 0;
			String fail = (String)session.getAttribute("fail");
			if( fail == null){ // 실패한적이없다면
				trial = 1;
			}
			else{
				trial = Integer.parseInt(fail)+1;		
			}
			

			session.setAttribute("fail", Integer.toString(trial)); // fail 식별자로 trial 넘겨줌
			response.sendRedirect("Login.jsp");
			*/
			%>
			
			<script>alert('로그인  실패'); history.back();</script>
			<% 


		}
		
	
%>

</body>
</html>