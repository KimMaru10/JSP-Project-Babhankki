<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/Mypage.css" type="text/css" />
<title>Insert title here</title>
<style>
	.myPageImg{
		width : 100%;
		height : 250px;
		margin-bottom : 10px;
		background-image : url(media/food.jpg);
		background-repeat: no-repeat;
  		background-position: center;
  		background-size: cover;
	}
</style>
</head>
<body>
<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList, Restaurant.FavoritesEntity, java.text.SimpleDateFormat" %>
<jsp:useBean id="brddb1" class="Restaurant.BbsDAO" scope="page" />
<jsp:useBean id="brddb2" class="Restaurant.FavoritesDAO" scope="page" />
<% 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	//게시 목록을 위한 배열리스트를 자바진즈를 이용하여 확보 
	ArrayList<RestaurantEntity> list = brddb1.getBoardListByUserid(userID); 
	ArrayList<FavoritesEntity> favoritesList = brddb2.getFavoritesListByUserid(userID);
	
   	int counter = list.size();
   	int row = 0;
  	int fcounter = favoritesList.size();
%>
<jsp:include page="header.jsp"></jsp:include>
<div class = "container">
	<div class="myPage">
		<img class="user_img" src="media/myPage.svg">
		<div class="user_name">
			<h3><%=userID %></h3>
			<p>안녕하세요. <%= userID %>님</p>
		</div>
	</div>
	<div class="myPageImg"></div>
	
<% if(fcounter >0){ %>
	<div class= "child">
		<div class="myContent">즐겨찾기 리스트</div>
		<div class = "row">
			<table style="text-align: center; border:1px solid #dddddd; width: 600px;">
				<thead>
					<tr style="height: 40px;">
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;" colspan="2">음식점</th>
						
					</tr>
				</thead>
				<tbody>
				<%
					int cnt = 0;
					for (FavoritesEntity brdd : favoritesList) {
						
						//홀짝으로 다르게 색상 지정
						String color = "papayawhip";
						if (++row % 2 == 0)
							color = "white"; 
						cnt++;
				%>
					<tr bgcolor=<%=color %> onmouseover="this.style.backgroundColor='SkyBlue'"
    					onmouseout="this.style.backgroundColor='<%=color %>'">
						<td><a href="restaurant_page.jsp?id=<%=brdd.getId()%>"><%= cnt %></a></td>
						<td><%= brdd.getRestaurant_name() %></td>
						<td><a href="removeFavorites_process.jsp?userID=<%= userID %>&restaurantID=<%= brdd.getId() %>" style = "color : black;">삭제</a></td>
					</tr>
					
			
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
	<%}else{%>
	<div class="child">
		<div class="myContent" >즐겨찾기 리스트</div>
		<p style = "width : 100%; height : 100px; text-align : center; margin-top : 20px;">즐겨찾기 한 항목이 없습니다.</p>
	</div>
	<%} %>
	
	<%if (counter > 0) { %>
	<div class="child">
		<div class="myContent">회원님이 작성하신 게시물</div>
		<div class="row">
			<table style="text-align: center; border:1px solid #dddddd; width: 600px;">
				<thead>
					<tr style="height: 40px;">
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">음식점</th>
						<th style="background-color: #eeeeee; text-align: center;">주소</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
					for (RestaurantEntity brd : list) {
						//홀짝으로 다르게 색상 지정
						String color = "papayawhip";
						if (++row % 2 == 0)
							color = "white"; 
					
				%>
					<tr bgcolor=<%=color %> onmouseover="this.style.backgroundColor='SkyBlue'"
    					onmouseout="this.style.backgroundColor='<%=color %>'">
						<td><a href="restaurant_page.jsp?id=<%=brd.getId()%>"><%= brd.getId() %></a></td>
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
		</div>
		<form name="write" method="post" action="write.jsp">
			<div class="write-button-box">
				<input type="submit" class="write-button" value="글 작성">
			</div>			
		</form>
	</div>

<%
   } else {
%>		
	<div class="child">
		<div class="myContent" >회원님이 작성하신 게시물</div>
		<p style = "width : 100%; height : 100px; text-align : center; margin-top : 20px;">게시물이 없습니다.</p>
		<form name="write" method="post" action="write.jsp">
			<div class="write-button-box">
				<input type="submit" class="write-button" value="글 작성">
			</div>			
		</form>
	</div>
<%
   }
%>
</div>
</body>
</html>
