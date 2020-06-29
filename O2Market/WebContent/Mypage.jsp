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
<link rel="stylesheet" type="text/css" href="Background.css">
<title>Insert title here</title>
</head>
<body>
<div id="name"><a href="index.jsp">O2 Market</a></div>
<%
Customer customer = (Customer) session.getAttribute("pCustomer");
DeliveryDao DDao = new DeliveryDao();
PurchasHistoryDao PHDao = new PurchasHistoryDao();
OrderProductDao OPdao = new OrderProductDao();
ProductDao PDao = new ProductDao();
List<PurchaseHistory> PhList = PHDao.getPurchaseHistories();
List<Delivery> DList = DDao.getDeliveries();


if(customer!=null){

	String nowID = customer.getCustomerID();
	%>
	<%=nowID %>님의 마이페이지<p>
	<% 
	
for(PurchaseHistory PH:PhList){
	if(PH.getTotalCost()>0 && nowID.equals(PH.getCustomerID()) ){
		
		for(Delivery d:DList){
			if(d.getHistoryNumber()==PH.getHistoryNumber()){
		%>
				제품번호<%=PH.getHistoryNumber() %> 의 배송상태는 <%=d.getStatus() %> 입니다.<br>
				주문 상세정보<br>
		<%
			List<OrderProduct> OPList = OPdao.getOrderbyHistroynum(PH.getHistoryNumber());
			for(OrderProduct OP:OPList){
				Product P = PDao.getProductbyPnum(OP.getProductNumber());
				%>
				
				
				구매한 상품 <%=P.getProductName() %> <br>
				구매 수량 <%=OP.getQuantity() %> <br>
				<%=P.getProductPrice() *OP.getQuantity() %> <br>
				
				
				
				
				<%
				
				
				
			}
				
		
		
			}
		}
	}
}
}

%>



</body>
</html>