<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link rel = "stylesheet" href="css/main.css" type="text/css" />
<link rel = "stylesheet" href="css/sign_up.css" type = "text/css" />
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class = "page">
      <form action="sign_up_process.jsp" method="post">
        <h1>회원가입</h1>
        
        <fieldset>
          <legend><span class="number">1</span>회원 기본 정보</legend>
          <label for="name">이름:</label>
          <input type="text" id="name" name="name">
          
          <label for = "userid">아이디</label>
          <input type="text" id = "userid" name="userid">
          
          <label for="mail">이메일:</label>
          <input type="email" id="mail" name="email">
          
          <label for="password">비밀번호:</label>
          <input type="password" id="password" name="password">
          
          
        </fieldset>
        
        <fieldset>
          <legend><span class="number">2</span>건강 체크</legend>
        </fieldset>
        <fieldset>
          <label>지병 여부:</label>
	      	<input type="checkbox" id="Diabetes" name = "disease" value="당뇨병"><label class="light" for="Diabetes">당뇨병</label><br>
			<input type="checkbox" id="High_blood_pressure" name = "disease" value="고혈압"><label class="light" for="High_blood_pressure">고혈압</label><br>
	        <input type="checkbox" id="Obesity" name = "disease" value="비만"><label class="light" for="Obesity">비만</label><br>
	        <input type="checkbox" id="hyperlipidemia" name = "disease" value="고지혈증"><label class="light" for="hyperlipidemia">고지혈증</label><br>
	        <input type="checkbox" id="digestive_problem" name = "disease"  value="장염 및 소화기 질환"><label class="light" for="digestive_problem">장염 및 소화기 질환</label>
        </fieldset>
        <button type="submit">회원가입</button>
      </form>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>