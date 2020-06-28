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

	
		request.setCharacterEncoding("euc-kr");
		Customer customer = (Customer) session.getAttribute("pCustomer"); //로그인 고객

		
		if (customer == null) {
			System.out.print("sssqs");
			response.sendRedirect("Login.jsp");
		}
		

		OrderProductDao orderDao = new OrderProductDao();
		ProductDao productDao = new ProductDao();
		
		String parm = request.getParameter("order");
		int ProductNum = Integer.parseInt(parm)-1; // 제품 파라미터로 받아옴
		System.out.println(ProductNum);
		
		PurchasHistoryDao PHistoryDao = new PurchasHistoryDao();

		List<OrderProduct> orderList = orderDao.getOrders();
		List<Product> productList = productDao.getProduct();
		List<PurchaseHistory> historyList = PHistoryDao.getPurchaseHistories(); // 현재 로그인 고객의 구매리스트

		String cID = customer.getCustomerID();
		String status = "결제 대기"; // 결제전이라는 의미

//		Product nowProduct = (Product) session.getAttribute("order"); //담을 제품
		Product nowProduct = productList.get(ProductNum);	
//session.removeAttribute("order");
		System.out.println(nowProduct.getProductName());
		

		//System.out.print(nowProduct.toString());
		PurchaseHistory shoppingCart = null;
		OrderProduct nowOrderProduct = null; // 
 
		for (PurchaseHistory history : historyList) {
			if (cID.equals(history.getCustomerID()) && status.equals(history.getPaymentStatus().trim())) { //결제하기 전 상태이고 CID에 해당하는 히스토리가 있다면 불러온다.
				shoppingCart = history;
				break;
			}
		}

		
		
		
		
		if (shoppingCart == null) { //장바구니를 새로 만들어야한다면
			
			int Hnum = historyList.size() + 1;
			String customerID = customer.getCustomerID();
			int cost = nowProduct.getProductPrice();
			int Onum = orderList.size() + 1;
			int Pnum = nowProduct.getProductNumber();
			
			shoppingCart = new PurchaseHistory(Hnum, customerID, cost, status);
			PHistoryDao.addPurchaseHistory(shoppingCart); // 새로운 구매정보 즉 장바구니 추가

			//OrderProduct추가
			nowOrderProduct = new OrderProduct(Onum, 1, customerID, Pnum, Hnum);
			orderDao.addOrderProduct(nowOrderProduct);

		}
		else{ //결제완료 안한 장바구니가 존재한다면 OrderProduct만 추가한다.
			
			for(OrderProduct oProduct: orderList){
				int Hnum = oProduct.getHistoryNumber();
				int CartHnum = shoppingCart.getHistoryNumber();
				String CID = customer.getCustomerID();
				String oProductCID = oProduct.getCustomerID();
				int Pnum = nowProduct.getProductNumber();
				int oProdcutNum = oProduct.getProductNumber();
				
				if(Hnum == CartHnum && CID.equals(oProductCID) && oProdcutNum == Pnum){ //OrderProduct객체 중 주문번호,회원아이디,제품번호 셋다 동일한 경우
						//UPDATE문 작성
					orderDao.updateOrderProduct(oProdcutNum);
					PHistoryDao.updatePurchaseHisory(nowProduct.getProductPrice(), Hnum); // 이번에 넣을 제품가격을 넣어야함
					break;
				}
				
			}
			if(nowOrderProduct == null){
				nowOrderProduct = new OrderProduct(orderList.size()+1,1,customer.getCustomerID(),nowProduct.getProductNumber(),shoppingCart.getHistoryNumber());
				orderDao.addOrderProduct(nowOrderProduct);
				
			}
			
			
			
		}
		
		//히스토리에 OrderProduct 추가하는 부분

		List<PurchaseHistory> nowHistory = PHistoryDao.getCustomerHistories(customer.getCustomerID()); // 현재 로그인 고객의 구매리스트
		
	%>

	<div>
		<%=customer.getName()%>님의 장바구니 현황입니다.<br>
		<%
		int cnt = 0;
		for(PurchaseHistory PH: nowHistory ){
			cnt++;
			List<OrderProduct> oList = new LinkedList<OrderProduct>();
			oList = orderDao.getOrderbyHistroynum(PH.getHistoryNumber());
			%>번호 <%=cnt%><%=PH.toString() %><br>
			<%for(OrderProduct Oproduct:oList){
				
				 %>
					상품 내역<%=Oproduct.toString() %><br>
					제품 정보<%=productDao.getProductbyPnum(Oproduct.getProductNumber()).toString() %>
					<% 
				
			}
		}
		%>
	</div>




</body>
</html>