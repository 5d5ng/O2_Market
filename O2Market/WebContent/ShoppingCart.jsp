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
<link rel="stylesheet" type="text/css" href="Cart.css">
<%	ProductDao PDao = new ProductDao();
List<Product> productList = PDao.getProduct(); 
String parm = request.getParameter("order");
int k = Integer.parseInt(parm)-1;
%>

<br><br><br><br><br>
<div id="container">
<table>
  <tr class="p">
    <td class="image"><img src="./Category/images/<%=productList.get(k).getProductNumber() %>.jpg"/></td>
    <td class="name"><%=productList.get(k).getProductName()%></td>
    <td class="price"><%=productList.get(k).getProductPrice()%></td>
    <td class="amount"><input type="number" value="1" min="0" /></td>
    <td class="pricesubtotal"></td>
    <td class="remove"><div>&times</div></td>
  </tr>
  <tr>
    <td> </td>
    <td> </td>
    <td> </td>
    <td>Total Price:</td>
    <td class="totalpricesubtotal"></td>
    <td> </td>
  </tr>
  <tr>
    <td style="border-top:1px solid white" colspan="6"><br />
      <span class="big">Total: <span class="realtotal">0</span></span>
    </td>
  </tr>
</table>
  <div id="checkout">Checkout<span> &rarr;</span></div>
<div id="footer">
  <ul>
    <li>Change the amount of stuff and see the subtotal and total change</li>
    <li>Try to change the amount of items to minus amounts or 0</li>
    <li>Delete items and see the totals change</li>
  </ul>
  <hr />
  Thank you for purchasing our product!
  <br />
  Internet Database Term Project
</div>
</div>

</body>
</html>