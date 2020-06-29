
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
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="Background.css">
<title>장바구니</title>
</head>
<body>
	<div id="name">
		<a href="index.jsp">O2 Market</a>
	</div>
	<%
		int maxOrderNum = 0;
		request.setCharacterEncoding("euc-kr");
		OrderProductDao orderDao = new OrderProductDao();
		ProductDao productDao = new ProductDao();
		Customer customer = (Customer) session.getAttribute("pCustomer"); //로그인 고객
		String cID = null;
		String status = "결제 대기"; // 결제전이라는 의미

		if (customer == null) {
			response.sendRedirect("Login.jsp");
		}
		cID = customer.getCustomerID();

		String parm = request.getParameter("order");
		int ProductNum = -1;
		if (parm != null) {
			ProductNum = Integer.parseInt(parm) - 1; // 제품 파라미터로 받아옴

		}

		PurchasHistoryDao PHistoryDao = new PurchasHistoryDao();

		List<OrderProduct> orderList = orderDao.getOrders();
		List<Product> productList = productDao.getProduct();
		List<PurchaseHistory> historyList = PHistoryDao.getPurchaseHistories(); // 현재 로그인 고객의 구매리스트

		for (OrderProduct Oproduct : orderList) {
			if (maxOrderNum < Oproduct.getOrderNumber()) {
				maxOrderNum = Oproduct.getOrderNumber();
			}

		}

		Product nowProduct = null;
		if (ProductNum >= 0) {
			nowProduct = productList.get(ProductNum);
			System.out.println(nowProduct.getProductName());
		}

		PurchaseHistory shoppingCart = null;
		OrderProduct nowOrderProduct = null;

		for (PurchaseHistory history : historyList) { //이미 장바구니가 존재하는 경우
			if (cID.equals(history.getCustomerID()) && status.equals(history.getPaymentStatus().trim())) { //결제하기 전 상태이고 CID에 해당하는 히스토리가 있다면 불러온다.
				shoppingCart = history;
				break;
			}
		}
		if (nowProduct != null) {
			productDao.updateProduct(nowProduct.getProductNumber());

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

			} else { //결제완료 안한 장바구니가 존재한다면 OrderProduct만 추가한다.

				for (OrderProduct oProduct : orderList) {
					int Hnum = oProduct.getHistoryNumber();
					int CartHnum = shoppingCart.getHistoryNumber();
					String CID = customer.getCustomerID();
					String oProductCID = oProduct.getCustomerID();
					int Pnum = nowProduct.getProductNumber();
					int oProdcutNum = oProduct.getProductNumber();
					System.out.println("비교해보기:" + Hnum + " " + CartHnum + " " + CID + " " + oProductCID + " "
							+ oProdcutNum + " " + Pnum);
					if (Hnum == CartHnum && CID.equals(oProductCID) && oProdcutNum == Pnum) { //OrderProduct객체 중 주문번호,회원아이디,제품번호 셋다 동일한 경우
						//UPDATE문 작성
						orderDao.updateOrderProduct(oProduct.getOrderNumber());
						nowOrderProduct = oProduct;
						System.out.println("여기다!여기!");
						PHistoryDao.updatePurchaseHisory(nowProduct.getProductPrice(), Hnum); // 이번에 넣을 제품가격을 넣어야함
						System.out.println("동일제품존재");
						break;
					}

				}
				if (nowOrderProduct == null) {

					
					nowOrderProduct = new OrderProduct(maxOrderNum + 1, 1,
							customer.getCustomerID(), nowProduct.getProductNumber(),
							shoppingCart.getHistoryNumber());
					System.out.println("여기다!여기!123");
					System.out.println(nowOrderProduct.toString());
					orderDao.addOrderProduct(nowOrderProduct);

					PHistoryDao.updatePurchaseHisory(nowProduct.getProductPrice(), shoppingCart.getHistoryNumber());

				}

			}
		}

		//히스토리에 OrderProduct 추가하는 부분
		orderList = orderDao.getOrders(); //제품담은 후 다시받아오기
	%>

	<div>

		<%=customer.getName()%>님의 장바구니 현황입니다.<br>
		<%
			int totalC = 0;
			if (shoppingCart != null) {
				for (OrderProduct Oproduct : orderList) {
					if (Oproduct.getHistoryNumber() == shoppingCart.getHistoryNumber()) {
						Product tempP = productDao.getProductbyPnum(Oproduct.getProductNumber());
						totalC += Oproduct.getQuantity() * tempP.getProductPrice();
						System.out.println(Oproduct.getQuantity()+" "+tempP.getProductPrice());
		%>
		제품 정보<br><%=tempP.toString()%>
		주문량 :
		<%=Oproduct.getQuantity()%>

		<button type="button"
			OnClick="location.href='deleteOrder.jsp?Dorder=<%=Oproduct.getOrderNumber()%>&productnum=<%=Oproduct.getProductNumber()%>' ">상품
			장바구니에서 제거</button>
		<br>


		<%
			System.out.println(Oproduct.toString());
					}
				}

			}
		%>




		총 결제금액<%=totalC%>

		<p>

			<%
				session.setAttribute("nowProduct", nowProduct);

				if (shoppingCart != null) {
			%>
			<button type="button" class="navyBtn"
				onClick="location.href='deliver.jsp?purchase=<%=shoppingCart.getHistoryNumber()%>'">주문하기</button>
			<%
				} else {
			%>
			주문할 상품이 없습니다.
			<%
				}
			%>
		
	</div>




</body>
</html>