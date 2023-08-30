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
<title>Insert title here</title>
<style>
	.write-button{
		margin-top : 20px;
		cursor: pointer;
		width: 80px;
		height: 35px;
		color : white;
		background-color: green;
		border-radius: 8px;
		font-size : 15px;
		border: 0.5px solid green; 
	}
	.container{
		width : 100%;
		height : 900px;
		margin : 20px 0 0 0;
		display: flex;
		justify-content: center;
	}
	.write-button-box{
		display: flex;
		justify-content : flex-end;
		margin-top : 20px;
	}
	tbody tr{
		height : 40px;
	}
	.vanner img{
		width : 100%; 
		height : 250px;
		object-fit: cover;
	} 
	.title-box{
		display: flex;
		justify-content: center;
		margin-top : 50px;
	}
	.title{
		width : 600px;
	}
	.title div{
		background-color : gray;
		width : 100px;
		height : 0.5px;
	}
</style>
</head>
<body>
	<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat" %>
	<jsp:useBean id="brddb" class="Restaurant.BbsDAO" scope="page" />
	<jsp:include page="header.jsp"></jsp:include>
	<% 
		//게시 목록을 위한 배열리스트를 자바진즈를 이용하여 확보 
		ArrayList<RestaurantEntity> list = brddb.getBoardList(); 
	   	int counter = list.size();
	   	int row = 0;
	   	
	   	if (counter > 0) {
	%>
		
	<div class = "vanner">
		<img src = "media/vanner.jpg">
	</div>
	<div class = "title-box">
		<div class = "title">
			<h1>게시판</h1>
			<div></div>
		</div>
	</div>
	<div class = "container"> 
		<div class="row">
			<table style="text-align: center; border:1px solid #dddddd; width : 600px;">
				<thead>
					<tr style = "height : 40px;">
						<th style = "background-color : #eeeeee; text-align: center;">번호</th>
						<th style = "background-color : #eeeeee; text-align: center;">음식점</th>
						<th style = "background-color : #eeeeee; text-align: center;">주소</th>
						<th style = "background-color : #eeeeee; text-align : center;">작성자</th>
						<th style = "background-color : #eeeeee; text-align : center;">작성일</th>
						<th style = "background-color : #eeeeee; text-align : center;">조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
					int idCounter = 1;
					for( RestaurantEntity brd : list ) {
						//홀짝으로 다르게 색상 지정
						String color = "papayawhip";
						if ( ++row % 2 == 0 ) color = "white"; 
				
				%>
					<tr bgcolor=<%=color %> 
						onmouseover="this.style.backgroundColor='SkyBlue'"
    					onmouseout="this.style.backgroundColor='<%=color %>'">
						<td><a href="restaurant_page.jsp?id=<%=brd.getId()%>" style = "color : black;"><%= idCounter++ %></a></td>
						<td><%= brd.getRestaurant_name() %></td>
						<td><%= brd.getAddress() %></td>
						<td><%= brd.getUserid() %></td>
						<td><%= brd.getBbsDate() %></td>
						<td><%= brd.getBbsCount() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
	<%
	   	}
	%>
	
			<form name = "write" method = "post" action="write.jsp">
				<div class = "write-button-box">
					<input type = "submit" class = "write-button" value = "글 작성" >	
				</div>			
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>