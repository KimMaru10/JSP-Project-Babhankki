<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식점 상세 페이지</title>

<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script language=JavaScript src="check.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGJgMNIqPEo2wLVbOncDpkuk71-NS9oeU&libraries=places"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/restaurants_page.css" type="text/css" />

</head>
<body onload="initMap()">

	<%@ page import="Restaurant.*"%>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	String userid = "";
	String restaurant_name = "";
	String address = "";
	String bbsContent = "";
	String good_health_cindition = "";
	String photo_file = "";
	int bbsCount = 0;
	String bbsDate = "";

	String id = request.getParameter("id");

	if (id != null) {
		int idnum = Integer.parseInt(id);
		BbsDAO bbsdb = new BbsDAO();
		RestaurantEntity brd = bbsdb.getBoard(idnum);
		userid = brd.getUserid();
		restaurant_name = brd.getRestaurant_name();
		address = brd.getAddress();
		bbsContent = brd.getBbsContent();
		good_health_cindition = brd.getGood_health_condition();
		photo_file = "upload/image/" + brd.getPhoto_file();
		bbsCount = brd.getBbsCount();
		bbsDate = brd.getBbsDate();
	} ;
	%>
	
	
	<jsp:include page="header.jsp"></jsp:include>
	<div class="restaurant_page">
		<div class="container_box">
			<div class="container">
				<div class="restaurant_title">
					<div class="restaurant_name"><%=restaurant_name%></div>
					<%
						if (userID != null) {
							FavoritesDAO favoritesDAO = new FavoritesDAO();
							boolean isFavorite = favoritesDAO.isRestaurantFavorite(userID, Integer.parseInt(id));
					%>
					<div class="right_item">
						<a href="favorites_process.jsp?userID=<%=userID%>&restaurantID=<%=id%>" class="isFavoritesButton" >
       					<% if (isFavorite) { %>
							<div id="favoritesButton" class="favorites_button">
								<i class="fa-regular fa-star"></i>즐겨찾기
							</div>
							<%}else{ %>
							<div id="favoritesButton" class="not_favorites_button">
								<i class="fa-regular fa-star"></i>즐겨찾기
							</div>
							<%} %>
						</a>
					</div>
					<%} %>
				</div>
				<div class="restaurant_count">
					<div class = "UserID">
						<h4>작성자</h4> <p>&nbsp;<%=userid%></p>
					</div>
					<div class="bbsCount">조회수&nbsp;<%=bbsCount%></div>
				</div>
				<div class="food_image">
					<img src="<%=photo_file%>" />
				</div>
				<div class="contents">
					<div>
						<h4>주소</h4>
						<p><%=address%></p>
						<br>
						<h4>작성자 지병</h4>
						<p><%=good_health_cindition%></p>
						<br>
						<h4>리뷰</h4>
						<p><%=bbsContent%></p>

					</div>
				</div>
				<script>
				    function initMap() {
				      // 지도 생성
				      var map = new google.maps.Map(document.getElementById('map'), {
				        zoom: 16, // 확대 수준 설정
				        center: {lat: 37.123, lng: 127.456} // 좌표 설정 (위도, 경도)
				      });
				
				      // 주소를 좌표로 변환
				      var geocoder = new google.maps.Geocoder();
				      var address = "<%=address%>"; // JSP에서 주소 파라미터 받기
				
						geocoder.geocode({
							'address' : address
						}, function(results, status) {
							if (status === 'OK') {
								// 변환된 좌표를 얻음
								var location = results[0].geometry.location;
				
								// 좌표를 중심으로 한 지도 생성
								map.setCenter(location);
				
								// 마커 추가
								var marker = new google.maps.Marker({
									map : map,
									position : location,
									title : address
								});
							} else {
								alert('주소를 찾을 수 없습니다. : ' + status);
							}
						});
					}
				</script>
				<div id="map" style="width: 600px; height: 400px;"></div>
``
				<%
				if (userID != null && userID.equals(userid)) {
				%>
				<div class="change-delete">
					<div class="change-button-box">
						<input type="button" class="write-button" value="수정"
							onClick="location.href='write.jsp?id=<%=id%>'"
							style="background-color: green;">
					</div>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>