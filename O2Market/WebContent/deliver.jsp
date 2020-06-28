<%@page import="dto.PurchaseHistory"%>
<%@page import="dao.PurchasHistoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="dto.*"%>
<%@page import="dao.ProductDao"%>
<%@page import="dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
결제완료 배송준비중입니다

<%
	String BeforePurchase="결제 대기";
	int cnt = 0;
	PurchasHistoryDao PHDao = new PurchasHistoryDao();
	List<PurchaseHistory> list = PHDao.getPurchaseHistories();
	for(PurchaseHistory PH:list){
		if(BeforePurchase.equals(PH.getPaymentStatus())){
			PHDao.updatePurchaseStatus(PH.getHistoryNumber());
			cnt++;
			System.out.print("배송");
			%><%=cnt%> : <%=PH.toString() %><p>
			<% 
			break;
		}
	}
%>
</body>
</html>