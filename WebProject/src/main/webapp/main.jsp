<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link rel = "stylesheet" href="css/main_page.css" type="text/css" />
<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<script>
</script>
</head>
<body>
	<div id = "app">
	<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat" %>
	<jsp:useBean id="brddb" class="Restaurant.BbsDAO" scope="page" />
	
   
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		ArrayList<RestaurantEntity> list = brddb.getBoardList(); 
	   	int counter = list.size();
	   	int row = 0;
		
	%>
		<jsp:include page="header.jsp"></jsp:include>
		<div class="page-content-wrapper" >
			<div class="left-column">
				<form name="search_value" method="post" action="search_page.jsp" >
					<div class="search-bar common">
						<div class="search-box" >
							<div id = "search-icon"><img src="media/searchbar.svg"></div>
							<input type="text" name = "search" placeholder = "음식점 찾기" >
						</div>
						<div class = "select_menu">
							<select name = "disease" >
										<option value = "전체" >전체</option>
								      	<option value = "당뇨병" >당뇨병</option>
								      	<option value = "고혈압">고혈압</option>
								      	<option value = "비만">비만</option>
								      	<option value = "고지혈증">고지혈증</option>
								      	<option value = "크론병">크론병</option>
								      	<option value = "턱관절장애">턱관절장애</option>
										<option value = "장염 및 소화기 질환">장염 및 소화기 질환</option>
							</select>
						</div>
						
						<input class="search-button" type = "submit" name = "search" value = "검색">
					</div>
				</form>
				<div class="restaurant-container">
				<%
				if (counter > 0) {
					for( RestaurantEntity brd : list ) {
				
				%>
					<div class = "restaurant-item common" onclick="location.href='restaurant_page.jsp?id=<%=brd.getId()%>'">
						<div class = "res-img-container">
					
							<div >
								<img class = "menu-img" src = "upload/image/<%= brd.getPhoto_file()%>">
							</div>
						</div>	
						<div class = "res-info">
							<div class = "res-name-favorite">
								<div class = "res-name"><%= brd.getRestaurant_name() %></div>
							</div>
							<div class = "res-possibledisease-location">
								<div class = "possible_disease">
									<div class = "good_disease">
										<div style = "color : green">작성자 지병</div>
										<div><%= brd.getGood_health_condition() %></div>
									</div>
								</div>
								<div class = "res-location">
									<i class="fa-regular fa-location-dot"></i>
									<%= brd.getAddress() %>
								</div>
								<div class = "res-content">
									<%= brd.getBbsContent() %>
								</div>
							</div>
						</div>
								
					</div>
					<%	
						}
				}
					%>
				</div>
			</div>
			<div class="right-column">
			
			<%
				if(userID == null){ 
			%>
				<div class="login-box-out common" id = "login-box">
					<form name="login" method="post" action="login_process.jsp" >
						<div style="font-size:35px">로그인</div>
						<div class = "login-porm">
							<p>아이디</p>
							<input type="text" name = "userid" >
							<p>비밀번호</p>
							<input type="password" name = "password">
							<input type="submit" value = "로그인" style = "color : white; 
								background-color : green; border: 0.5px solid green;">
							<div>
								<span style = "color : gray">회원가입 원한다면?</span>
								<a href = "sign_up.jsp" style="color : green">회원가입</a>
							</div>
						</div>					
					</form>
				</div>
				<div class = "restaurant-ranking-out common" id = "ranking">
					<div class = "ranking" style = "font-size : 40px;"><h3>인기 랭킹</h3></div>
					<%
				        List<String> top3RestaurantNames = brddb.getRankingName();
				        List<Integer> top3RestaurantIDs = brddb.getRankingID();
				
				        for (int i = 0; i < top3RestaurantNames.size(); i++) {
				            String restaurantName = top3RestaurantNames.get(i);
				            int restaurantID = top3RestaurantIDs.get(i);
				    %>
				            <div class = "ranking_num"style = "font-size : 40px;">
				                <a style = "text-decoration : none; color : orange"href="restaurant_page.jsp?id=<%= restaurantID %>"><%= restaurantName %></a>
				            </div>
				    <%
				        }
				    %>
					
					
					
				</div>
			<%
				}else{
			%>
					<div class = "restaurant-ranking-out common" id = "ranking">
					<div class = "ranking" style = "font-size : 40px;"><h3>인기 랭킹</h3></div>
					<%
				        List<String> top3RestaurantNames = brddb.getRankingName();
				        List<Integer> top3RestaurantIDs = brddb.getRankingID();
				
				        for (int i = 0; i < top3RestaurantNames.size(); i++) {
				            String restaurantName = top3RestaurantNames.get(i);
				            int restaurantID = top3RestaurantIDs.get(i);
				    %>
				            <div class = "ranking_num"style = "font-size : 40px;">
				                <a style = "text-decoration : none; color : orange"href="restaurant_page.jsp?id=<%= restaurantID %>"><%= restaurantName %></a>
				            </div>
				    <%
				        }
				    

				}
			%>
			
			</div>
		</div>
	</div>
</body>
</html>