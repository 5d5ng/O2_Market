<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="Background.css">
<style> 
.loginForm{
	position:absolute;
	top:10%;
	left:40%;
}

</style>
</head>
<body>
<div id="name"><a href="index.jsp">O2 Market</a></div>
	<%
		
		session.removeAttribute("pCustomer"); //로그인 초기
		String n = (String) session.getAttribute("fail");
		System.out.println(n);
		if(n!=null){
			%>
			
			<p><%=n %>번 로그인에 실패하였습니다 다시 시도해주세요</p>
			<% 
			
		}
	%>
	<div class = "loginForm">
	<h1>로그인 해주세요.</h1>
	<form action="LoginCheck.jsp" method="post">
		아이디 <input type="text" name="id"><br> 
		비밀번호 <input type="password" name="pwd"><br> 
		<input type="submit" value="로그인">
	</form>
	<button onClick="location.href = 'register.jsp'" > 회원가입</button>
	
	</div>
</body>
</html>