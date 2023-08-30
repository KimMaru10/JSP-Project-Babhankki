<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Page</title>
    <script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
	<link rel = "stylesheet" href="css/main_page.css" type="text/css" />
	<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat" %>
	<jsp:useBean id="brddb" class="Restaurant.BbsDAO" scope="page" />
	<%
	ArrayList<RestaurantEntity> list = brddb.getBoardList(); 
   	int counter = list.size();
   	int row = 0;
	
	%>
    <div id="app">
        <%@ page import="Restaurant.BbsDAO" %>
        <%@ page import="Restaurant.RestaurantEntity" %>
        <%@ page import="java.util.ArrayList" %>
        <jsp:include page="header.jsp"></jsp:include>
        <%
	        request.setCharacterEncoding("utf-8");
	        String searchKeyword = request.getParameter("search");
	        String disease = request.getParameter("disease");
	        ArrayList<RestaurantEntity> searchResult = brddb.searchBoardList(searchKeyword, disease);
        	
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
										<option value = "장염 및 소화기 질환">장염 및 소화기 질환</option>
							</select>
						</div>
						
						<input class="search-button" type = "submit" name = "search" value = "검색">
					</div>
				</form>
				<div class="restaurant-container">
				<%if (searchResult.isEmpty()) { %>
		       		 <div class="no-results" style = "width : 100%; height : 100px; text-align : center; margin-top : 50px; font-size : 20px;">검색 결과가 없습니다.</div> 
				<%}else{
				
				
				if (counter > 0) {
					for( RestaurantEntity brd : searchResult ) {
				
				%>
					<div class = "restaurant-item common" onclick="location.href='restaurant_page.jsp?id=<%=brd.getId()%>'">
						<div class = "res-img-container">
							<div >
								<img class = "menu-img" src = "upload/image/<%= brd.getPhoto_file()%>">
							</div>
						</div>	
						<div class = "res-info">
							
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
				}
					%>
				</div>
			</div>
      	</div>
      	<jsp:include page="footer.jsp"></jsp:include>
    </div>
</body>
</html>
