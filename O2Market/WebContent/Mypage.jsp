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
Customer customer = (Customer) session.getAttribute("pCustomer");

PurchasHistoryDao PDao = new PurchasHistoryDao();
List<PurchaseHistory> PhList = PDao.getPurchaseHistories();
if(customer!=null){

	String nowID = customer.getCustomerID();
	%>
	<%=nowID %>님의 마이페이지<p>
	<% 
for(PurchaseHistory PH:PhList){
	if(nowID.equals(PH.getCustomerID())){
		%>
		<%= PH.toString() %><p>
		<%
	}
}
}

%>



</body>
</html>