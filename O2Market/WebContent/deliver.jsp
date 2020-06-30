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
<link
   href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
   rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/Background.css">
<title>구매 완료 페이지</title>
</head>
<body>
	 <div id="Home" onclick = "location.href = './index.jsp'">Home<span> &rarr;</span></div>

   <div id="name">
      O2 Market
   </div>
   <h1>Thank YOU!</h1>
   결제완료 배송준비중입니다
   <%
      Customer customer = (Customer) session.getAttribute("pCustomer");

      String BeforePurchase = "결제 대기";
      int cnt = 0;
      PurchasHistoryDao PHDao = new PurchasHistoryDao();
      DeliveryDao DDao = new DeliveryDao();
      ProductDao PDao = new ProductDao();
      List<Delivery> DList = DDao.getDeliveries();

      int maxD = 0;
      for (Delivery d : DList) {
         int dnum = Integer.parseInt(d.getDeliveryID());
         if (dnum > maxD) {
            maxD = dnum;
         }
      }

      if (customer != null) {
 
   %><%=customer.getCustomerID()%>님의 주문이 결제완료되었습니다.
   <p>

      <%
         }

         List<PurchaseHistory> list = PHDao.getPurchaseHistories();
         List<Integer> customerHistory = new LinkedList<>();
         for (PurchaseHistory PH : list) {
            
            if (customer != null && PH.getCustomerID().equals(customer.getCustomerID()) ) { // 이 회원의 구매히스토리에 해당한다면
           
               customerHistory.add(PH.getHistoryNumber());
               if (BeforePurchase.equals(PH.getPaymentStatus())) {
                  PHDao.updatePurchaseStatus(PH.getHistoryNumber());

                  cnt++;

      %>

      <%=cnt%>주문번호 :
      <%=PH.getHistoryNumber()%>번이 결제완료되었습니다.<br>
      결제완료된 금액은 <%=PH.getTotalCost() %> 입니다.
   <p>

      <%
         Delivery delivery = new Delivery(Integer.toString(maxD + 1), "상품준비중", PH.getHistoryNumber());
                  DDao.addDelivery(delivery);
                  DList.add(delivery);

               }
            }
         }

         for (int Hnum : customerHistory) {
            for (Delivery d : DList) {
         
               if (Hnum == d.getHistoryNumber()) {
                  %><br> <!-- 배송현황<%=d.toString()%>  -->

               <%
               }
            }
         }
      %>
   
</body>
</html>