<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="login-box-out common" id="login-box">
		<form name="login" method="post" action="login_process.jsp">
			<div style="font-size: 35px">로그인</div>
			<div class="login-porm">
				<p>아이디</p>
				<input type="text" name="userid">
				<p>비밀번호</p>
				<input type="password" name="password"> <input type="submit"
					value="로그인"
					style="color: white; background-color: green; border: 0.5px solid green;">
				<div>
					<span style="color: gray">회원가입 원한다면?</span> <a href="sign_up.jsp"
						style="color: green">회원가입</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>