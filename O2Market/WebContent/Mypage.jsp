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

PurchasHistoryDao PDao = new PurchasHistoryDao();
List<PurchaseHistory> Ph = PDao.getPurchaseHistories();
%>
<%= Ph.get(0).toString() %>


</body>
</html>