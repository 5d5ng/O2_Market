<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="Background.css">
<title>회원가입</title>

<style>
#wrap {
	width: 530px;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

table {
	margin-left: auto;
	margin-right: auto;
	border: 3px solid skyblue
}

td {
	border: 1px solid skyblue
}

#title {
	background-color: skyblue
}
</style>
</head>
<body>
	<!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
	<div id="wrap">
		<br>
		<br> <b><font size="6">회원가입</font></b> <br>
		<br>
		<br>
		<!-- 입력한 값을 전송하기 위해 form 태그를 사용한다 -->

		<form name ="f" method="post" >
			<table>
				<tr>
					<td id="title">아이디</td>
					<td><input type="text" name="id" maxlength="20">
					</td>
				</tr>
				<tr>
					<td id="title">비밀번호</td>
					<td><input type="password" name="password" maxlength="15">
					</td>
				</tr>

				<tr>
					<td id="title">비밀번호 확인</td>
					<td><input type="password" name="passwordcheck" maxlength="15">
					</td>
				</tr>

				<tr>
					<td id="title">이름</td>
					<td><input type="text" name="name" maxlength="40"></td>
				</tr>

	<tr>
					<td id="title">나이</td>
					<td><input type="number" name="age" maxlength="3"></td>
				</tr>

				<tr>
					<td id="title">성별</td>
					<td><input type="radio" name="gender" value="남" checked>남
						<input type="radio" name="gender" value="여" checked>여</td>
				</tr>


				<tr>
					<td id="title">이메일</td>
					<td><input type="text" name="email" maxlength="30">@
						<select name="email_2">
							<option>naver.com</option>
							<option>gmail.com</option>

					</select></td>
				</tr>

				<tr>
					<td id="title">휴대전화</td>
					<td><input type="text" name="phone" /></td>
				</tr>

			</table>
			<br> <input type="submit" value="가입" onclick ="input_chk()"/> <input type="reset" value="취소" onclick="location.href = 'index.jsp'"
				>
		</form>
	</div>
	<script>
    function input_chk(){
    	if(document.f.name.value == ""){
            alert("이름을 입력하세요");
            document.f.name.focus();
            return;
        }
       
        if(document.f.id.value == ""){
            alert("아이디를 입력하세요");
            document.f.id.focus();
            return;
        }
       
        if(document.f.password.value == ""){
            alert("패스워드를 입력하세요");
            document.f.pw.focus();
            return;
        } else if (document.f.password.value != document.f.passwordcheck.value){
            alert("암호가 일치하지 않습니다. 다시 입력하세요");
            document.f.pw.value = "";
            document.f.pwc.value = "";
            document.f.pwd.focus();
            return;
        }
   
       
        //요청 URL
        document.f.action = "chk_register.jsp";
   		
    }
    </script>
</body>
</html>

