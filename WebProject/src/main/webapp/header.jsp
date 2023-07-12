<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/header.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
<style>
*{
	margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}
.navbar{
	top: 0;
    left: 0;
    position: fixed;
    width: 100%;
    display: flex;
    justify-content: space-between;
    text-align: center;
    background-color: #fff;
    z-index: 101;
    padding: 0 16px;
    height: 50px;
    box-shadow: inset 0 -1px 0 0 rgba(53,62,58,0.1);
}
.nav-logo{
	display: flex;
    align-items: center;
    margin : 10px 0 0 10px;
	font-size : 40px;
	color : orange;
    
}
.nav-logo img{
	width:40px;
	height: 40px;
}
.nav-logo span{
	margin : 0 0 0 5px;
}

.menu-icon img{
	width:30px;
	height: 30px;
	
}
.nav-menu{
	display: flex;
	
}


.nav-menu-item{
	width: 90px;
    color: #000;
    padding: 3px 0px 3px 0px;
    margin-top: 2px;
    margin-bottom: 3px;
    cursor: pointer;
}

.nav-menu-item span{
	font-size: 10px;
    font-weight: 500;
    line-height: 1.5;
    text-align: center;
    color: #9f9d9c;
    position: relative;
    top: -8px;
    font-family: 'Black Han Sans', sans-serif;
}
a{
	text-decoration: none;
}
.dropdown{
	position : relative;
	display : inline-block;
}

.dropdown-content{
	top : 47px;
	display : none;
	position : absolute;
	z-index : 1;
	width : 100px;
	height : 70px;
	background-color : white;
	padding : 5px;
}
.dropdown-content a{
	display : block;
	text-decoration : none;
	color: #9f9d9c;
	font-size : 18px;
	padding : 5px;
	
}
.dropdown-content a:hover{
	background-color : #ececec;
}
.dropdown:hover .dropdown-content{
	display : block;
}


</style>
</head>
<body>
	<%
	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	
		if(userID == null){ 
	%>
		<nav class="navbar">
			<a href = "main.jsp" class="nav-logo">
					<div><img src="media/icon1.png" alt></div>
					<span style="font-family: 'Black Han Sans', sans-serif">밥한끼</span>
			</a>
			
			<div class = "nav-menu">
				<div class="nav-menu-item">
					<a  href = "main.jsp">
						<div class = "menu-icon"><img src="media/Home.svg" alt></div>
						<span>Home</span>
					</a>
				</div>
				<div class="nav-menu-item">
					<a href = " ">
						<div class = "menu-icon"><img src="media/info.svg" alt></div>
						<span>정보</span>
					</a>
				</div>
			</div>
		</nav>
	
	
	<%
		}else{
	
	%>
		<nav class="navbar">
			<a href = "main.jsp" class="nav-logo">
					<div><img src="media/icon1.png" alt></div>
					<span style="font-family: 'Black Han Sans', sans-serif">밥한끼</span>
			</a>
			
			<div class = "nav-menu">
				<div class="nav-menu-item">
					<a  href = "main.jsp">
						<div class = "menu-icon"><img src="media/Home.svg" alt></div>
						<span>Home</span>
					</a>
				</div>
				<div class="nav-menu-item">
					<a href = "boardlist.jsp">
						<div class = "menu-icon" ><img src="media/board.svg" alt></div>
						<span>게시판</span>
					</a>
				</div>
				<div class="nav-menu-item">
					<a href = " ">
						<div class = "menu-icon"><img src="media/info.svg" alt></div>
						<span>정보</span>
					</a>
				</div>
				<div class = "dropdown nav-menu-item">
						<div class = "menu-icon"><img src="media/account.svg" alt></div>
						<span><%=userID %></span>
						<div class = "dropdown-content">
							<a href = 'Mypage.jsp'>마이페이지</a>
							<a href = "logout_process.jsp">로그아웃</a>
						</div>
				</div>
			</div>
		</nav>
	
	<%
		}
	%>
	
</body>
</html>