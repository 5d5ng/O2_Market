
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="dto.*"%>
<%@page import="dao.*"%>


<html>
<title></title>
<body>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/cart.css">
 <div id="Home" onclick = "location.href = 'index.jsp'">Home<span> &rarr;</span></div><br><br><br>

<div class="container">
  <table id="cart" class="table table-hover table-condensed">
    <thead>
      <tr>
        <th style="width:50%">제품</th>
        <th style="width:10%">가격</th>
        <th style="width:8%">수량</th>
        <th style="width:22%" class="text-center">가격합</th>
        <th style="width:10%"></th>
      </tr>
    </thead>

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
					
					if (Hnum == CartHnum && CID.equals(oProductCID) && oProdcutNum == Pnum) { //OrderProduct객체 중 주문번호,회원아이디,제품번호 셋다 동일한 경우
						//UPDATE문 작성
						orderDao.updateOrderProduct(oProduct.getOrderNumber());
						nowOrderProduct = oProduct;
						
						PHistoryDao.updatePurchaseHisory(nowProduct.getProductPrice(), Hnum); // 이번에 넣을 제품가격을 넣어야함
					
						break;
					}

				}
				if (nowOrderProduct == null) {

					
					nowOrderProduct = new OrderProduct(maxOrderNum + 1, 1,
							customer.getCustomerID(), nowProduct.getProductNumber(),
							shoppingCart.getHistoryNumber());
					
					orderDao.addOrderProduct(nowOrderProduct);

					PHistoryDao.updatePurchaseHisory(nowProduct.getProductPrice(), shoppingCart.getHistoryNumber());

				}

			}
		}

		//히스토리에 OrderProduct 추가하는 부분
		orderList = orderDao.getOrders(); //제품담은 후 다시받아오기
	
	%>

	<div>
	
	

    
    
		<h1><%=customer.getName()%>님의 장바구니 현황입니다.<br><br><br>
		<%
			int totalC = 0;
			if (shoppingCart != null) {
				for (OrderProduct Oproduct : orderList) {
					if (Oproduct.getHistoryNumber() == shoppingCart.getHistoryNumber()) {
						Product tempP = productDao.getProductbyPnum(Oproduct.getProductNumber());
						totalC += Oproduct.getQuantity() * tempP.getProductPrice();
						
						%>
						 <tbody>
					      <tr>
					        <td data-th="Product">
					          <div class="row">
					            <div class="col-sm-2 hidden-xs"><img src="./Category/images/<%=tempP.getProductNumber() %>.jpg" class="img-responsive" /></div>
					            <div class="col-sm-10">
					              <h4 class="nomargin"><%=tempP.getProductName()%></h4>
					            </div>
					          </div>
					        </td>
					        <td data-th="Price"><%= tempP.getProductPrice()%></td>
					        <td data-th="Quantity"><%= Oproduct.getQuantity()%></td>
					        <td data-th="Subtotal" class="text-center"><%= tempP.getProductPrice() * Oproduct.getQuantity()%></td>
					        <td class="actions" data-th="">
					        <td> <button type="button" OnClick="location.href='deleteOrder.jsp?Dorder=<%=Oproduct.getOrderNumber()%>&productnum=<%=Oproduct.getProductNumber()%>' ">제거</button>
					        </td>
					      
					      </tr>
					    </tbody>
		<%
		
					}
				}

			}
		%>




			
		
	</div>

    <tfoot>

      <tr class="visible-xs">
      </tr>
      <tr>
        <td colspan="2" class="hidden-xs"></td>
        <td class="hidden-xs text-center"><strong>총액 : <%=totalC%>원</strong></td>
        
        <%
				session.setAttribute("nowProduct", nowProduct);

				if (shoppingCart != null) {
			%>
			 <td><a href='deliver.jsp?purchase=<%=shoppingCart.getHistoryNumber()%>' class="btn btn-success btn-block">주문하기 <i class="fa fa-angle-right"></i></a></td>
			<%
				} else {
			%>
			<h1>주문할 상품이 없습니다.
			<%
				}
			%>
      </tr>
    </tfoot>
  </table>
</div>
</body>
</html>